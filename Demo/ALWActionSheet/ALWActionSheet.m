//
//  ALWActionSheet.m
//  snowball
//
//  Created by John on 17/2/6.
//  Copyright © 2017年 Snowball. All rights reserved.
//

#define ALWKeyWindow                     [UIApplication sharedApplication].keyWindow
#define ALWScreenWidth                   ([UIScreen mainScreen].bounds.size.width)
#define ALWScreenHeight                  ([UIScreen mainScreen].bounds.size.height)
#define ALWActionSheetCellHeight         56

#import <Foundation/Foundation.h>
#import "ALWActionSheet.h"
#import "ALWActionSheetCell.h"

@interface ALWActionSheet () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *actionArray;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) ALWActionType type;
@property (nonatomic, strong) ALWAction *selectAction;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) BOOL themeChangeable;

- (void)showActionSheetWithSheetTitles:(NSArray *)titles;

@end

@implementation ALWActionSheet

+ (instancetype)actionSheetWithTitle:(NSString *)title
{
    return [[ALWActionSheet alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        self.themeChangeable = YES;
    }
    return self;
}

- (void)addAction:(ALWAction *)action
{
    [self.actionArray addObject:action];
}

- (void)addCancelActionWithHandler:(void (^)(ALWAction *))handler
{
    ALWAction *cancelAction = [ALWAction cancelAction];
    cancelAction.handler = handler;
    [self addAction:cancelAction];
}

- (NSMutableArray *)actionArray
{
    if (!_actionArray) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ALWActionSheetCell class] forCellReuseIdentifier:NSStringFromClass([ALWActionSheetCell class])];
    }
    return _tableView;
}

- (void)show
{
    self.frame = ALWKeyWindow.bounds;
    [ALWKeyWindow addSubview:self];
    [self _alw_configSubviews];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.frame = [self _alw_frameForActionSheetView];
        }];
    }];
}

- (void)_alw_configSubviews
{
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.frame = self.bounds;
    [self addSubview:self.containerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_alw_dismiss)];
    tap.delegate = self;
    [self.containerView addGestureRecognizer:tap];
    self.tableView.frame = CGRectMake(0, ALWScreenHeight, ALWScreenWidth, [self _alw_heightForActionSheetView]);
    [self addSubview:self.tableView];
}

- (CGRect)_alw_dissmissFrameForActionSheetView
{
    return CGRectMake(0, ALWScreenHeight, ALWScreenWidth, [self _alw_heightForActionSheetView]);
}

- (CGRect)_alw_frameForActionSheetView
{
    return CGRectMake(0, ALWScreenHeight -  [self _alw_heightForActionSheetView], ALWScreenWidth,  [self _alw_heightForActionSheetView]);
}

- (CGFloat)_alw_heightForActionSheetView
{
    return ALWActionSheetCellHeight * self.actionArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ALWActionSheetCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALWActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ALWActionSheetCell class])];
    [cell setAction:self.actionArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALWAction *action = self.actionArray[indexPath.row];
    self.selectAction = action;
    if (action.type != ALWActionTypeCancel) {
        [self _alw_cleanSelectState];
        action.selected = YES;
    }
    [self _alw_dismiss];
}

- (void)_alw_cleanSelectState
{
    for (ALWAction *action in self.actionArray) {
        action.selected = NO;
    }
}

- (void)_alw_dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = [self _alw_dissmissFrameForActionSheetView];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
        } completion:^(BOOL finished) {
            if (self.selectAction.handler) {
                self.selectAction.handler(self.selectAction);
            }
            [self removeFromSuperview];
        }];
    }];
}

@end
