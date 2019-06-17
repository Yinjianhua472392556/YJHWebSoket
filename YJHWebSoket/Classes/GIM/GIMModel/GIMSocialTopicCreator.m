//
//  GIMSocialTopicCreator.m
//  SuperGone
//
//  Created by  on 2017/8/21.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMSocialTopicCreator.h"

@implementation GIMSocialTopicCreator

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"avatar" : @"img_face"
             };
}

@end
