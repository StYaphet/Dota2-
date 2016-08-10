//
//  HYPSegViewController.h
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/7/19.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegVCTitleBackView;

@interface HYPSegViewController : UIViewController

@property (nonatomic, copy) NSArray *controllers;

@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) SegVCTitleBackView *titleBackView;

- (instancetype)initWithControllers: (NSArray *)controllers;

@end
