//
//  GIMReceiveRedEnvelopeMessageContent.m
//  SuperGone
//
//  Created by  on 2017/8/31.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMReceiveRedEnvelopeMessageContent.h"


GIMReceiveRedEnvelopeAction GIMReceiveRedEnvelopeActionGet = @"getredpacket";

@implementation GIMReceiveRedEnvelopeMessageContent

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"sendUser" : @"send_user",
             @"receiveUser" : @"user"
             };
}

@end


@implementation GIMRedEnvelopeUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"avatar" : @"img_face"
             };
}

@end
