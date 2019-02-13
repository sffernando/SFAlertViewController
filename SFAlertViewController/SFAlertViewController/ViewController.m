//
//  ViewController.m
//  SFAlertViewController
//
//  Created by Fernando on 2019/2/10.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "ViewController.h"

#import "SFAlertViewController.h"
#import "SFTexFeildAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark -- UITableViewDataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = indexPath.row == 0 ? @"Normal Style" : @"TextFeild Style";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showNormalAlertView];
    } else {
        [self showTextFeildAlert];
    }
}

- (void)showNormalAlertView {
    SFAlertViewController *controller = [SFAlertViewController alertControllerWithTitle:@"Warning" message:@"This is the message of the alert content"];
    SFAlertAction *cancleAction = [SFAlertAction actionWithTitle:@"Cancle" style:SFAlertActionStyleCancel handler:^(SFAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    SFAlertAction *sureAction = [SFAlertAction actionWithTitle:@"Sure" style:SFAlertActionStyleNormal handler:^(SFAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [controller addAction:cancleAction];
    [controller addAction:sureAction];
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)showTextFeildAlert {
    NSDictionary *attr = @{kSFAlertControllerTextFeildFontKey
                           : [UIFont systemFontOfSize:15],
                           kSFAlertControllerTextFeildTextColorKey
                           : [UIColor blackColor],
                           kSFAlertControllerTextFeildPlacehoderKey
                           : @"text",
                           kSFAlertControllerTextFeildPlacehoderTextAlinementKey
                           : @(NSTextAlignmentLeft),
                           kSFAlertControllerTextFeildPlacehoderTextColorKey
                           : [UIColor lightGrayColor],
                           };
    
    SFTexFeildAlertViewController *alert = [SFTexFeildAlertViewController alertControllerWithTitle:@"TextFeild Styele" textFeildArribute:attr];
    [alert addAction:[SFAlertAction actionWithTitle:@"Cancle" style:SFAlertActionStyleCancel handler:^(SFAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[SFAlertAction actionWithTitle:@"Sure" style:SFAlertActionStyleNormal handler:^(SFAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
