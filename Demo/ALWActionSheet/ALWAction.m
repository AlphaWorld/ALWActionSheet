//
//  ALWAction.m
//  snowball
//
//  Created by John on 17/3/14.
//  Copyright © 2017年 Snowball. All rights reserved.
//

#import "ALWAction.h"

#define iOSVersionGreaterThanOrEqualTo(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOSVersionGreaterThanOrEqualTo(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ALWAction ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) ALWActionType type;

@end

@implementation ALWAction

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        self.font = [ALWAction _alw_deafaultFont];
    }
    return self;
}

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(ALWAction *))handler
{
    ALWAction *action = [[ALWAction alloc] initWithTitle:title];
    action.handler  = handler;
    action.type = ALWActionTypeTitleOnly;
    return action;
}

+ (instancetype)actionWithTitle:(NSString *)title iconImage:(UIImage *)image handler:(void (^)(ALWAction *))handler
{
    ALWAction *action = [ALWAction actionWithTitle:title handler:handler];
    action.iconImage = image;
    action.type = ALWActionTypeTitleWithIcon;
    return action;
}

+ (instancetype)actionWithTitle:(NSString *)title selected:(BOOL)selected handler:(void (^)(ALWAction *))handler
{
    ALWAction *action = [ALWAction actionWithTitle:title handler:handler];
    action.selected = selected;
    action.iconImage = [UIImage imageNamed:@"icon_check"];
    action.type = ALWActionTypeSelection;
    return action;
}

+ (instancetype)cancelAction
{
    ALWAction *action = [[ALWAction alloc] initWithTitle:@"取消"];
    action.type = ALWActionTypeCancel;
    action.font = [ALWAction _alw_cancelFont];
    return action;
}

+ (UIFont *)_alw_deafaultFont
{
    return [UIFont fontWithName:[ALWAction alw_fontRegular] size:18];
}

+ (UIFont *)_alw_cancelFont
{
    return [UIFont fontWithName:[ALWAction alw_fontMedium] size:18];
}

+ (NSString *)alw_fontMedium
{
    if (iOSVersionGreaterThanOrEqualTo(@"9")) {
        return @"PingFangSC-Medium";
    } else {
        return @"HelveticaNeue-Medium";
    }
}

+ (NSString *)alw_fontRegular
{
    if (iOSVersionGreaterThanOrEqualTo(@"9")) {
        return @"PingFangSC-Regular";
    } else {
        return @"HelveticaNeue";
    }
}

@end
