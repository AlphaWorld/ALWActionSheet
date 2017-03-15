//
//  UIImage+ALWColor.h
//  ALWUIKit
//
//  Created by JohnGump on 16/1/24.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ALWColor)

+ (UIImage *)alw_imageWithColor:(UIColor *)color;
+ (UIImage *)alw_imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)alw_imageWithTintColor:(UIColor *)tintColor;

@end
