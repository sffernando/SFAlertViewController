//
//  SFTexFeildAlertViewController.h
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFTextFeildAlertContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFTexFeildAlertViewController : UIViewController

// actions can not more than 2
- (void)addAction:(SFAlertAction *)action;
@property (nonatomic, readonly) NSArray<SFAlertAction *> *actions;
@property (nonatomic, copy) void (^textChangedBlock)(NSString *text);

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title textFeildArribute:(NSDictionary *)textFeildArribute;
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title subTitle:(NSString *)subTitle textFeildArribute:(NSDictionary *)textFeildArribute;

- (BOOL)textFeildIsEmpty;

- (NSString *)textFeildContent;

- (void)setTextFieldContent:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
