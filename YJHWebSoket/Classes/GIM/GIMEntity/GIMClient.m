//
//  GIMClient.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMClient.h"
#import "GIMRequest.h"
#import "GIMResponse.h"
#import "GIMSocket.h"

@implementation GIMClient

static GIMClient *client = nil;

+ (instancetype)sharedClient{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        client = [[GIMClient alloc] init];
        client.chatManager = [[GIMChatManager alloc] init];
        client.groupManager = [[GIMGroupManager alloc] init];
    });
    
    return client;
}

- (void)loginWithConfig:(GIMConfig *)config completion:(void (^)(GIMConfig *, NSError *))completion{
    
    self.currentID = config.ID;
    [GIMRequest webChatToken:config.token success:^(NSURLSessionDataTask *task, GIMResponse *response) {
        
        NSString *urlStr= [NSString stringWithFormat:@"%@",response.data[@"server"]];
        [[GIMSocket sharedSocket] connectToSocket:[NSURL URLWithString:urlStr] completion:completion];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion) {
            completion(config, error);
        }
    }];
}

- (void)connectionStateDidChange:(void (^)(GIMConnectionState))callBack{
    
    [[GIMSocket sharedSocket] setConnectionStateChangeBlock:callBack];
}

- (void)disConnectSocket{
    
    [[GIMSocket sharedSocket] disConnect];
}

@end
