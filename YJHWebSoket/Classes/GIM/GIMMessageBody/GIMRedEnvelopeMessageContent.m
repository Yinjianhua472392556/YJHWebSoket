//
//  GIMRedEnvelopeMessageContent.m
//  SuperGone
//
//  Created by  on 2017/8/31.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMRedEnvelopeMessageContent.h"

GIMRedEnvelopeType GIMRedEnvelopeTypeCommon = @"普通红包";
GIMRedEnvelopeType GIMRedEnvelopeTypeLucky = @"拼手气红包";
GIMRedEnvelopeType GIMRedEnvelopeTypeCommand = @"口令红包";

@implementation GIMRedEnvelopeMessageContent

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id"
             };
}

@end
