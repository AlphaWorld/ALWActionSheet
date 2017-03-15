//
//  ALWActionSheet.h
//  snowball
//
//  Created by John on 17/2/6.
//  Copyright © 2017年 Snowball. All rights reserved.
//  ALWActionSheet是View层自定义的ALWActionSheet，不会应为keyWindow层有视图而被遮挡

#import <UIKit/UIKit.h>
#import "ALWAction.h"

@class ALWActionSheet;

@interface ALWActionSheet : UIView

+ (instancetype)actionSheetWithTitle:(NSString *)title;
- (void)addAction:(ALWAction *)action;
- (void)addCancelActionWithHandler:(void (^)(ALWAction *action))handler;
- (void)show;

@end
