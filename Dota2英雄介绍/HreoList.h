//
//  HreoList.h
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/28.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class heroModel;

@interface HreoList : NSObject
//  对外展示的heroList
@property (nonatomic,strong) NSArray *heroList;
//  力量英雄数组
@property (nonatomic,copy) NSMutableArray *liliangHeroArray;
//  力量英雄名字集合
@property (nonatomic,copy) NSSet *liliangSet;
//  敏捷英雄数组
@property (nonatomic,copy) NSMutableArray *minjieHeroArray;
//  敏捷英雄名字集合
@property (nonatomic,copy) NSSet *minjieSet;
//  智力英雄数组
@property (nonatomic,copy) NSMutableArray *zhiliHeroArray;
//  智力英雄名字集合
@property (nonatomic,copy) NSSet *zhiliSet;

+(instancetype)sharedHeroList;
- (void)addHero:(heroModel *)hero;

@end
