//
//  SCHCLNetWorkManger.m
//  SuperCard
//
//  Created by  on 2018/12/11.
//  Copyright © 2018年 G-mall. All rights reserved.
//

#import "SCHCLNetWorkManger.h"

@interface SCHCLNetWorkManger ()

@end

@implementation SCHCLNetWorkManger

+ (instancetype)shareManger {
    
    static SCHCLNetWorkManger *net;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        net = [SCHCLNetWorkManger new];
    });
    return net;
}

- (NSMutableDictionary <id,void(^)(void)> *)hasNetDictionary {
    
    if (!_hasNetDictionary) {
        
        _hasNetDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _hasNetDictionary;
}

- (NSMutableDictionary <id,void(^)(void)> *)noNetDictionary {
    
    if (!_noNetDictionary) {
        
        _noNetDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _noNetDictionary;
}

- (NSMutableDictionary <id,void(^)(void)>*)reLoginDictionary {
    
    if (!_reLoginDictionary) {
        
        _reLoginDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _reLoginDictionary;
}

- (void)addNetObserveHasNet:(void(^)(void))hasNet noNet:(void(^)(void))noNet controller:(NSString *)name {
    
    if (hasNet && ![self.hasNetDictionary.allKeys containsObject:name]) {
        
        [self.hasNetDictionary setObject:hasNet forKey:name];
    }
    
    if (noNet && ![self.noNetDictionary.allKeys containsObject:name]) {
        
        [self.noNetDictionary setObject:noNet forKey:name];
    }
}

- (void)reLogin:(void(^)(void))reLogin controller:(NSString *)name {
    
    if (reLogin && ![self.reLoginDictionary.allKeys containsObject:name]) {
        
        [self.reLoginDictionary setObject:reLogin forKey:name];
    }
}
@end
