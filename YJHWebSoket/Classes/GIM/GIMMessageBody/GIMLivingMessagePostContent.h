//
//  GIMLivingMessagePostContent.h
//  SuperCard
//
//  Created by aa on 2019/1/5.
//  Copyright © 2019 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"
@class GIMLivingMessageMyPostContent,GIMLivingMessageUserContent,GIMLivingMessageExtraContent;


NS_ASSUME_NONNULL_BEGIN

@interface GIMLivingMessagePostContent : GIMMessageContent

@property (nonatomic, strong) GIMLivingMessageUserContent * user;

@property (nonatomic, strong) GIMLivingMessageMyPostContent * post;
@property (nonatomic, strong) GIMLivingMessageExtraContent *extra;
/** 文本消息中的消息内容 */
@property (nonatomic, copy) NSString *room_id;
/** 标题 */
@property (nonatomic, copy) NSString *room_title;
/** 流id */
@property (nonatomic, copy) NSString *action;
/** 消息类型 */
@property (nonatomic, copy) NSString *type;

/** 是否处于已经连麦的状态 */
@property (nonatomic, assign) BOOL isMicConnected;
/** 是否是显示主播主动连麦,用来判断加号的 */
@property (nonatomic, assign) BOOL isAnchorMic;
/** 是否是主播主动连麦的人,用来显示主动连麦的状态的 */
@property (nonatomic, assign) BOOL isAnchorMicer;
@end


@interface GIMLivingMessageExtraContent : GIMMessageContent

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img_face;

@property (nonatomic, copy) NSString *posted;

@property (nonatomic, copy) NSString *name;
/** 房间内每一个人的唯一标识 */
@property (nonatomic, assign) NSUInteger roomuid;

/** nickname */
@property (nonatomic, copy) NSString  *nickname;

/** state：0是关闭，1是打开视频连麦，2是打开语音连麦 */
@property (nonatomic, copy) NSString  *state;
// 房间角色
@property (nonatomic, copy) NSString * room_role;
/** ppt推送的视频或图片地址 */
@property (nonatomic, strong) NSString  *url;
/** video */
@property (nonatomic, strong) NSDictionary  *video;
/** 当前直播的房间id */
@property (nonatomic, strong) NSString *room_id;
/** 动作：0向后，1向前 */
@property (nonatomic, strong) NSString  *action;
/** 主播开启关闭投屏是的推送，1开启，0关闭 */
@property (nonatomic, strong) NSString  *video_source;
/** uid */
@property (nonatomic, strong) NSString  *uid;
/** 是否开启ppt模式 1开启，0关闭*/
@property (nonatomic, strong) NSString  *pptswitch;
/** 当前幻灯片的类型 0-PPT,1-图片*/
@property (nonatomic, strong) NSString  *mediatype;
/** 直播发红包的发送人数据send_user */
@property (nonatomic, strong) NSDictionary  *send_user;
/** 直播收红包的接收人的数据rece_user */
@property (nonatomic, strong) NSDictionary  *rece_user;
/** gift_id */
@property (nonatomic, strong) NSString  *gift_id;
/** 直播发红包的红包id */
@property (nonatomic, strong) NSString  *business_id;
/** 手机信息 {"brand":"iphone","model":"iPhone 6s","width":375.0,"height":667.0,"system":"12.0.1"} */
@property (nonatomic, strong) NSDictionary  *phoneinfo;
@end

@interface GIMLivingMessageMyPostContent : GIMMessageContent
/** 文本消息中的消息内容 */
@property (nonatomic, copy) NSString *content;
/** 标题 */
@property (nonatomic, copy) NSString *room_id;
/** 流id */
@property (nonatomic, copy) NSString *ID;
/** 封面url */
@property (nonatomic, copy) NSString *create_time;
@end

@interface GIMLivingMessageUserContent : GIMMessageContent
/** 文本消息中的消息内容 */
@property (nonatomic, copy) NSString *img_face;
/** 标题 */
@property (nonatomic, copy) NSString *nickname;
/** 流id */
@property (nonatomic, copy) NSString *ID;
@end


NS_ASSUME_NONNULL_END
