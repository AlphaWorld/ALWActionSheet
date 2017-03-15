//
//  UIColor+ALWHexString.m
//  ALWUIKit
//
//  Created by JohnGump on 16/1/24.
//
//

#import "UIColor+ALWHexString.h"

@implementation UIColor (ALWHexString)

// color from RGB or RGBA hex value starts with '#'
+ (UIColor *)alw_colorFromHexString:(NSString *)hexString {
  if (![[hexString substringToIndex:1] isEqualToString:@"#"]) {
    hexString = [NSString stringWithFormat:@"#%@", hexString];
  }

  if (hexString.length == 4) {
    NSString *str1 = [hexString substringWithRange:NSMakeRange(1, 1)];
    NSString *str2 = [hexString substringWithRange:NSMakeRange(2, 1)];
    NSString *str3 = [hexString substringWithRange:NSMakeRange(3, 1)];
    hexString = [NSString
        stringWithFormat:@"#%@%@%@%@%@%@", str1, str1, str2, str2, str3, str3];
  }
  if (hexString.length != 7 && hexString.length != 9) {
    NSAssert(NO, @"长度不合法: %@", hexString);
    return [UIColor clearColor];
  }
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  scanner.scanLocation = 1;
  unsigned int hex;
  [scanner scanHexInt:&hex];
  if (hexString.length == 7) {
    unsigned int r = (hex & 0xFF0000) >> 16;
    unsigned int g = (hex & 0x00FF00) >> 8;
    unsigned int b = hex & 0x0000FF;
    return [UIColor colorWithRed:r / 255.0
                           green:g / 255.0
                            blue:b / 255.0
                           alpha:1.0];
  } else {
    unsigned int r = (hex & 0xFF000000) >> 24;
    unsigned int g = (hex & 0x00FF0000) >> 16;
    unsigned int b = (hex & 0x0000FF00) >> 8;
    unsigned int a = hex & 0x000000FF;
    return [UIColor colorWithRed:r / 255.0
                           green:g / 255.0
                            blue:b / 255.0
                           alpha:a / 255.0];
  }

  return nil;
}

@end
