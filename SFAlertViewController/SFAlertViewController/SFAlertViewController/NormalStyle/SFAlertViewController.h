//
//  SFAlertViewController.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAlertContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAlertViewController : UIViewController

@property (nonatomic, assign) BOOL backgroundTapDismissalGestureEnabled;
@property (nonatomic, assign) BOOL needRightTopCancelButton;
@property (nonatomic, copy) NSDictionary *otherStyleDict;
// actions can not more than 2
- (void)addAction:(SFAlertAction *)action;

@property (nonatomic, readonly) NSArray<SFAlertAction *> *actions;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title attributedMessage:(nullable NSAttributedString *)message;
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message middleCustomView:(UIView *)middleCustomView;


@end

NS_ASSUME_NONNULL_END
