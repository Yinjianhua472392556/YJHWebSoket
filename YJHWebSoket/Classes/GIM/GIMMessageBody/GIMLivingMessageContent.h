//
//  GIMLivingMessageContent.h
//  WebSocket
//
//  Created by  on 2017/6/1.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

typedef NSString * GIMLivingAction;

extern GIMLivingAction const GIMLivingActionCreateLive;     //创建直播
extern GIMLivingAction const GIMLivingActionChatMessage;    //直播间聊天信息
extern GIMLivingAction const GIMLivingActionEnter;          //观众进入直播间
extern GIMLivingAction const GIMLivingActionLeave;          //观众离开直播间
extern GIMLivingAction const GIMLivingActionCloseLive;      //主播关闭直播

@interface GIMLivingMessageContent : GIMMessageContent
/** 操作类型 */
@property (nonatomic, copy) GIMLivingAction action;
/** 文本消息中的消息内容 */
@property (nonatomic, copy) NSString *text;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 流id */
@property (nonatomic, copy) NSString *ID;
/** 封面url */
@property (nonatomic, copy) NSString *cover;
/** rmtp播放地址 */
@property (nonatomic, copy) NSString *url;
/** 临时群id */
@property (nonatomic, copy) NSString *groupId;
/** 直播方向0：竖屏1：横屏 */
@property (nonatomic, copy) NSString *direction;

@end
