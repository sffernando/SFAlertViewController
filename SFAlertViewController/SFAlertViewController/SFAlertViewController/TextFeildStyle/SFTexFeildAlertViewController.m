//
//  SFTexFeildAlertViewController.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/13.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFTexFeildAlertViewController.h"
#import "SFAlertControllerTransitionAnimator.h"
#import "SFAlertViewPresentationController.h"

@interface SFTexFeildAlertViewController ()<UIViewControllerTransitioningDelegate> {
    NSString *_alertTitle;
    NSString *_subTitle;
    NSDictionary *_attribute;
}

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;


@end

@implementation SFTexFeildAlertViewController


@dynamic view;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title textFeildArribute:(NSDictionary *)textFeildArribute; {
    SFTexFeildAlertViewController *controller = [[SFTexFeildAlertViewController alloc] initWithTitle:title textFeildArribute:textFeildArribute];
    return controller;
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title subTitle:(NSString *)subTitle textFeildArribute:(NSDictionary *)textFeildArribute {
    SFTexFeildAlertViewController *controller = [[SFTexFeildAlertViewController alloc] initWithTitle:title subTitle:subTitle textFeildArribute:textFeildArribute];
    return controller;
}

- (instancetype)initWithTitle:(nullable NSString *)title textFeildArribute:(NSDictionary *)textFeildArribute; {
    if (self = [super init]) {
        _alertTitle = title;
        _attribute = textFeildArribute;
        [self createDefaultValue];
    }
    return self;
}

- (instancetype)initWithTitle:(nullable NSString *)title subTitle:(NSString *)subTitle textFeildArribute:(NSDictionary *)textFeildArribute; {
    if (self = [super init]) {
        _alertTitle = title;
        _attribute = textFeildArribute;
        _subTitle = subTitle;
        [self createDefaultValue];
    }
    return self;
}

- (void)createDefaultValue {
    _actions = [NSArray array];
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = [[SFTextFeildAlertContentView alloc] initWithFrame:self.view.bounds title:_alertTitle subTitle:_subTitle textFeildArribute:_attribute actions:_actions];
    [self addTextChangedObserver];
}

- (BOOL)textFeildIsEmpty {
    NSString *text = [(SFTextFeildAlertContentView *)self.view textFeild].text;
    NSString *tmpTex =  [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return tmpTex.length == 0;
}

- (NSString *)textFeildContent {
    NSString *text = [(SFTextFeildAlertContentView *)self.view textFeild].text;
    NSString *tmpTex =  [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return tmpTex;
}

- (void)setTextFieldContent:(NSString *)text {
    UITextField *textField = [(SFTextFeildAlertContentView *)self.view textFeild];
    textField.text = text;
}

- (void)addTextChangedObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)textFieldChanged:(UITextField *)textField {
    if (_textChangedBlock) {
        _textChangedBlock([self textFeildContent]);
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
    presentationController.backgroundTapDismissalGestureEnabled = NO;
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
