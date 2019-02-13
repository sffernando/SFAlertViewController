//
//  UIView+CornerRadius.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)

- (void)addCorner:(UIRectCorner)corners withRadius:(CGFloat)radius;
- (void)addCorner:(UIRectCorner)corners forViewSize:(CGSize)size withRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
