//
//  SegVCTitleBackView.h
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/7/29.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegVCTitleBackView : UIView

@property (nonatomic,copy) NSArray *titles;

- (instancetype)initWithTitles:(NSArray *)titles;

@end
