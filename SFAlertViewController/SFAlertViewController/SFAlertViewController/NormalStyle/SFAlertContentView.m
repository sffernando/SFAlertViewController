//
//  SFAlertContentView.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFAlertContentView.h"

#import "Masonry.h"

#import "UIView+CornerRadius.h"
#import "UIView+YYAdd.h"

@interface SFAlertContentView () {
    UILabel  *titleLabel;
    UILabel  *messageLabel;
    UIButton *actionButton;
    UIView   *topLayerView;
    UIView   *bottomLayerView;
    NSArray  <SFAlertAction *> *_actions;
    UIView   *contentView;
}
@end

@implementation SFAlertContentView

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

- (UILabel *)messageLabel {
    if (!messageLabel) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.font = [UIFont systemFontOfSize:15];
        messageLabel.textColor = [UIColor darkGrayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:messageLabel];
    }
    return messageLabel;
}

- (void)createContentView {
    if (!contentView) {
        contentView = [[UIView alloc] init];
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

- (UIView *)bottomLayerView {
    if (!bottomLayerView) {
        bottomLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSFAlertContentViewWidth, kSFAlertContentViewActionHeight)];
        [self addSubview:bottomLayerView];
    }
    return bottomLayerView;
}

- (UIView *)topLayerView {
    if (!topLayerView) {
        topLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSFAlertContentViewWidth, kSFAlertContentViewTitleHeight)];
        [topLayerView addCorner:UIRectCornerTopLeft | UIRectCornerTopRight withRadius:5.f];
        [self addSubview:topLayerView];
    }
    return topLayerView;
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

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(id)message actions:(NSArray <SFAlertAction *>*)actions {
    if (self = [super initWithFrame:frame]) {
        
        _actions = [actions copy];
        
        [self createContentView];
        [self topLayerView];
        [self titleLabel];
        titleLabel.text = title;
        
        [self messageLabel];
        if ([message isKindOfClass:[NSString class]]) {
            messageLabel.text = message;
            messageLabel.textAlignment = NSTextAlignmentCenter;
        } else if ([message isKindOfClass:[NSAttributedString class]]) {
            [messageLabel setAttributedText:message];
            messageLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        [self bottomLayerView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(kSFAlertContentViewWidth);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top).offset(20);
            make.centerX.mas_equalTo(0);
            make.left.mas_greaterThanOrEqualTo(contentView.mas_left).offset(16);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-16);
        }];
        
        [topLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top);
            make.left.right.mas_equalTo(contentView);
            make.height.mas_equalTo(kSFAlertContentViewTitleHeight);
        }];
        
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(contentView.mas_left).offset(20);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-20);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        }];
        
        [bottomLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(messageLabel.mas_bottom).offset(25);
            make.left.mas_equalTo(contentView.mas_left);
            make.right.mas_equalTo(contentView.mas_right);
            make.size.mas_equalTo(CGSizeMake(kSFAlertContentViewWidth, 50));
            make.bottom.mas_equalTo(contentView.mas_bottom);
        }];
        
        [_actions enumerateObjectsUsingBlock:^(SFAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [self actionButtonWithAction:obj toutalCount:_actions.count curentIndex:idx];
            button.tag = kSFAlertContentDefaultTag + idx;
            [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomLayerView addSubview:button];
        }];
        [self layoutIfNeeded];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                      message:(nullable NSString *)message
             middleCustomView:(UIView *)middleCustomView
                      actions:(NSArray <SFAlertAction *>*)actions
{
    
    NSAssert(middleCustomView, @"custom view can not be nil");
    
    if (self = [super initWithFrame:frame]) {
        _actions = [actions copy];
        
        [self createContentView];
        [self topLayerView];
        [self titleLabel];
        titleLabel.text = title;
        
        if (message && message.length > 0) {
            [self messageLabel];
            messageLabel.text = message;
        }
        [self bottomLayerView];
        [self addSubview:middleCustomView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(kSFAlertContentViewWidth);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top).offset(20);
            make.centerX.mas_equalTo(0);
            make.left.mas_greaterThanOrEqualTo(contentView.mas_left).offset(16);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-16);
        }];
        
        [topLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top);
            make.left.right.mas_equalTo(contentView);
            make.height.mas_equalTo(kSFAlertContentViewTitleHeight);
        }];
        
        if (messageLabel) {
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.left.mas_equalTo(contentView.mas_left).offset(20);
                make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-20);
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
            }];
            
            [middleCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(messageLabel.mas_bottom).offset(15);
                make.centerX.mas_equalTo(self);
                make.size.mas_equalTo(middleCustomView.size);
            }];
            
            [bottomLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(middleCustomView.mas_bottom).offset(15);
                make.left.mas_equalTo(contentView.mas_left);
                make.right.mas_equalTo(contentView.mas_right);
                make.size.mas_equalTo(CGSizeMake(kSFAlertContentViewWidth, 50));
                make.bottom.mas_equalTo(contentView.mas_bottom);
            }];
        } else {
            
            [middleCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
                make.centerX.mas_equalTo(self);
                make.size.mas_equalTo(middleCustomView.size);
            }];
            
            [bottomLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(middleCustomView.mas_bottom).offset(20);
                make.left.mas_equalTo(contentView.mas_left);
                make.right.mas_equalTo(contentView.mas_right);
                make.size.mas_equalTo(CGSizeMake(kSFAlertContentViewWidth, 50));
                make.bottom.mas_equalTo(contentView.mas_bottom);
            }];
        }
        
        [_actions enumerateObjectsUsingBlock:^(SFAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [self actionButtonWithAction:obj toutalCount:_actions.count curentIndex:idx];
            button.tag = kSFAlertContentDefaultTag + idx;
            [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomLayerView addSubview:button];
        }];
        [self layoutIfNeeded];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                      message:(nullable NSString *)message
                topCustomView:(UIView *)topCustomView
                      actions:(NSArray <SFAlertAction *>*)actions
{
    
    NSAssert(topCustomView, @"custom view can not be nil");
    
    if (self = [super initWithFrame:frame]) {
        _actions = [actions copy];
        
        [self createContentView];
        [self topLayerView];
        [self titleLabel];
        titleLabel.text = title;
        
        if (message && message.length > 0) {
            [self messageLabel];
            messageLabel.text = message;
        }
        
        [self bottomLayerView];
        [self addSubview:topCustomView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(kSFAlertContentViewWidth);
        }];
        
        [topCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top).offset(25);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(topCustomView.size);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topCustomView.mas_bottom).offset(13);
            make.centerX.mas_equalTo(0);
            make.left.mas_greaterThanOrEqualTo(contentView.mas_left).offset(16);
            make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-16);
        }];
        
        [topLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.mas_top);
            make.left.right.mas_equalTo(contentView);
            make.height.mas_equalTo(kSFAlertContentViewTitleHeight);
        }];
        
        if (messageLabel) {
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.left.mas_equalTo(contentView.mas_left).offset(20);
                make.right.mas_lessThanOrEqualTo(contentView.mas_right).offset(-20);
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
            }];
            
            [bottomLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(messageLabel.mas_bottom).offset(25);
                make.left.mas_equalTo(contentView.mas_left);
                make.right.mas_equalTo(contentView.mas_right);
                make.size.mas_equalTo(CGSizeMake(kSFAlertContentViewWidth, 50));
                make.bottom.mas_equalTo(contentView.mas_bottom);
            }];
        } else {
            [bottomLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
                make.left.mas_equalTo(contentView.mas_left);
                make.right.mas_equalTo(contentView.mas_right);
                make.size.mas_equalTo(CGSizeMake(kSFAlertContentViewWidth, 50));
                make.bottom.mas_equalTo(contentView.mas_bottom);
            }];
        }
        
        [_actions enumerateObjectsUsingBlock:^(SFAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [self actionButtonWithAction:obj toutalCount:_actions.count curentIndex:idx];
            button.tag = kSFAlertContentDefaultTag + idx;
            [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomLayerView addSubview:button];
        }];
        [self layoutIfNeeded];
    }
    return self;
}

-(void)setOtherStyleDict:(NSDictionary *)otherStyleDict{
    _otherStyleDict = otherStyleDict;
    CALayer *layer = [_otherStyleDict valueForKey:kSFAlertControllerTitleNeedColorfulLayer];
    if (layer) {
        titleLabel.textColor = [UIColor whiteColor];
        layer.frame = topLayerView.bounds;
        [topLayerView.layer addSublayer:layer];
    }
    
    // contentView上移
    CGFloat margin = 0;
    id contentTopMoveMarginValue = [_otherStyleDict valueForKey:kSFAlertControllerContentTopMoveMarginKey];
    if ([contentTopMoveMarginValue respondsToSelector:@selector(integerValue)]) {
        margin = [contentTopMoveMarginValue integerValue];
    }
    if (margin > 0) {
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).offset(-margin);
        }];
    }
}

- (void)actionButtonClicked:(UIButton *)button {
    if (_actions.count > button.tag - kSFAlertContentDefaultTag) {
        SFAlertAction *action = [_actions objectAtIndex:button.tag - kSFAlertContentDefaultTag];
        if (action.handler) {
            action.handler(action);
        }
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in self.subviews) {
        if ([subview hitTest:[self convertPoint:point toView:subview] withEvent:event]) {
            return YES;
        }
    }
    return NO;
}

@end
