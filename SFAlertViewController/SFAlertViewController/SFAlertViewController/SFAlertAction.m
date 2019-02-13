//
//  SFAlertAction.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFAlertAction.h"

@implementation SFAlertAction

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(SFAlertActionStyle)style
                        handler:(void (^)(SFAlertAction *action))handler
{
    SFAlertAction *action = [[SFAlertAction alloc] initWithTitle:title style:style handler:handler];
    return action;
}

- (instancetype)initWithTitle:(NSString *)title
                        style:(SFAlertActionStyle)style
                      handler:(void (^)(SFAlertAction *action))handler
{
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = [handler copy];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _enabled = YES;
    }
    return self;
}

@end
