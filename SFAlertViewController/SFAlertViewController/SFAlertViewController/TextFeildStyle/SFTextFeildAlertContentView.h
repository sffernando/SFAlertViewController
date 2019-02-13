//
//  SFTextFeildAlertContentView.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAlertAction.h"
#import "SFAlertControllerConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFTextFeildAlertContentView : UIView


@property (nonatomic, strong, readonly) UITextField *textFeild;

// 基本上只支持两个操作按钮
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle textFeildArribute:(NSDictionary *)textFeildArribute actions:(NSArray <SFAlertAction *>*)actions;

@end

NS_ASSUME_NONNULL_END
