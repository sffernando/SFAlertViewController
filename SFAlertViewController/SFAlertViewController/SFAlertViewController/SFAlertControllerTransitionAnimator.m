//
//  SFAlertControllerTransitionAnimator.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFAlertControllerTransitionAnimator.h"

@interface SFAlertViewPresentationAnimationController () <UIViewControllerAnimatedTransitioning>


@end

@implementation SFAlertViewPresentationAnimationController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = 0.3;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.2f);
    toViewController.view.layer.opacity = 0.0f;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toViewController.view.layer.transform = CATransform3DIdentity;
                         toViewController.view.layer.opacity = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

@end

@interface SFAlertViewDismissAnimationController () <UIViewControllerAnimatedTransitioning>


@end

@implementation SFAlertViewDismissAnimationController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = 0.3;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

@end
