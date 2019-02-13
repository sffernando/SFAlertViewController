//
//  SFAlertAction.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SFAlertActionStyle) {
    SFAlertActionStyleNormal ,
    SFAlertActionStyleCancel
};

@interface SFAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title
                          style:(SFAlertActionStyle)style
                        handler:(void (^)(SFAlertAction *action))handler;

@property (nonatomic, copy,  readonly) NSString *title;
@property (nonatomic, assign,readonly) SFAlertActionStyle style;
@property (nonatomic, copy,  readonly) void (^handler)(SFAlertAction *action);
@property (nonatomic, assign, getter=isEnabled) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
