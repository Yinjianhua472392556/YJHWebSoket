//
//  GIMRequest.h
//  WebSocket
//
//  Created by  on 2017/5/16.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GIMRequest, GIMResponse;
@protocol AFURLResponseSerialization;
/**
 请求成功的回调
 
 @param task 网络请求的对象
 @param response 服务器返回的数据,若是可以转换成相应的model,这个就是转换之后的model,否则就是服务器返回的数据
 */
typedef void(^ResponseBlock)(NSURLSessionDataTask *task, GIMResponse *response);
/**
 网络请求失败的回调
 
 @param task 网络请求的对象
 @param error 请求错误的描述信息
 */
typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

/**
 请求进度
 
 @param progress 表示进度的参数
 */
typedef void(^Progress)(NSProgress *progress);

@interface GIMRequest : NSObject

/**
 请求的参数
 */
@property (nonatomic, strong) NSDictionary *requestHead;
/**
 请求超时时间,默认60秒
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

- (NSURLSessionDataTask *)Post:(NSString *)path parameters:(id)params progress:(Progress)progress success:(void (^)(NSURLSessionDataTask * task, id responseObject))success failure:(FailureBlock)failure;

/**
 获取聊天服务器

 @param token 超级APP登录接口返回的token
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (instancetype)webChatToken:(NSString *)token success:(ResponseBlock)success failure:(FailureBlock)failure;

/**
 发送消息

 @param message 发送的消息内容
 @param userId 接收人的ID
 */
+ (instancetype)sendMessage:(id)message to:(NSString *)userId progress:(Progress)progress success:(ResponseBlock)success faiure:(FailureBlock)failure;

@end
