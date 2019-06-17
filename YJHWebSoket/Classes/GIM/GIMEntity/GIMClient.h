//
//  GIMClient.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMChatManager.h"
#import "GIMConfig.h"
#import "GIMGroupManager.h"

typedef NS_ENUM(NSUInteger, GIMConnectionState) {
    
    GIMConnectionStateConnected,    //链接状态
    GIMConnectionStateDisconnected  //断开状态,手动断开或者网络原因导致的断开
};

@interface GIMClient : NSObject

/**
 聊天模块
 */
@property (nonatomic, strong) GIMChatManager *chatManager;

/**
 群组模块
 */
@property (nonatomic, strong) GIMGroupManager *groupManager;

/**
 当前登录的ID
 */
@property (nonatomic, strong) NSString *currentID;

/**
 聊天的单例
 */
+ (instancetype)sharedClient;

/**
 登录聊天服务器
 
 @param config 登录聊天服务器所需要的配置信息
 @param completion 登录完成时的回调
 */
- (void)loginWithConfig:(GIMConfig *)config completion:(void (^)(GIMConfig *config, NSError *error))completion;

/**
 登录状态发生改变时的回调
 
 @param callBack 当登录的状态发生改变时会回调
 */
- (void)connectionStateDidChange:(void (^)(GIMConnectionState state))callBack;

/**
 断开连接
 */
- (void)disConnectSocket;

@end
