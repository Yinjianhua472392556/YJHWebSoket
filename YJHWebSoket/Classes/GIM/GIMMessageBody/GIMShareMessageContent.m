//
//  GIMShareMessageContent.m
//  SuperGone
//
//  Created by  on 2017/8/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMShareMessageContent.h"

GIMShareAction const GIMShareActionCreate = @"create";
GIMShareAction const GIMShareActionCircle = @"circle";
GIMShareAction const GIMShareActionActivity = @"activity";
GIMShareAction const GIMShareActionMall = @"mall";
GIMShareAction const GIMShareActionNews = @"news";
GIMShareAction const GIMShareActionCoupon = @"coupon";
GIMShareAction const GIMShareActionArticle = @"article";
GIMShareAction const GIMShareActionProduct = @"product";
GIMShareAction const GIMShareActionProductCard = @"产品名片";
GIMShareAction const GIMShareActionLive = @"live";
GIMShareAction const GIMShareActionCommunity = @"community";
GIMShareAction const GIMShareActionPublic = @"public";
GIMShareAction const GIMShareActionOfficialWebsite = @"gz";
GIMShareAction const GIMShareActionCardcase = @"mp";
GIMShareAction const GIMShareActionScanCardcase = @"scanCard"; 
GIMShareAction const GIMShareActionCardGroup = @"cardGroup"; 
GIMShareAction const GIMShareActionGroupShare = @"community_card";
GIMShareType const GIMShareTypeProduct = @"产品";
GIMShareType const GIMShareTypeArticle = @"文章";
GIMShareType const GIMShareTypeGroupShare = @"公开社群";
GIMShareType const GIMShareTypeProjectCard = @"projectCard";
GIMShareAction const GIMShareActionNewFriendCircle = @"friendsMilieu";
GIMShareAction const GIMShareActionMyVideo = @"myVideo";
GIMShareAction const GIMShareActionMyLiving = @"myLiving";

@implementation GIMShareMessageContent

- (instancetype)initWithMessageType:(GIMMessageType)messageType chatType:(GIMConversationType)conversationType
{
    self = [super init];
    if (self) {
        
        self.messageType = messageType;
        self.chatType = conversationType;
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"senderGuserID" : @"__senderguser_id",
             @"descr":@"description"
             };
}

+ (NSArray *)mj_ignoredPropertyNames {
    
    return @[@"paramterMark", @"titleMark"];
}

- (NSString *)titleMark {
    
    NSDictionary *dict = @{
                           GIMShareActionLive : @"直播",
                           GIMShareActionMall : @"商城",
                           GIMShareActionNews : @"新闻",
                           GIMShareActionCircle : @"圈子",
                           GIMShareActionCoupon : @"优惠券",
                           GIMShareActionCreate : @"文章",
                           GIMShareActionPublic : @"公告",
                           GIMShareActionArticle : @"阅读",
                           GIMShareActionProduct : @"商品",
                           GIMShareActionActivity : @"活动",
                           GIMShareActionCommunity : @"社群",
                           GIMShareTypeProduct : @"商品",
                           GIMShareTypeArticle : @"文章",
                           GIMShareActionOfficialWebsite : @"官网",
                           GIMShareActionCardcase : @"名片",
                           GIMShareTypeProjectCard : @"项目名片",
                           GIMShareActionNewFriendCircle : @"朋友圈"
                           };
    
    return [NSString stringWithFormat:@"%@", dict[self.type.length > 0 ? self.type : self.action]];
}

- (NSString *)paramterMark {
    
    NSDictionary *dict = @{
                           GIMShareActionLive : @"liveid",
                           GIMShareActionMall : @"mallid",
                           GIMShareActionNews : @"news",
                           GIMShareActionCircle : @"circle",
                           GIMShareActionCoupon : @"couponid",
                           GIMShareActionCreate : @"screat",
                           GIMShareActionPublic : @"screat",
                           GIMShareActionArticle : @"artid",
                           GIMShareActionProduct : @"productid",
                           GIMShareActionActivity : @"activityid",
                           GIMShareActionCommunity : @"sgroupid",
                           GIMShareTypeProduct : @"productid",
                           GIMShareTypeArticle : @"screat",
                           GIMShareActionCardcase : @"mp",
                           GIMShareTypeProjectCard : @"projectCard",
                           GIMShareActionNewFriendCircle : @"friendsMilieu"
                           };
    
    return [NSString stringWithFormat:@"%@", dict[self.type.length > 0 ? self.type : self.action]];
}

@end
