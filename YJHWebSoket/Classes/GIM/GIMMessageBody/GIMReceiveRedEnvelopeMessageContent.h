//
//  GIMReceiveRedEnvelopeMessageContent.h
//  SuperGone
//
//  Created by  on 2017/8/31.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"
@class GIMRedEnvelopeUser;

typedef NSString * GIMReceiveRedEnvelopeAction;
extern GIMReceiveRedEnvelopeAction GIMReceiveRedEnvelopeActionGet;

@interface GIMReceiveRedEnvelopeMessageContent : GIMMessageContent

@property (nonatomic, copy) GIMReceiveRedEnvelopeAction action;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) GIMRedEnvelopeUser *sendUser;
@property (nonatomic, strong) GIMRedEnvelopeUser *receiveUser;

@end


@interface GIMRedEnvelopeUser : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;

@end
