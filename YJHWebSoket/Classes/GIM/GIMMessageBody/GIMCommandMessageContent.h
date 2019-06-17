//
//  GIMCommandMessageContent.h
//  SuperGone
//
//  Created by HCL on 17/8/23.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

typedef NSString * GIMCommandAction;

/** 社群休息 */
extern GIMCommandAction const GIMCommandActionBreak;
/** 社群取消休息 */
extern GIMCommandAction const GIMCommandActionBreakCancel;
/** 社群禁言 */
extern GIMCommandAction const GIMCommandActionBanned;
/** 社群取消禁言 */
extern GIMCommandAction const GIMCommandActionOpen;

@interface GIMCommandMessageContent : GIMMessageContent

@property (nonatomic,copy) GIMCommandAction action;

@end
