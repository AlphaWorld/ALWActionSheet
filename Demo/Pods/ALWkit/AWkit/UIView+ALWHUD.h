//
//  UIView+ALWHUD.h
//  snowball
//
//  Created by JohnGump on 16/1/24.
//  Copyright (c) 2015年 Snowball. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (ALWHUD)

- (MBProgressHUD *)alw_showHUDWithWarningText:(NSString *)text;
- (MBProgressHUD *)alw_showHUDWithWarningText:(NSString *)text
                                     complete:
                                         (MBProgressHUDCompletionBlock)block;
- (MBProgressHUD *)alw_showHUDLoadingIndicatorWithText:(NSString *)text;
- (MBProgressHUD *)alw_showHUDCompleteIndicatorWithText:(NSString *)text;
- (MBProgressHUD *)
alw_showHUDCompleteIndicatorWithText:(NSString *)text
                            complete:(MBProgressHUDCompletionBlock)block;
- (MBProgressHUD *)
alw_showHUDCompleteIndicatorWithText:(NSString *)text
                      hideAfterDelay:(CGFloat)delay
                            complete:(MBProgressHUDCompletionBlock)block;
- (void)alw_hideHUDViewsAnimated:(BOOL)animated;

- (void)alw_startActivityIndicator;
- (void)alw_stopActivityIndicator;

@end
