//
//  SFAlertContentView.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAlertAction.h"
#import "SFAlertControllerConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAlertContentView : UIView

@property (nonatomic, copy) NSDictionary *otherStyleDict;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
                      message:(id)message
                      actions:(NSArray <SFAlertAction *>*)actions;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
                      message:(nullable NSString *)message
             middleCustomView:(UIView *)middleCustomView
                      actions:(NSArray <SFAlertAction *>*)actions;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                      message:(nullable NSString *)message
                topCustomView:(UIView *)topCustomView
                      actions:(NSArray <SFAlertAction *>*)actions;

@end

NS_ASSUME_NONNULL_END
