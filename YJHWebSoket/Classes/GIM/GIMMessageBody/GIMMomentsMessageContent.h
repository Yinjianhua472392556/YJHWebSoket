//
//  GIMMomentsMessageContent.h
//  GInstantMessage
//
//  Created by  on 2017/6/7.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"
#import "GIMSocialTopicCreator.h"
#import "GIMSocialGroup.h"
typedef NSString * GIMCircleAction;

extern GIMCircleAction GIMCircleActionCreate;

@interface GIMMomentsMessageContent : GIMMessageContent

/**
 话题内容
 */
@property (nonatomic, copy) NSString *content;

/**
 话题中的图片URL数组
 */
@property (nonatomic, strong) NSArray *images;

/**
 视频话题的视频URL
 */
@property (nonatomic, copy) NSString *vedioUrl;

/**
 视频、直播、超级创作、圈子、活动、商城、新闻、优惠券、阅读、公告话题的封面图URL
 */
@property (nonatomic, copy) NSString *cover;

/**
 直播、超级创作、圈子、活动、商城、新闻、优惠券、阅读、公告话题的ID
 */
@property (nonatomic, copy) NSString *contentID;

/**
 直播话题的观看URL
 */
@property (nonatomic, copy) NSString *url;

/**
 直播、超级创作、圈子、活动、商城、新闻、优惠券、阅读、公告话题时的直播标题
 */
@property (nonatomic, copy) NSString *contentTitle;

/**
 直播话题时的临时群ID
 */
@property (nonatomic, copy) NSString *groupId;

/**
 直播话题时的横竖屏标记：yes 竖屏
 */
@property (nonatomic) BOOL direction;

/**
 圈子的相关动作
 */
@property (nonatomic, copy) GIMCircleAction action;

/**
 创建时间
 */
@property (nonatomic, copy) NSString *createTime;

/**
 话题创建者
 */
@property (nonatomic, strong) GIMSocialTopicCreator *creator;

/**
 话题ID
 */
@property (nonatomic, copy) NSString *topicID;

/**
 是否点赞
 */
@property (nonatomic) BOOL isLiked;

@property (nonatomic) BOOL isSocket;

@property (nonatomic) NSUInteger likes;

@property (nonatomic, strong) GIMSocialGroup *sgroup;

@property (nonatomic, copy) NSString *title;

@end
