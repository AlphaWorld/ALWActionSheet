//
//  ViewController.m
//  Demo
//
//  Created by John on 17/3/15.
//  Copyright © 2017年 AlphaWorld. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "ALWActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.layer.cornerRadius = 2;
    titleButton.layer.borderWidth = 0.5;
    titleButton.layer.borderColor = [UIColor blackColor].CGColor;
    [titleButton addTarget:self action:@selector(titleOnly) forControlEvents:UIControlEventTouchUpInside];
    [titleButton setTitle:@"titleOnly" forState:UIControlStateNormal];
    [self.view addSubview:titleButton];
    
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    iconButton.layer.cornerRadius = 2;
    iconButton.layer.borderWidth = 0.5;
    iconButton.layer.borderColor = [UIColor blackColor].CGColor;
    [iconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [iconButton setTitle:@"titleWithIcon" forState:UIControlStateNormal];
    [iconButton addTarget:self action:@selector(titleWithIcon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconButton];
    
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedButton.layer.cornerRadius = 2;
    selectedButton.layer.borderWidth = 0.5;
    selectedButton.layer.borderColor = [UIColor blackColor].CGColor;
    [selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectedButton setTitle:@"selected" forState:UIControlStateNormal];
    [selectedButton addTarget:self action:@selector(selected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectedButton];
    
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@300);
        make.height.equalTo(@60);
    }];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(iconButton);
        make.top.bottom.equalTo(iconButton.mas_top).offset(-60);
    }];
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(iconButton);
        make.top.equalTo(iconButton.mas_bottom).offset(60);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self titleWithIcon];
}

- (void)titleOnly
{
    ALWActionSheet *action = [ALWActionSheet actionSheetWithTitle:nil];
    [action addAction:[ALWAction actionWithTitle:@"华为" handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"阿里巴巴" handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"雪球" handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addCancelActionWithHandler:nil];
    [action show];
}

- (void)titleWithIcon
{
    ALWActionSheet *action = [ALWActionSheet actionSheetWithTitle:nil];
    [action addAction:[ALWAction actionWithTitle:@"复制" iconImage:[UIImage imageNamed:@"icon_copy"] handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"删除" iconImage:[UIImage imageNamed:@"icon_delete"] handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"举报" iconImage:[UIImage imageNamed:@"icon_report"] handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"分享" iconImage:[UIImage imageNamed:@"icon_share"] handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addCancelActionWithHandler:nil];
    [action show];
}

- (void)selected
{
    ALWActionSheet *action = [ALWActionSheet actionSheetWithTitle:nil];
    [action addAction:[ALWAction actionWithTitle:@"华为" selected:NO handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"阿里巴巴" selected:NO handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addAction:[ALWAction actionWithTitle:@"雪球" selected:NO handler:^(ALWAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [action addCancelActionWithHandler:nil];
    [action show];
}

@end
