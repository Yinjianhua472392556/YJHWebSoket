//
//  GIMAppInfoMessageContent.h
//  SuperGone
//
//  Created by  on 2017/8/16.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

typedef NSString * GIMAppInfoAction;

extern GIMAppInfoAction const GIMAppInfoActionAPP;

@interface GIMAppInfoMessageContent : GIMMessageContent

@property (nonatomic, copy) GIMAppInfoAction action;

@property (nonatomic, copy) NSString *appid;

@property (nonatomic, copy) NSString *appimg;

@property (nonatomic, copy) NSString *appname;

@property (nonatomic, copy) NSString *appstartimg;

@end
