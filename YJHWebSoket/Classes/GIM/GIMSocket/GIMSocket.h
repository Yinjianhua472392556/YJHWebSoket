//
//  GIMSocket.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMConfig.h"
#import "GIMClient.h"

@interface GIMSocket : NSObject

/**
 与聊天服务器的连接状态发生改变的时候的回调
 */
@property (nonatomic, copy) void (^connectionStateChangeBlock)(GIMConnectionState state);

+ (instancetype)sharedSocket;

/**
 链接到指定的服务器

 @param url 服务器的地址
 @param completion 链接之后的回调
 */
- (void)connectToSocket:(NSURL *)url completion:(void (^)(GIMConfig *config, NSError *error))completion;

/**
 断开连接
 */
- (void)disConnect;

/**
 设置收到消息时的回调

 @param receivedMessage 收到消息的回调
 @param tag 标记
 */
- (void)setReceivedMessageCallBack:(void (^)(GIMMessage *message))receivedMessage tag:(NSString *)tag;

/**
 根据设置的标签删除回调

 @param tag 设置的回调标签
 */
- (void)removeCallBackWithTag:(NSString *)tag;

@end
