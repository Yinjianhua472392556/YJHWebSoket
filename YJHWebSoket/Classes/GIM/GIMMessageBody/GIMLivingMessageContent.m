//
//  GIMLivingMessageContent.m
//  WebSocket
//
//  Created by  on 2017/6/1.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMLivingMessageContent.h"
#import "MJExtension.h"

GIMLivingAction const GIMLivingActionCreateLive = @"liveCreate";
GIMLivingAction const GIMLivingActionChatMessage = @"liveMsg";
GIMLivingAction const GIMLivingActionEnter = @"liveUserEnter";
GIMLivingAction const GIMLivingActionLeave = @"liveUserLeave";
GIMLivingAction const GIMLivingActionCloseLive = @"liveClose";

@implementation GIMLivingMessageContent

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id"
             };
}

@end
