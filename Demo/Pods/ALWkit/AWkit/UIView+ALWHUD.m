//
//  UIView+ALWHUD.m
//  snowball
//
//  Created by JohnGump on 16/1/24.
//  Copyright (c) 2015年 Snowball. All rights reserved.
//

#import "UIView+ALWHUD.h"

#include <objc/runtime.h>

static char *alw_activityIndicator = "alw_activityIndicator";
static NSInteger const ALWHUDTitleMaxLength = 12;

@interface UIView (_ALWHUD)
@property (nonatomic, strong, readwrite, setter=alw_setActivityIndicator:)
    UIActivityIndicatorView *alw_activityIndicator;
@end

@implementation UIView (ALWHUD)
- (MBProgressHUD *)_alw_hud
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        hud.cornerRadius = 4;
        hud.labelFont = [UIFont systemFontOfSize:16];
        hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        hud.graceTime = 0.3f;
        hud.minShowTime = 0.3f;
        hud.margin = 10.f;
        CGFloat screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
        hud.yOffset -= screenHeight * 0.05;
        [self addSubview:hud];
    }
    return hud;
}

#pragma mark - HUD
- (MBProgressHUD *)alw_showHUDWithWarningText:(NSString *)text
{
    return [self alw_showHUDWithWarningText:text complete:NULL];
}

- (MBProgressHUD *)alw_showHUDWithWarningText:(NSString *)text complete:(MBProgressHUDCompletionBlock)block
{
    MBProgressHUD *hud = [self _alw_hud];
    hud.mode = MBProgressHUDModeText;
    [self _alw_hud:hud showsText:text];
    [hud hide:YES afterDelay:1.3f];
    if (block) {
        [hud setCompletionBlock:block];
    }
    return hud;
}

- (MBProgressHUD *)alw_showHUDLoadingIndicatorWithText:(NSString *)text
{
    MBProgressHUD *hud = [self _alw_hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.margin = 20.f;
    if (!text.length) {
        text = @"加载中...";
    }
    [self _alw_hud:hud showsText:text];
    [hud show:YES];
    return hud;
}

- (MBProgressHUD *)alw_showHUDCompleteIndicatorWithText:(NSString *)text
{
    return [self alw_showHUDCompleteIndicatorWithText:text hideAfterDelay:1.3f complete:NULL];
}

- (MBProgressHUD *)alw_showHUDCompleteIndicatorWithText:(NSString *)text
                                               complete:(MBProgressHUDCompletionBlock)block
{
    return [self alw_showHUDCompleteIndicatorWithText:text hideAfterDelay:1.3f complete:block];
}

- (MBProgressHUD *)alw_showHUDCompleteIndicatorWithText:(NSString *)text
                                         hideAfterDelay:(CGFloat)delay
                                               complete:(MBProgressHUDCompletionBlock)block;
{
    MBProgressHUD *hud = [self _alw_hud];
    if (text == nil) {
        [hud hide:YES];
    } else {
        [self _alw_hud:hud showsText:text];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:delay];
        if (block != NULL) {
            [hud setCompletionBlock:block];
        }
    }
    return hud;
}

- (void)alw_hideHUDViewsAnimated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self animated:animated];
}

- (void)_alw_hud:(MBProgressHUD *)hud showsText:(NSString *)text
{
    if (text.length > ALWHUDTitleMaxLength) {
        hud.detailsLabelText = text;
    } else {
        hud.labelText = text;
    }
}

#pragma mark - Indicatior
- (UIActivityIndicatorView *)alw_activityIndicator
{

    return objc_getAssociatedObject(self, alw_activityIndicator);
}

- (void)alw_setActivityIndicator:(UIActivityIndicatorView *)indicator
{

    objc_setAssociatedObject(self, alw_activityIndicator, indicator,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)alw_startActivityIndicator
{
    if (!self.alw_activityIndicator) {
        self.alw_activityIndicator = [[UIActivityIndicatorView alloc]
            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.alw_activityIndicator.center =
            CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        self.alw_activityIndicator.autoresizingMask =
            UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
            UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.alw_activityIndicator.hidesWhenStopped = YES;
        [self addSubview:self.alw_activityIndicator];
    }
    [self.alw_activityIndicator setHidden:NO];
    [self.alw_activityIndicator startAnimating];
}

- (void)alw_stopActivityIndicator
{
    if (self.alw_activityIndicator) {
        [self.alw_activityIndicator setHidden:YES];
        [self.alw_activityIndicator removeFromSuperview];
        self.alw_activityIndicator = nil;
    }
}

@end
