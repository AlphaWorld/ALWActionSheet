//
//  UITabBarItem+ALWRemindBadge.m
//
//  Created by JohnGump on 16/1/24.
//  Copyright © 2016年 Snowball. All rights reserved.
//

#import "UITabBarItem+ALWRemindBadge.h"

@implementation UITabBarItem (ALWRemindBadge)

#define CUSTOM_BADGE_TAG 97

- (void)alw_setCustomBadgeSize:(CGSize )size
                         Color:(UIColor *)color
{
    UIView *itemView = [self valueForKey:@"view"];
    for (UIView *view in itemView.subviews) {
        if (view.tag == CUSTOM_BADGE_TAG) {
            [view removeFromSuperview];
        }
    }
    UIView *badgeView = [[UIView alloc] init];
    badgeView.frame = CGRectMake(itemView.bounds.size.width / 2 + 10, 5, size.width, size.height);
    badgeView.layer.borderWidth = 1;
    [badgeView setBackgroundColor:color];
    badgeView.layer.borderColor = [color CGColor];
    badgeView.layer.cornerRadius = badgeView.frame.size.height / 2;
    badgeView.layer.masksToBounds = YES;
    badgeView.tag = CUSTOM_BADGE_TAG;
    [itemView addSubview:badgeView];
}

@end
