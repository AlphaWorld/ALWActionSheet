//
//  ALWActionSheetCell.m
//  snowball
//
//  Created by John on 17/3/14.
//  Copyright © 2017年 Snowball. All rights reserved.
//

#import "ALWActionSheetCell.h"
#import "UIColor+ALWHexString.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define ALWTitleColor @"#333333"
#define ALWBackgroundColor @"#ffffff"
#define ALWSeparatorLineColor @"#edf0f5"
#define ALWSelectedBackgroundColor @"#edf0f5"

@interface ALWActionSheetCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ALWActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _alw_configSubviews];
        [self _alw_configConstraints];
    }
    return self;
}

- (void)_alw_configSubviews
{
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.titleLabel.textColor = [UIColor alw_colorFromHexString:ALWTitleColor];
    self.contentView.backgroundColor = [UIColor alw_colorFromHexString:ALWBackgroundColor];
    self.lineView.backgroundColor = [UIColor alw_colorFromHexString:ALWSeparatorLineColor];
    self.selectedBackgroundView.backgroundColor = [UIColor alw_colorFromHexString:ALWSelectedBackgroundColor];
}

- (void)_alw_configConstraints
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(24);
        make.width.height.equalTo(@18);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.contentView).offset(24);
        make.right.equalTo(self.contentView).offset(-24);
    }];
}

- (void)setAction:(ALWAction *)action
{
    _action = action;
    self.titleLabel.text = action.title;
    self.iconImageView.image = action.iconImage;
    self.titleLabel.font = action.font;
    switch (action.type) {
        case ALWActionTypeCancel: {
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.centerX.equalTo(self.contentView);
            }];
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.height.equalTo(@0.5);
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
            }];
            break;
        }
        case ALWActionTypeSelection: {
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.iconImageView.mas_right).offset(18);
            }];
            @weakify(self);
            [RACObserve(_action, selected) subscribeNext:^(id x) {
                @strongify(self);
                self.iconImageView.hidden = !self.action.selected;
            }];
            break;
        }
        case ALWActionTypeTitleWithIcon: {
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.iconImageView.mas_right).offset(18);
            }];
            break;
        }
        case ALWActionTypeTitleOnly: {
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(24);
            }];
        }
            break;
    }
}

@end
