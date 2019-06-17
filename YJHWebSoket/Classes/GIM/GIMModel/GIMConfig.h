//
//  GIMConfig.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GIMConfig : NSObject

/**
 用户ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 用户登陆之后的token
 */
@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *serverDomain;

/**
 实例化socket的配置文件
 
 @param userId 链接到的主机
 @param accessToken 主机的端口
 @param appId  用户的appId
 @param nickName 昵称
 @param avatar 头像
 @param location 位子
 @return 实例化单例对象
 */
+ (instancetype)configUserID:(NSString *)userId token:(NSString *)accessToken appId:(NSString *)appId nickName:(NSString *)nickName avatar:(NSString *)avatar location:(NSString *)location;

+ (void)archive;

+ (instancetype)sharedConfiguration;

+ (void)clearData;

@end
