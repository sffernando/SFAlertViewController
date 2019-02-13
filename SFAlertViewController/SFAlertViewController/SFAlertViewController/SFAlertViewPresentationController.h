//
//  SFAlertViewPresentationController.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFAlertViewPresentationController : UIPresentationController

@property (nonatomic, assign) CGFloat presentedViewControllerHorizontalInset;
@property (nonatomic, assign) CGFloat presentedViewControllerVerticalInset;
@property (nonatomic, assign) BOOL backgroundTapDismissalGestureEnabled;
@property (nonatomic, strong) UIView *backgroundDimmingView;

@end

NS_ASSUME_NONNULL_END
