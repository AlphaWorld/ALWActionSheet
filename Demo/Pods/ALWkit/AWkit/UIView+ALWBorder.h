//
//  UIView+ALWBorder.h
//  ALWUIKit
//
//  Created by hbucius on 16/1/27.
//
//

#import <UIKit/UIKit.h>

@interface UIView (ALWBorder)

- (void)alw_addBorderViewAtEdges:(UIRectEdge)edge
                           color:(UIColor *)color
                          insets:(UIEdgeInsets)insets;
- (void)alw_addBorderViewAtEdges:(UIRectEdge)edge color:(UIColor *)color;
- (void)alw_removeBorderViewAtEdge:(UIRectEdge)edge;
- (void)alw_removeAllBorderView;

@end
