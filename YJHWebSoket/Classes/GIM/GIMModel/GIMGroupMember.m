//
//  GIMGroupMember.m
//  WebSocket
//
//  Created by  on 2017/5/28.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMGroupMember.h"
#import "MJExtension.h"

@implementation GIMGroupMember

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id",
             @"avatar" : @"imgface"
             };
}

@end
