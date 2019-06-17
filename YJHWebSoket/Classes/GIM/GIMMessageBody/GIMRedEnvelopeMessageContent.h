//
//  GIMRedEnvelopeMessageContent.h
//  SuperGone
//
//  Created by  on 2017/8/31.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

typedef NSString * GIMRedEnvelopeType;

extern GIMRedEnvelopeType GIMRedEnvelopeTypeCommon;//普通红包
extern GIMRedEnvelopeType GIMRedEnvelopeTypeLucky;//拼手气红包
extern GIMRedEnvelopeType GIMRedEnvelopeTypeCommand;//口令红包

@interface GIMRedEnvelopeMessageContent : GIMMessageContent

/** 红包ID */
@property (nonatomic, copy) NSString *ID;

/** 红包类型 */
@property (nonatomic, copy) GIMRedEnvelopeType type;

/** 操作类型:getredpacket */
@property (nonatomic, copy) NSString *action;

/** 红包内容 */
@property (nonatomic, copy) NSString *content;

@end
