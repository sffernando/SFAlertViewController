//
//  SFTextFeildAlertContentView.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFTextFeildAlertContentView.h"

#import "Masonry.h"

#import "UIView+CornerRadius.h"
#import "UIView+YYAdd.h"

@interface SFTextFeildAlertContentView (){
    UILabel  *titleLabel;
    UILabel  *subTitleLabel;
    UIView   *blueLayerView;
    NSArray  <SFAlertAction *> *_actions;
    UIView   *contentView;
}
@end

@implementation SFTextFeildAlertContentView


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UILabel *)titleLabel {
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.numberOfLines = 1;
        [self addSubview:titleLabel];
    }
    return titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!subTitleLabel) {
        subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.font = [UIFont systemFontOfSize:15];
        subTitleLabel.textColor = [UIColor darkGrayColor];
        subTitleLabel.numberOfLines = 0;
        [self addSubview:subTitleLabel];
    }
    return subTitleLabel;
}

- (void)createContentView {
    if (!contentView) {
        contentView = [[UIView alloc] initWithFrame:CGRectMake((self.width - kSFAlertContentViewWidth)/2, (self.height - 185)/2, kSFAlertContentViewWidth, 175)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.clipsToBounds = YES;
        contentView.layer.cornerRadius = 5.f;
        [self addSubview:contentView];
        
        UIView *horLineView = [[UIView alloc] init];
        horLineView.backgroundColor = [UIColor lightGrayColor];
        [contentView addSubview:horLineView];
        [horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(1.f/[UIScreen mainScreen].scale);
            make.bottom.mas_equalTo(-51);
        }];
        
        if (_actions.count >= 2) {
            UIView *verLineView = [[UIView alloc] init];
            verLineView.backgroundColor = [UIColor lightGrayColor];
            [contentView addSubview:verLineView];
            [verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(contentView);
                make.height.mas_equalTo(51);
                make.width.mas_equalTo(1.f/[UIScreen mainScreen].scale);
                make.bottom.mas_equalTo(0);
            }];
        }
    }
}


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle textFeildArribute:(NSDictionary *)textFeildArribute actions:(NSArray <SFAlertAction *>*)actions
{
    if (self = [super initWithFrame:frame]) {
        _actions = [actions copy];
        
        [self createContentView];
        [self titleLabel];
        titleLabel.text = title;
        
        //        if (subTitle) {
        [self subTitleLabel];
        subTitleLabel.text = subTitle;
        //        }
        
        [self blueLayerView];
        
        _textFeild = [[UITextField alloc] initWithFrame:CGRectMake(15, 57, contentView.width - 30, 42)];
        _textFeild.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        _textFeild.layer.cornerRadius = 2.f;
        [contentView addSubview:_textFeild];
        
        [self configTextFeild:_textFeild attribute:textFeildArribute];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(kSFAlertContentViewWidth);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top).offset(28);
            make.centerX.mas_equalTo(0);
            make.left.mas_greaterThanOrEqualTo(contentView.mas_left).offset(16);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-16);
        }];
        
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(contentView.mas_left).offset(30);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-30);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        }];
        
        [_textFeild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(contentView.mas_left).offset(20);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-20);
            make.height.mas_equalTo(42.f);
            make.top.mas_equalTo(subTitleLabel.mas_bottom).offset(13);
        }];
        
        [blueLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_textFeild.mas_bottom).offset(30);
            make.left.mas_equalTo(contentView.mas_left);
            make.right.mas_equalTo(contentView.mas_right);
            make.size.mas_equalTo(CGSizeMake(kSFAlertContentViewWidth, 50));
            make.bottom.mas_equalTo(contentView.mas_bottom);
        }];
        
        [_actions enumerateObjectsUsingBlock:^(SFAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [self actionButtonWithAction:obj toutalCount:_actions.count curentIndex:idx];
            button.tag = kSFAlertContentDefaultTag + idx;
            [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [blueLayerView addSubview:button];
        }];
        [self layoutIfNeeded];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (UIView *)blueLayerView {
    if (!blueLayerView) {
        blueLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSFAlertContentViewWidth, kSFAlertContentViewActionHeight)];
        [self addSubview:blueLayerView];
    }
    return blueLayerView;
}

- (UIButton *)actionButtonWithAction:(SFAlertAction *)action toutalCount:(NSInteger)count curentIndex:(NSInteger)index{
    CGFloat buttonWidth = kSFAlertContentViewWidth / count;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(index * buttonWidth, 0, buttonWidth, kSFAlertContentViewActionHeight);
    [button setTitle:action.title forState:UIControlStateNormal];
    [button setTitle:action.title forState:UIControlStateSelected];
    [button setTitleColor:action.style == SFAlertActionStyleCancel ? [UIColor lightGrayColor] : [UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:action.style == SFAlertActionStyleCancel ? [UIColor lightGrayColor] : [UIColor blackColor] forState:UIControlStateSelected];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
    return button;
}

- (void)configTextFeild:(__kindof UITextField *)textFeild attribute:(NSDictionary *)attribue {
    if (!textFeild) return;
    if (!attribue) return;
    
    if ([attribue objectForKey:kSFAlertControllerTextFeildFontKey]) {
        textFeild.font = [attribue objectForKey:kSFAlertControllerTextFeildFontKey];
    }
    
    if ([attribue objectForKey:kSFAlertControllerTextFeildTextColorKey]) {
        textFeild.textColor = [attribue objectForKey:kSFAlertControllerTextFeildTextColorKey];
    }
    
    if ([attribue objectForKey:kSFAlertControllerTextFeildPlacehoderTextColorKey]) {
        [textFeild setValue:[attribue objectForKey:kSFAlertControllerTextFeildPlacehoderTextColorKey] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    if ([attribue objectForKey:kSFAlertControllerTextFeildPlacehoderKey]) {
        [textFeild setPlaceholder:[attribue objectForKey:kSFAlertControllerTextFeildPlacehoderKey]];
    }
    
    if ([attribue objectForKey:kSFAlertControllerTextFeildPlacehoderTextAlinementKey]) {
        [textFeild setValue:[attribue objectForKey:kSFAlertControllerTextFeildPlacehoderTextAlinementKey] forKeyPath:@"_placeholderLabel.textAlignment"];
        [textFeild setTextAlignment:[[attribue objectForKey:kSFAlertControllerTextFeildPlacehoderTextAlinementKey] integerValue]];
    }
    
    if ([attribue objectForKey:kSFAlertControllerTextFeildKeyboardTypeKey]) {
        [textFeild setKeyboardType:[[attribue objectForKey:kSFAlertControllerTextFeildKeyboardTypeKey] integerValue]];
    }
}

- (void)actionButtonClicked:(UIButton *)button {
    if (_actions.count > button.tag - kSFAlertContentDefaultTag) {
        SFAlertAction *action = [_actions objectAtIndex:button.tag - kSFAlertContentDefaultTag];
        if (action.handler) {
            action.handler(action);
        }
    }
    [self endEditing:YES];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in self.subviews) {
        if ([subview hitTest:[self convertPoint:point toView:subview] withEvent:event]) {
            return YES;
        }
    }
    [self endEditing:YES];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notify {
    NSValue *endFrameValue = [notify.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [endFrameValue CGRectValue];
    NSTimeInterval duration = [[notify.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat bgMaxY = CGRectGetMaxY(contentView.frame);
    CGFloat keyboardY = endRect.origin.y;
    if (bgMaxY > keyboardY) {
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).offset(keyboardY - bgMaxY);
        }];
        [UIView animateWithDuration:duration animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notify {
    NSValue *endFrameValue = [notify.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect endRect = [endFrameValue CGRectValue];
    NSTimeInterval duration = [[notify.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat bgMaxY = CGRectGetMaxY(contentView.frame);
    CGFloat keyboardY = endRect.origin.y;
    if (bgMaxY >= keyboardY) {
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
        }];
        [UIView animateWithDuration:duration animations:^{
            [self layoutIfNeeded];
        }];
    }
}


@end
