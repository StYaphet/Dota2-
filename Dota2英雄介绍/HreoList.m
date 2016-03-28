//
//  HreoList.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/28.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HreoList.h"
#import "heroModel.h"

@interface HreoList ()

@property (nonatomic,strong) NSMutableArray *privateHeroList;

@end

@implementation HreoList

+(instancetype)sharedHeroList{
    static HreoList *heroList = nil;
    if (!heroList) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            heroList = [[self alloc] initPrivate];
        });
    }
    return heroList;
}



- (instancetype)initPrivate{
    self = [super init];
    if (self) {
        self.privateHeroList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addHero:(heroModel *)hero{
    [self.privateHeroList addObject:hero];
}

- (NSArray *)heroList{
    return self.privateHeroList;
}

@end
