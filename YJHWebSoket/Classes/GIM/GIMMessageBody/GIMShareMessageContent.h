//
//  GIMShareMessageContent.h
//  SuperGone
//
//  Created by  on 2017/8/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

typedef NSString * GIMShareAction;
typedef NSString * GIMShareType;

extern GIMShareAction const GIMShareActionCreate;             //超级创作
extern GIMShareAction const GIMShareActionCircle;             //圈子
extern GIMShareAction const GIMShareActionActivity;           //活动
extern GIMShareAction const GIMShareActionMall;               //商城
extern GIMShareAction const GIMShareActionNews;               //新闻
extern GIMShareAction const GIMShareActionCoupon;             //优惠券
extern GIMShareAction const GIMShareActionArticle;            //阅读
extern GIMShareAction const GIMShareActionProduct;            //产品
extern GIMShareAction const GIMShareActionProductCard;    //产品名片
extern GIMShareAction const GIMShareActionLive;               //直播
extern GIMShareAction const GIMShareActionCommunity;          //社群
extern GIMShareAction const GIMShareActionPublic;             //公告
extern GIMShareAction const GIMShareActionOfficialWebsite;    //官网
extern GIMShareAction const GIMShareActionCardcase;           //名片
extern GIMShareAction const GIMShareActionScanCardcase;           //扫描的名片
extern GIMShareAction const GIMShareActionGroupShare;           //分享的社群
extern GIMShareAction const GIMShareActionCardGroup;         //分享的名片分组
extern GIMShareType const GIMShareTypeProduct;                //商品
extern GIMShareType const GIMShareTypeArticle;                //文章
extern GIMShareType const GIMShareTypeGroupShare;     //分享的社群
extern GIMShareType const GIMShareTypeProjectCard;   //项目名片
extern GIMShareAction const GIMShareActionNewFriendCircle;  //朋友圈
extern GIMShareAction const GIMShareActionMyVideo;//名片详情我的视频
extern GIMShareAction const GIMShareActionMyLiving;//名片详情我的直播

@interface GIMShareMessageContent : GIMMessageContent
/** 分享的动作，若是分享的收藏，则用type */
@property (nonatomic, copy) GIMShareAction action;
/** 展示的标题 */
@property (nonatomic, copy) NSString *title;
/** 封面 */
@property (nonatomic, copy) id cover;//NSString *
/** 内容ID */
@property (nonatomic, copy) NSString *ID;
/** 分享收藏时的分享类型 */
@property (nonatomic, copy) GIMShareType type;
/** 分享产品所属的APP的ID */
@property (nonatomic, copy) NSString *appid;
/** 产品的价格 */
//@property (nonatomic, copy) NSString *price;
@property (nonatomic) NSUInteger price;
/** 产品图 */
@property (nonatomic, copy) NSString *imgurl;
/** 产品描述文字 */
@property (nonatomic, copy) NSString *descripttext;
@property (nonatomic, strong) NSString *descr;
/** 官网地址 */
@property (nonatomic, copy) NSString *src;
/** 视频直播的地址 */
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *livingTime;
@property (nonatomic, strong) NSString *postid;
@property (nonatomic, copy, readonly) NSString *paramterMark;

@property (nonatomic, copy, readonly) NSString *titleMark;

#pragma mark - 名片相关
/** 发送名片的人的ID */
@property (nonatomic, copy) NSString *senderGuserID;
/** 是否已经收藏 */
@property (nonatomic) BOOL collect;
/** 公司 */
@property (nonatomic, copy) NSString *company;
/** 职位 */
@property (nonatomic, copy) NSString *job;
/** 未知字段 */
@property (nonatomic, copy) NSString *query;

#pragma mark  分享的名片详情中的视频和直播

#pragma mark 分享的社群

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *total_member;

@property (nonatomic, copy) NSArray *members;

- (instancetype)initWithMessageType:(GIMMessageType)messageType chatType:(GIMConversationType)conversationType;

@end
