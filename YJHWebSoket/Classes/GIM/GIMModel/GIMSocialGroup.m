//
//  GIMSocialGroup.m
//  WebSocket
//
//  Created by  on 2017/6/12.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMSocialGroup.h"
#import "MJExtension.h"

@implementation GIMSocialGroup

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"sgroup_id",
             @"topicID" : @"sgroup_topic_id"
             };
}

@end
