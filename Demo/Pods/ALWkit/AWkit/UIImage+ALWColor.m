//
//  UIImage+ALWColor.m
//  ALWUIKit
//
//  Created by JohnGump on 16/1/24.
//
//

#import "UIImage+ALWColor.h"

@implementation UIImage (ALWColor)

+ (UIImage *)alw_imageWithColor:(UIColor *)color size:(CGSize)size {
  CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

+ (UIImage *)alw_imageWithColor:(UIColor *)color {
  return [UIImage alw_imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

- (UIImage *)alw_imageWithTintColor:(UIColor *)tintColor {
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.f);
  [tintColor setFill];
  CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
  UIRectFill(bounds);

  [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
  [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];

  UIImage *tintImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return tintImage;
}

@end
