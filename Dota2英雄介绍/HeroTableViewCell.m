//
//  HeroTableViewCell.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/28.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HeroTableViewCell.h"
#import "HeroModel.h"
#import "UIImageView+WebCache.h"

@implementation HeroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.height * 2, self.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        self.profileImageView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:nameLabel];
        self.heroNameLable = nameLabel;
    }
    
    return self;
}

- (void)updateWithObject:(id)object {
    HeroModel *hero = (HeroModel *)object;
    self.profileImageView.image = hero.profileImage;
    
    //  获取英雄头像
    NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/heroes/%@_full.png",hero.engName];
    
    NSURL *url = [NSURL URLWithString:urlString];
    //  使用SDWebImage设置英雄头像
    [self.profileImageView sd_setImageWithURL:url];
    self.heroNameLable.text = hero.name;
    [self.heroNameLable sizeToFit];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    _profileImageView.left = 5;
    _profileImageView.centerY = self.contentView.centerY;
    
    _heroNameLable.left = _profileImageView.right + 5;
    _heroNameLable.centerY = _profileImageView.centerY;
}

@end
