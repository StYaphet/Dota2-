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

//  力量英雄名字集合
@property (nonatomic,copy) NSSet *liliangSet;
//  敏捷英雄名字集合
@property (nonatomic,copy) NSSet *minjieSet;
//  智力英雄名字集合
@property (nonatomic,copy) NSSet *zhiliSet;


@end

@implementation HreoList

//  创建类的单例
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


/**
 *  自定义初始化方法
 *
 *  @return 类的实例
 */
- (instancetype)initPrivate{
    self = [super init];
    if (self) {
        _privateHeroList = [[NSMutableArray alloc] init];
        
        [self setHeroNameSet];
        
        [self setHeroArray];
        
    }
    return self;
}

/**
 *  添加英雄到相应的数组
 *
 *
 */
- (void)addHero:(heroModel *)hero{
    
    if ([self.liliangSet member:hero.name]) {
        [self.liliangHeroArray addObject:hero];
    }else if([self.minjieSet member:hero.name]){
        [self.minjieHeroArray addObject:hero];
    }else if([self.zhiliSet member:hero.name]){
        [self.zhiliHeroArray addObject:hero];
    }
}

/**
 *  初始化各英雄数组
 */
- (void)setHeroArray{
    
    NSMutableArray *liliangHeroArray = [[NSMutableArray alloc] init];
    NSMutableArray *minjieHeroArray = [[NSMutableArray alloc] init];
    NSMutableArray *zhiliHeroArray = [[NSMutableArray alloc] init];
    
    _liliangHeroArray = liliangHeroArray;
    _minjieHeroArray = minjieHeroArray;
    _zhiliHeroArray = zhiliHeroArray;
    
}


/**
 *    设置英雄的name集合，用于筛选数据
 */
- (void)setHeroNameSet{
    NSSet *liliangSet = [NSSet setWithObjects:@"斧王", @"撼地者",@"帕吉",@"沙王",@"斯温",@"小小",@"昆卡",@"斯拉达",@"潮汐猎人",@"兽王",@"冥魂大帝",@"龙骑士",@"发条技师",@"噬魂鬼",@"全能骑士",@"哈斯卡",@"暗夜魔王",@"末日使者",@"裂魂人",@"炼金术士",@"狼人",@"酒仙",@"混沌骑士",@"树精卫士",@"不朽尸王",@"艾欧",@"半人马战行者",@"马格纳斯",@"伐木机",@"钢背兽",@"巨牙海民",@"亚巴顿",@"上古巨神",@"军团指挥官",@"大地之灵",@"凤凰",nil];
    NSSet *minjieSet = [NSSet setWithObjects:@"敌法师", @"卓尔游侠",@"主宰",@"米拉娜",@"变体精灵",@"幻影长矛手",@"复仇之魂",@"力丸",@"狙击手",@"圣堂刺客",@"露娜",@"赏金猎人",@"熊战士",@"矮人直升机",@"德鲁伊",@"娜迦海妖",@"巨魔战将",@"灰烬之灵",@"天穹守望者",@"嗜血狂魔",@"影魔",@"剃刀",@"剧毒术士",@"虚空假面",@"幻影刺客",@"冥界亚龙",@"克林克兹",@"育母蜘蛛",@"编织者",@"幽鬼",@"米波",@"司夜刺客",@"斯拉克",@"美杜莎",@"恐怖利刃",@"凤凰",nil];
    NSSet *zhiliSet = [NSSet setWithObjects:@"水晶室女", @"帕克",@"风暴之灵",@"风行者",@"宙斯",@"莉娜",@"暗影萨满",@"修补匠",@"先知",@"魅惑魔女",@"杰奇洛",@"陈",@"沉默术士",@"食人魔魔法师",@"拉比克",@"干扰者",@"光之守卫",@"天怒法师",@"神谕者",@"工程师",@"祸乱之源",@"巫妖",@"莱恩",@"巫医",@"谜团",@"瘟疫法师",@"术士",@"痛苦女王",@"死亡先知",@"帕格纳",@"戴泽",@"拉席克",@"黑暗贤者",@"蝙蝠骑士",@"远古冰魂",@"祈求者",@"殁境神蚀者",@"暗影恶魔",@"维萨吉",@"寒冬飞龙",nil];
    self.liliangSet = liliangSet;
    self.minjieSet = minjieSet;
    self.zhiliSet = zhiliSet;
}

/**
 *  向外界展示的heroList
 *
 *  @return
 */
- (NSArray *)heroList{
    return self.privateHeroList;
}

@end
