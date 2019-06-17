//
//  GIMImageMessageContent.m
//  WebSocket
//
//  Created by  on 2017/5/19.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMImageMessageContent.h"

@implementation GIMImageMessageContent

- (instancetype)initWithImage:(UIImage *)image {
    
    self = [super init];
    if (self) {
        
        self.messageType = GIMMessageTypePhoto;
        self.image = image;
    }
    return self;
}

@end
