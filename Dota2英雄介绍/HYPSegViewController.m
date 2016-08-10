//
//  HYPSegViewController.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/7/19.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPSegViewController.h"
#import "SegVCTitleBackView.h"
#import "UIView+Frame.h"

@interface HYPSegViewController ()

@end

@implementation HYPSegViewController

- (instancetype)initWithControllers: (NSArray *)controllers {
    self = [super init];
    if (self) {
        self.controllers = controllers;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *titles = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.controllers.count; i++) {
        UIViewController *controller = self.controllers[i];
        [titles addObject:controller.title];
    }
    
    _titleBackView = [[SegVCTitleBackView alloc] initWithTitles:titles];
    [self.view addSubview:_titleBackView];
    _titleBackView.top = 20;
    _titleBackView.centerY = self.view.centerY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
