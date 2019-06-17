//
//  GIMMomentsMessageContent.m
//  GInstantMessage
//
//  Created by  on 2017/6/7.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMomentsMessageContent.h"


GIMCircleAction GIMCircleActionSocialGroupCreate = @"socialGroupCreate";
GIMCircleAction GIMCircleActionSocialGroupLiving = @"socialGroupLiving";
GIMCircleAction GIMCircleActionSocialGroupVideo = @"socialGroupVedio";//前段的字符本来就是错的  改不掉
GIMCircleAction GIMCircleActionCreate = @"create";
GIMCircleAction GIMCircleActionCircle = @"circle";
GIMCircleAction GIMCircleActionActivity = @"activity";
GIMCircleAction GIMCircleActionMall = @"mall";
GIMCircleAction GIMCircleActionNews = @"news";
GIMCircleAction GIMCircleActionCoupon = @"coupon";
GIMCircleAction GIMCircleActionArticle = @"article";
GIMCircleAction GIMCircleActionPublic = @"public";

@implementation GIMMomentsMessageContent

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"images" : @"content.imageUrl",
             @"contentID" : @"content.id",
             @"action" : @"content.action",
             @"chatType" : @"chatType",
             @"cover" : @"content.cover",
             @"vedioUrl" : @"content.vedioUrl",
             @"content" : @"content.content",
             @"url" : @"content.url",
             @"contentTitle" : @"content.title",
             @"groupId" : @"content.groupId",
             @"direction" : @"content.direction",
             @"createTime" : @"create_time",
             @"topicID" : @"id",
             @"isLiked" : @"is_liked",
             @"messageType" : @"content.messageType"
             };
}

@end
