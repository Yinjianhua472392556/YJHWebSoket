//
//  GIMRequest.m
//  WebSocket
//
//  Created by  on 2017/5/16.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMRequest.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "GIMConfig.h"
#import "GIMResponse.h"
#import "GIMGroup.h"
#import "GIMGroupMember.h"

@implementation GIMRequest

- (NSURLSessionDataTask *)Post:(NSString *)path parameters:(id)params progress:(Progress)progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(FailureBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    if (self.requestHead) {//设置请求头
        
        [self.requestHead enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    } else {
        
        [manager.requestSerializer setValue:[GIMConfig sharedConfiguration].token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"999929403" forHTTPHeaderField:@"appId"];
    }
    
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    
    NSString *url = [[GIMConfig sharedConfiguration].serverDomain stringByAppendingPathComponent:path] ?: path;
    __block Progress pro = progress;
    __block void (^response)(NSURLSessionDataTask * _Nonnull, id  _Nullable) = success;
    __block FailureBlock failed = failure;
    
    NSURLSessionDataTask *task = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (pro) {
            pro(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (response) {
            response(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failed) {
            failed(task, error);
        }
    }];
    return task;
}

- (void)handleResponse:(id)responseObject task:(NSURLSessionDataTask *)task success:(ResponseBlock)success failure:(FailureBlock)failure errorDomain:(NSString *)domain{
    
    if ([responseObject[@"code"] intValue] == 0) {
        GIMResponse *response = [GIMResponse mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(task, response);
        }
    }  else {
        
        if (failure) {
            
            NSString *success = @"0";
            if ([responseObject objectForKey:@"success"]) {
                success = responseObject[@"success"];
            }
            
            NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"code"] integerValue] userInfo:@{@"code" : responseObject[@"code"], @"message" : responseObject[@"message"], @"success" : success}];
            failure(task, error);
        }
    }
}

+ (instancetype)webChatToken:(NSString *)token success:(ResponseBlock)success failure:(FailureBlock)failure{
    
    GIMRequest *request = [[GIMRequest alloc] init];
    [request Post:@"webchat/token" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [request handleResponse:responseObject task:task success:success failure:failure errorDomain:@"com.gimSocket.webChatToken"];
    } failure:failure];
    
    return request;
}

+ (instancetype)sendMessage:(id)message to:(NSString *)userId progress:(Progress)progress success:(ResponseBlock)success faiure:(FailureBlock)failure {
    
    GIMRequest *request = [[GIMRequest alloc] init];
    [request Post:@"webchat/sendmsg" parameters:@{@"friGuserId" : userId, @"content" : message} progress:progress success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [request handleResponse:responseObject task:task success:success failure:failure errorDomain:@"com.gimSocket.sendMessage"];
    } failure:failure];
    
    return request;
}



@end
