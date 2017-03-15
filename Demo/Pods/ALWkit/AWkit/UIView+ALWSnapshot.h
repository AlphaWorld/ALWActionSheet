//
//  UIView+ALWSnapshot.h
//  ALWUIKit
//
//  Created by hbucius on 16/1/26.
//
//

#import <UIKit/UIKit.h>

@interface UIView (ALWSnapshot)

- (UIImage *)alw_snapshot;

- (UIImage *)alw_snapshotAfterScreenUpdates:(BOOL)afterUpdates;

@end
