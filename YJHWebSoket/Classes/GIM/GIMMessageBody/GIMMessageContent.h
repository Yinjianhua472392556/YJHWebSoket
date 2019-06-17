//
//  GIMMessageBody.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GIMMessageType) {
    
    GIMMessageTypeText                 = 1,   //文本
    GIMMessageTypePhoto                = 2,   //图片
    GIMMessageTypeMusic                = 3,   //一起听音乐
    GIMMessageTypeMovie                = 4,   //一起看电影
    GIMMessageTypeAudio                = 5,   //音频
    GIMMessageTypeVideo                = 6,   //视频
    GIMMessageTypeLiving               = 7,   //直播
    GIMMessageTypeTopic                = 8,   //话题
    GIMMessageTypeCommand              = 9,   //控制类型
    GIMMessageTypeShare                = 10,  //分享
    GIMMessageTypeCircle               = 11,  //圈子
    GIMMessageTypeFunction             = 12,  //功能模块
    GIMMessageTypeCollection           = 13,  //收藏
    GIMMessageTypeSendRedEnvelope      = 14,  //发红包
    GIMMessageTypeReceiveRedEnvelope   = 15,  //领取红包
    GIMMessageTypeSCCardScan           = 16,  //扫描后交换名片
    GIMMessageTypeSCLiving             = 1500, //SC的直播
};

typedef NS_ENUM(NSUInteger, GIMConversationType) {
    
    GIMConversationTypeSingleChat    = 1,//单聊
    GIMConversationTypeGroupChat     = 2,//群聊
    GIMConversationTypeSystem        = 3,//系统消息
    GIMConversationTypeOrderNews     = 7,//订单喜报
};

@interface GIMMessageContent : NSObject

/**
 消息类型
 */
@property (nonatomic) GIMMessageType messageType;

/**
 聊天类型
 */
@property (nonatomic) GIMConversationType chatType;

@end
