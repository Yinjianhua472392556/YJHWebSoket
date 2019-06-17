//
//  GIMConfig.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMConfig.h"
#import "MJExtension.h"

@implementation GIMConfig

MJExtensionCodingImplementation

static GIMConfig *config;
static NSString * configPath = @"config.data";
+ (instancetype)configUserID:(NSString *)userId token:(NSString *)accessToken appId:(NSString *)appId nickName:(NSString *)nickName avatar:(NSString *)avatar location:(NSString *)location{
    
//    if (!config) {
    
        config = [[GIMConfig alloc] initWithUserID:userId token:accessToken appId:appId nickName:nickName avatar:avatar location:location];
        NSString *url = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:configPath];
        [NSKeyedArchiver archiveRootObject:config toFile:url];
//    }
    
    return config;
}

+ (void)archive{
    
    if (config) {
        
        NSString *url = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:configPath];
        [NSKeyedArchiver archiveRootObject:config toFile:url];
    }
}

+ (instancetype)sharedConfiguration{
    
    if (config) return config;
    
    NSString *url = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:configPath];
    config = [NSKeyedUnarchiver unarchiveObjectWithFile:url];
    
    return config;
}

- (instancetype)initWithUserID:(NSString *)userId token:(NSString *)accessToken appId:(NSString *)appId nickName:(NSString *)nickName avatar:(NSString *)avatar location:(NSString *)location {
    
    if (self = [super init]) {
        
        _ID = [userId copy];
        _token = [accessToken copy];
        _appId = [appId copy];
        _nickName = [nickName copy];
        _avatar = [avatar copy];
        _location = [location copy];
    }
    
    return self;
}

+ (void)clearData {
    
    if (config) {
        
        config.ID = nil;
        config.token = nil;
        config.appId = nil;
        config.nickName = nil;
        config.avatar = nil;
        config.location = nil;
        config.serverDomain = nil;
        
        config = nil;
    }
}

@end
