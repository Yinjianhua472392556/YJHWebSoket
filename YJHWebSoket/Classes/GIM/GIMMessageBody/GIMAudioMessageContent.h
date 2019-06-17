//
//  GIMAudioMessageContent.h
//  SuperCard
//
//  Created by 王寒标 on 2017/12/24.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

@interface GIMAudioMessageContent : GIMMessageContent

/** 音频路径 */
@property (nonatomic, copy) NSString *url;

/** 音频时长 */
@property (nonatomic, copy) NSString *duration;

- (instancetype)initWithChatType:(GIMConversationType)chatType;

@end
