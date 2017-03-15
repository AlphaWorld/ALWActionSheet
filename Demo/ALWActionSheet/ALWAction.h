//
//  ALWAction.h
//  snowball
//
//  Created by John on 17/3/14.
//  Copyright © 2017年 Snowball. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALWActionType) {
    ALWActionTypeTitleOnly = 0,
    ALWActionTypeTitleWithIcon,
    ALWActionTypeSelection,
    ALWActionTypeCancel
};

@interface ALWAction : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *iconImage;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign, readonly) ALWActionType type;
@property (nonatomic, copy) void (^handler)(ALWAction *action);
@property (nonatomic, strong) UIFont *font;

+ (instancetype)cancelAction;

+ (instancetype)actionWithTitle:(NSString *)title
                        handler:(void (^)(ALWAction *action))handler;
+ (instancetype)actionWithTitle:(NSString *)title
                      iconImage:(UIImage *)image
                        handler:(void (^)(ALWAction *action))handler;
+ (instancetype)actionWithTitle:(NSString *)title
                       selected:(BOOL)selected
                        handler:(void (^)(ALWAction *action))handler;

@end
