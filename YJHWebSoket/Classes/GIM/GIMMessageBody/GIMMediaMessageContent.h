//
//  GIMMediaMessageContent.h
//  WebSocket
//
//  Created by  on 2017/6/10.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

typedef NSString * GIMMediaMessageAction;

extern GIMMediaMessageAction GIMMediaMessageActionInvite;    //邀请一起听音乐
extern GIMMediaMessageAction GIMMediaMessageActionAgree;     //同意邀请
extern GIMMediaMessageAction GIMMediaMessageActionRefuse;    //拒绝邀请
extern GIMMediaMessageAction GIMMediaMessageActionCancel;    //取消邀请

@interface GIMMediaMessageContent : GIMMessageContent
/** 多媒体动作类型 */
@property (nonatomic, copy) GIMMediaMessageAction action;
/** 多媒体资源的名称 */
@property (nonatomic, copy) NSString *name;
/** 多媒体链接地址 */
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithMessageType:(GIMMessageType)type action:(GIMMediaMessageAction)action;

@end
