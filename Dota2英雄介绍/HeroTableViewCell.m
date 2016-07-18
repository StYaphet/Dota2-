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

@implementation HeroTableViewCell {
    UIView *_sepView;
}

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
        
        UILabel *heroTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:heroTypeLabel];
        self.heroTypeLable = heroTypeLabel;
        
        
        _sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        _sepView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_sepView];
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
    
    NSMutableString *herotTypeString = @"".mutableCopy;
    for(int i = 0;i < hero.roles_l.count; i++) {
        [herotTypeString appendString: [NSString stringWithFormat:@"%@ ",hero.roles_l[i]]];
    }
    
    self.heroTypeLable.text = herotTypeString;
    self.heroTypeLable.textColor = [UIColor redColor];
    [self.heroTypeLable sizeToFit];
    
    [self setNeedsLayout];
    
    
}

- (void)layoutSubviews {
    _profileImageView.left = 5;
    _profileImageView.centerY = self.contentView.centerY;
    
    _heroNameLable.left = _profileImageView.right + 5;
    _heroNameLable.top = 0;
    
    _heroTypeLable.top = _heroNameLable.bottom + 2;
    _heroTypeLable.left = _profileImageView.right + 5;
    
    _sepView.left = 0;
    _sepView.bottom = self.contentView.bottom;
}

@end
