//
//  SegVCTitleBackView.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/7/29.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "SegVCTitleBackView.h"
#import "UIView+Frame.h"

@implementation SegVCTitleBackView

- (instancetype)initWithTitles:(NSArray *)titles {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    if (self) {
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i;
            [button sizeToFit];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = self.width / 4;
    for(NSInteger i = 0;i < self.subviews.count;i++) {
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *button = self.subviews[i];
            button.center = CGPointMake((0.5 + i) * space, self.height / 2);
        }
    }
}

@end
