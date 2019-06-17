//
//  SCHCLNetWorkManger.h
//  SuperCard
//
//  Created by  on 2018/12/11.
//  Copyright © 2018年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^socketBeginConnect)(void);

@interface SCHCLNetWorkManger : NSObject

@property (nonatomic, strong) NSMutableDictionary <id,void(^)(void)> *noNetDictionary;

@property (nonatomic, strong) NSMutableDictionary <id,void(^)(void)> *hasNetDictionary;

@property (nonatomic, strong) NSMutableDictionary <id,void(^)(void)> *reLoginDictionary;

/** 网络断开又重新连接上以后需要重新连接socket */
@property (nonatomic, copy) socketBeginConnect socketBeginConnect;

+ (instancetype)shareManger;

- (void)addNetObserveHasNet:(void(^)(void))hasNet noNet:(void(^)(void))noNet controller:(NSString *)name;

- (void)reLogin:(void(^)(void))reLogin controller:(NSString *)name;

@end
