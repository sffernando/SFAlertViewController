//
//  SFAlertViewController.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFAlertViewController.h"

#import "SFAlertControllerTransitionAnimator.h"
#import "SFAlertViewPresentationController.h"

@interface SFAlertViewController ()<UIViewControllerTransitioningDelegate> {
    BOOL isTopCustom;
    BOOL isMiddleCustom;
    NSString *_alertTitle;
    id       _alertMessage;
    UIView   *_topCustomView;
    UIView   *_middleCustomView;
}

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;

@end

@implementation SFAlertViewController

@dynamic view;

- (void)dealloc
{
    
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    SFAlertViewController *alertController = [[SFAlertViewController alloc] initWithTitle:title message:message];
    return alertController;
}
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title attributedMessage:(nullable NSAttributedString *)message {
    SFAlertViewController *alertController = [[SFAlertViewController alloc] initWithTitle:title message:message];
    return alertController;
}
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                        middleCustomView:(UIView *)middleCustomView
{
    SFAlertViewController *alertController = [[SFAlertViewController alloc] initWithTitle:title message:message topCustomView:nil middleCustomView:middleCustomView];
    return alertController;
}


- (instancetype)initWithTitle:(nullable NSString *)title message:(id)message {
    self = [super init];
    if (self) {
        isTopCustom = NO;
        isMiddleCustom = NO;
        _alertTitle = title;
        _alertMessage = message;
        [self createDefaultValue];
    }
    return self;
}

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                topCustomView:(UIView *)topCustomView
             middleCustomView:(UIView *)middleCustomView
{
    self = [super init];
    if (self) {
        isTopCustom = (topCustomView != nil);
        isMiddleCustom = (middleCustomView != nil);
        _alertTitle = title;
        _alertMessage = message;
        _topCustomView = topCustomView;
        _middleCustomView = middleCustomView;
        [self createDefaultValue];
    }
    return self;
}

- (void)createDefaultValue {
    _actions = [NSArray array];
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    _backgroundTapDismissalGestureEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (isTopCustom) {
        self.view = [[SFAlertContentView alloc] initWithFrame:self.view.bounds title:_alertTitle message:_alertMessage topCustomView: _topCustomView actions:_actions];
        [(SFAlertContentView *)self.view setOtherStyleDict: self.otherStyleDict];
    }else if (isMiddleCustom){
        self.view = [[SFAlertContentView alloc] initWithFrame:self.view.bounds title:_alertTitle message:_alertMessage middleCustomView:_middleCustomView actions:_actions];
        [(SFAlertContentView *)self.view setOtherStyleDict: self.otherStyleDict];
    }else {
        self.view = [[SFAlertContentView alloc] initWithFrame:self.view.bounds title:_alertTitle message:_alertMessage actions:_actions];
        [(SFAlertContentView *)self.view setOtherStyleDict: self.otherStyleDict];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    // Necessary to avoid retain cycle - http://stackoverflow.com/a/21218703/1227862
    self.transitioningDelegate = nil;
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAction:(SFAlertAction *)action {
    _actions = [self.actions arrayByAddingObject:action];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    SFAlertViewPresentationController *presentationController = [[SFAlertViewPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationController.backgroundTapDismissalGestureEnabled = self.backgroundTapDismissalGestureEnabled;
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    SFAlertViewPresentationAnimationController *presentationAnimationController = [[SFAlertViewPresentationAnimationController alloc] init];
    return presentationAnimationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SFAlertViewDismissAnimationController *dismissalAnimationController = [[SFAlertViewDismissAnimationController alloc] init];
    return dismissalAnimationController;
}

@end
