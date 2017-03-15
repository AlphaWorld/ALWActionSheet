//
//  UIView+ALWSnapshot.m
//  ALWUIKit
//
//  Created by JohnGump on 16/1/24.
//
//

#import "UIView+ALWSnapshot.h"

@implementation UIView (ALWSnapshot)

- (UIImage *)alw_snapshot {
  return [self alw_snapshotAfterScreenUpdates:NO];
}

- (UIImage *)alw_snapshotAfterScreenUpdates:(BOOL)afterUpdates;
{
  CGSize size = self.frame.size;
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [self drawViewHierarchyInRect:self.frame afterScreenUpdates:afterUpdates];
  UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  CGSize size2 = self.frame.size;
  if (fabs(size.height - size2.height) > 0.0001 ||
      fabs(size.width - size2.width) > 0.0001) {
    UIGraphicsBeginImageContextWithOptions(size2, NO,
                                           [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:afterUpdates];
    snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }

  return snap;
}

@end
