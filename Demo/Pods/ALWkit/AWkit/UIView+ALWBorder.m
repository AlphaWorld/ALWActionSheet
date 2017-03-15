//
//  UIView+ALWBorder.m
//  ALWUIKit
//
//  Created by hbucius on 16/1/27.
//
//

#include <objc/runtime.h>
#import "Masonry.h"
#import "UIView+ALWBorder.h"

static NSInteger const ALWborderEdgeOffset = 20150810;

@implementation UIView (ALWBorder)

- (void)alw_addBorderViewAtEdges:(UIRectEdge)edge
                           color:(UIColor *)color
                          insets:(UIEdgeInsets)insets {
  if (!color) {
    color = [UIColor lightGrayColor];
  }

  if (edge & UIRectEdgeTop) {
    [self _alw_updateBorderAtEdge:UIRectEdgeTop color:color insets:insets];
  }
  if (edge & UIRectEdgeLeft) {
    [self _alw_updateBorderAtEdge:UIRectEdgeLeft color:color insets:insets];
  }
  if (edge & UIRectEdgeBottom) {
    [self _alw_updateBorderAtEdge:UIRectEdgeBottom color:color insets:insets];
  }
  if (edge & UIRectEdgeRight) {
    [self _alw_updateBorderAtEdge:UIRectEdgeRight color:color insets:insets];
  }

  objc_setAssociatedObject(self, @selector(_alw_borderEdge), @(edge),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)alw_addBorderViewAtEdges:(UIRectEdge)edge color:(UIColor *)color {
  [self alw_addBorderViewAtEdges:edge color:color insets:UIEdgeInsetsZero];
}

- (UIRectEdge)_alw_borderEdge {
  return [objc_getAssociatedObject(self, @selector(_alw_borderEdge))
      unsignedIntegerValue];
}

- (UIEdgeInsets)insetsToContainer {
  NSValue *value = objc_getAssociatedObject(self, @selector(insetsToContainer));
  if (value) {
    UIEdgeInsets insets = [value UIEdgeInsetsValue];
    return insets;
  }
  return UIEdgeInsetsZero;
}

- (void)setInsetsToContainer:(UIEdgeInsets)insetsToContainer {
  NSValue *value = [NSValue valueWithUIEdgeInsets:insetsToContainer];
  objc_setAssociatedObject(self, @selector(insetsToContainer), value,
                           OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)_alw_borderViewWithColor:(UIColor *)color {
  UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
  view.backgroundColor = color;
  view.translatesAutoresizingMaskIntoConstraints = NO;
  return view;
}

- (void)alw_removeBorderViewAtEdge:(UIRectEdge)edge {
  [[self _alw_borderViewsAtEdge:edge]
      enumerateObjectsUsingBlock:^(UIView *border, NSUInteger idx, BOOL *stop) {
        [border removeFromSuperview];
      }];
  // 剔除对应的边
  edge = [self _alw_borderEdge] ^ ([self _alw_borderEdge] & edge);
  objc_setAssociatedObject(self, @selector(_alw_borderEdge), @(edge),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)alw_removeAllBorderView {
  if ([self _alw_borderEdge] != UIRectEdgeNone) {
    [[self _alw_borderViewsAtEdge:[self _alw_borderEdge]]
        enumerateObjectsUsingBlock:^(UIView *border, NSUInteger idx,
                                     BOOL *stop) {
          [border removeFromSuperview];
        }];
    objc_setAssociatedObject(self, @selector(_alw_borderEdge),
                             @(UIRectEdgeNone),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
}

- (NSArray *)_alw_borderViewsAtEdge:(UIRectEdge)edge {
  NSParameterAssert(edge != UIRectEdgeNone);
  NSMutableArray *borders = [NSMutableArray array];
  if (edge & UIRectEdgeTop) {
    if ([self viewWithTag:UIRectEdgeTop + ALWborderEdgeOffset]) {
      [borders
          addObject:[self viewWithTag:UIRectEdgeTop + ALWborderEdgeOffset]];
    }
  }
  if (edge & UIRectEdgeBottom) {
    if ([self viewWithTag:UIRectEdgeBottom + ALWborderEdgeOffset]) {
      [borders
          addObject:[self viewWithTag:UIRectEdgeBottom + ALWborderEdgeOffset]];
    }
  }
  if (edge & UIRectEdgeLeft) {
    if ([self viewWithTag:UIRectEdgeLeft + ALWborderEdgeOffset]) {
      [borders
          addObject:[self viewWithTag:UIRectEdgeLeft + ALWborderEdgeOffset]];
    }
  }
  if (edge & UIRectEdgeRight) {
    if ([self viewWithTag:UIRectEdgeRight + ALWborderEdgeOffset]) {
      [borders
          addObject:[self viewWithTag:UIRectEdgeRight + ALWborderEdgeOffset]];
    }
  }
  return [borders copy];
}

- (UIView *)_alw_borderViewAtEdge:(UIRectEdge)edge {
  return [self viewWithTag:edge + ALWborderEdgeOffset];
}

- (UIView *)_alw_updateBorderAtEdge:(UIRectEdge)edge
                              color:(UIColor *)color
                             insets:(UIEdgeInsets)insets {
  UIView *view = [self _alw_borderViewAtEdge:edge];
  if (!view) {
    view = [self _alw_borderViewWithColor:color];
    view.tag = edge + ALWborderEdgeOffset;
    [self addSubview:view];
  }
  view.backgroundColor = color;
  const CGFloat width = 1.0 / [UIScreen mainScreen].scale;
  if (edge == UIRectEdgeTop) {
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.height.equalTo(@(width));
      make.left.right.top.equalTo(self).with.insets(insets);
    }];
  } else if (edge == UIRectEdgeLeft) {
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(width));
      make.left.top.bottom.equalTo(self).with.insets(insets);
    }];
  } else if (edge == UIRectEdgeBottom) {
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.height.equalTo(@(width));
      make.left.right.bottom.equalTo(self).with.insets(insets);
    }];
  } else if (edge == UIRectEdgeRight) {
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@(width));
      make.right.top.bottom.equalTo(self).with.insets(insets);
    }];
  }
  [view setInsetsToContainer:insets];
  return view;
}

@end
