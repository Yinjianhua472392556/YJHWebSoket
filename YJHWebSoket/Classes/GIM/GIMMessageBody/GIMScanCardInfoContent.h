//
//  GIMScanCardInfoContent.h
//  SuperCard
//
//  Created by aa on 2019/1/22.
//  Copyright © 2019 G-mall. All rights reserved.
//

#import "GIMMessage.h"
@class GIMScanCardInfoOtherContent;
@class GIMScanCardInfoPushContent;

NS_ASSUME_NONNULL_BEGIN

@interface GIMScanCardInfoPushContent : GIMMessageContent

@property (nonatomic, strong) GIMScanCardInfoOtherContent *others;

@end


@interface GIMScanCardInfoContent : GIMMessageContent

@property (nonatomic, strong) GIMScanCardInfoPushContent * push;

@end

@interface GIMScanCardInfoOtherContent : GIMMessageContent

@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *img_face;

@property (nonatomic, strong) NSString *guser_id;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *company_name;


@end


NS_ASSUME_NONNULL_END
