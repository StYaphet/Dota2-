//
//  HeroTableViewCell.h
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/28.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@interface HeroTableViewCell : UITableViewCell

@property (weak, nonatomic) UIImageView *profileImageView;
@property (weak, nonatomic) UILabel *heroNameLable;
@property (weak, nonatomic) UILabel *heroTypeLable;

- (void)updateWithObject:(id)object;

@end
