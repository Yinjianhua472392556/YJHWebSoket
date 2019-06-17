//
//  GIMSocket.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMSocket.h"
#import "SRWebSocket.h"
#import "GIMMessage.h"
#import "MJExtension.h"
#import "GIMDataManager.h"
#import "GIMTimer.h"
#import "AFNetworkReachabilityManager.h"
#import <arpa/inet.h>
#import "GIMClient.h"
#import "SCHCLNetWorkManger.h"

@interface GIMSocket ()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socket;
@property (nonatomic, strong, readonly) NSURL *socketUrl;
@property (nonatomic, strong) GIMTimer *timer;
@property (nonatomic, copy) void (^completion)(GIMConfig *, NSError *);
@property (nonatomic, strong) NSOperationQueue *sockQueue;
@property (nonatomic) GIMConnectionState state;
@property (nonatomic, strong) NSMutableDictionary<id, void (^)(GIMMessage *message)> *callBacks;

@end

@implementation GIMSocket

static GIMSocket *gim = nil;
static NSUInteger reConnectCount = 0;
static NSTimeInterval reConnectTimeInterval = 5;

+ (instancetype)sharedSocket{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gim = [[GIMSocket alloc] init];
        gim.callBacks = [NSMutableDictionary dictionary];
        [gim monitorNetWork];
    });
    return gim;
}

- (void)connectToSocket:(NSURL *)url completion:(void (^)(GIMConfig *, NSError *))completion{
    
    self.completion = completion;
    self.socket = [[SRWebSocket alloc] initWithURL:url];
    [self.socket setDelegateOperationQueue:self.sockQueue];
    self.socket.delegate = self;
    self -> _socketUrl = url;
    [self.socket open];
}

- (void)disConnect{
    
    [self.socket close];
}

/**
 webSocket已经连接打开，可以进行数据交互了
 */
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    
    NSLog(@"连接成功");
    if (self.completion) {
        self.completion([GIMConfig sharedConfiguration], nil);
        self.completion = nil;
    }
    [self.timer invalidateTimer];
    reConnectCount = 0;
    //通知已经连上了服务器
    self.state = GIMConnectionStateConnected;
}

/**
 连接失败，可以可能是网路原因等被动断开
 */
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    
    NSLog(@"连接失败:%@",error);
    if (self.completion) {
        self.completion([GIMConfig sharedConfiguration], error);
        self.completion = nil;
    }
    self.state = GIMConnectionStateDisconnected;
    //1.先判断网络状态
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityStatus status = mgr.networkReachabilityStatus;
    //2.如果断网则直接返回
    if (status == AFNetworkReachabilityStatusNotReachable) return;
    //3.如果是其他网络状态，先判断可达性
    BOOL isReachability = [self socketReachability];
    //4.如果网络状态不可达，直接返回
    if (!isReachability) return;
    //5.网络状态可达，开始重连操作
    [self.timer execute:self action:@selector(reConnectSocket) timeInterval:reConnectTimeInterval];
}

/**
 socket被关闭，是调用了[webSocket close]方法主动断开的，不是网络等原因被动断开的
 */
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    
    NSLog(@"关闭 socket:%ld", code);
    webSocket = nil;
    self.state = GIMConnectionStateDisconnected;
    
    if ([GIMConfig sharedConfiguration].token.length && ![[GIMConfig sharedConfiguration].token isEqualToString:@"(null)"] && ![[GIMConfig sharedConfiguration].token isEqualToString:@"<null>"]) {

        [self reConnectSocket];
    }
}

/**
 webSocket接收到消息
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
    NSLog(@"received message:%@", message);
    GIMMessage *messageModel = [GIMMessage mj_objectWithKeyValues:message];
    
//    if (messageModel.chatType == GIMConversationTypeGroupChat && [messageModel.socialGroup.ID isEqualToString:AgentGroupID]) {
//
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:AgentNotificationName object:message];
//        }];
//    }
//
//    if ([message rangeOfString:@"名片喜报"].location != NSNotFound) {
//
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:OrderNotificationName object:message];
//        }];
//    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate date];
    messageModel.messageTime = [dateFormatter stringFromDate:date];
    
    if (messageModel.messageType == 0) {
        
        messageModel.ext = message;
    }
    
    //1.不管什么情况，先把数据转发出去
    [self.callBacks enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, void (^ _Nonnull obj)(GIMMessage *), BOOL * _Nonnull stop) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
            obj(messageModel);
        }];
    }];
    //2.如果符合条件，就存储在数据库中
    if (messageModel.chatType == GIMConversationTypeSingleChat) {
        
        [[GIMDataManager sharedManager] openTable:messageModel.conversationID completion:^(NSError *error) {
            
            if (!error) {
                
                [[GIMDataManager sharedManager] insertMessageItem:messageModel];
            }
        }];
    }
}

- (void)reConnectSocket{
    
    //因为网络差的时候，连接操作可能会比较耗时，所以若是正在连接就直接返回
    if (self.socket.readyState == SR_CONNECTING) return;
    
//    if (reConnectCount >= 10 || ![self socketReachability]) {
//        [self.timer invalidateTimer];
//        self.timer = nil;
//        return;
//    }
    
//    reConnectCount++;
    [[GIMClient sharedClient] loginWithConfig:[GIMConfig sharedConfiguration] completion:nil];
}

- (void)monitorNetWork{
    
    __weak typeof(self) weakSelf = self;
    [SCHCLNetWorkManger shareManger].socketBeginConnect = ^{
        
        if (weakSelf.socket.readyState == SR_CLOSED) {//socket = nil说明是手动断开的或者从来没连接过，则不需要重连。
            
            [weakSelf.sockQueue addOperationWithBlock:^{
                
                //判断是否有网络连接,因为若是网络不通。会耗时很久，所以切换到子线程操作
                BOOL canConnect = [weakSelf socketReachability];
                if (canConnect) {
                    
                    [weakSelf.timer execute:weakSelf action:@selector(reConnectSocket) timeInterval:reConnectTimeInterval];
                }
            }];
        }
    };
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    __weak typeof(self) weakSelf = self;
//    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//
//        if (weakSelf.socket.readyState == SR_CLOSED) {//socket = nil说明是手动断开的或者从来没连接过，则不需要重连。
//
//            [weakSelf.sockQueue addOperationWithBlock:^{
//
//                //判断是否有网络连接,因为若是网络不通。会耗时很久，所以切换到子线程操作
//                BOOL canConnect = [weakSelf socketReachability];
//                if (canConnect) {
//
//                    [weakSelf.timer execute:weakSelf action:@selector(reConnectSocket) timeInterval:reConnectTimeInterval];
//                }
//            }];
//        }
//    }];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (BOOL)socketReachability {
    
    // 客户端 AF_INET:ipv4  SOCK_STREAM:TCP链接
    int socketNumber = socket(AF_INET, SOCK_STREAM, 0);
    // 配置服务器端套接字
    struct sockaddr_in serverAddress;
    // 设置服务器ipv4
    serverAddress.sin_family = AF_INET;
    // 百度的ip
    serverAddress.sin_addr.s_addr = inet_addr("202.108.22.5");
    // 设置端口号，HTTP默认80端口
    serverAddress.sin_port = htons(80);//80
    if (connect(socketNumber, (const struct sockaddr *)&serverAddress, sizeof(serverAddress)) == 0) {
        close(socketNumber);
        return true;
    }
    close(socketNumber);;
    return false;
}

- (GIMTimer *)timer{
    
    if (!_timer) {
        
        _timer = [[GIMTimer alloc] init];
    }
    
    return _timer;
}

- (NSOperationQueue *)sockQueue{
    
    if (!_sockQueue) {
        
        _sockQueue = [[NSOperationQueue alloc] init];
        _sockQueue.maxConcurrentOperationCount = 1;
        _sockQueue.qualityOfService = NSQualityOfServiceBackground;
    }
    
    return _sockQueue;
}

- (void)setState:(GIMConnectionState)state{
    
    if (_state == state) return;
    if (self.connectionStateChangeBlock) {
        
        self.connectionStateChangeBlock(state);
    }
}

- (void)setReceivedMessageCallBack:(void (^)(GIMMessage *))receivedMessage tag:(NSString *)tag{
    
    if (receivedMessage) {
        
        if ([self.callBacks.allKeys containsObject:tag]) {
            
            [self .callBacks removeObjectForKey:tag];
        }
        [self.callBacks setObject:receivedMessage forKey:tag];
    }
}

- (void)removeCallBackWithTag:(NSString *)tag{
    
    if ([self.callBacks.allKeys containsObject:tag]) {
        
        [self.callBacks removeObjectForKey:tag];
    }
}

@end
