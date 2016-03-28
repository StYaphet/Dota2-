//
//  HeroListViewController.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/23.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HeroListViewController.h"
#import "heroModel.h"
#import "UIImageView+WebCache.h"
#import "HeroTableViewCell.h"
#import "TestControllerViewController.h"

@interface HeroListViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic,copy) NSArray *liliangHeroArray;
@property (nonatomic,copy) NSSet *liliangSet;
@property (nonatomic,copy) NSArray *minjieHeroArray;
@property (nonatomic,copy) NSSet *minjieSet;
@property (nonatomic,copy) NSArray *zhiliHeroArray;
@property (nonatomic,copy) NSSet *zhiliSet;
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,weak) UIImageView *headerView;
@property (nonatomic,assign) CGFloat height;

@end

@implementation HeroListViewController

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  设置表格的header视图
    [self setAHeaderView];
    //  设置英雄的name集合，用于筛选数据
    [self setHeroNameSet];
    //  从json中获取英雄的详细信息
    [self getHeroDetail];
    
    [self getHeroPictures];
    
    UINib *nib = [UINib nibWithNibName:@"HeroTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"HeroCell"];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义方法

/**
 *  自定义初始化方法
 *
 *  @param style tableView样式
 *  @param tag   前一个视图控制器传过来的tag，用于标识加载哪个数据源
 *
 *  @return 返回初始化后的tableView
 */
- (instancetype)initWithStyle:(UITableViewStyle)style andTag:(NSInteger)tag{
    self = [super initWithStyle:style];
    if (self) {
        self.tag = tag;
    }
    return self;
}

/**
 *    设置表格的header视图
 */
- (void)setAHeaderView{
    NSString *headImagePath = nil;
    if (!headImagePath) {
        switch (self.tag) {
            case 0:{
                headImagePath = [[NSBundle mainBundle] pathForResource:@"liliang" ofType:@"jpg"];
            }
                break;
            case 1:{
                headImagePath = [[NSBundle mainBundle] pathForResource:@"minjie" ofType:@"jpg"];
            }
                break;
                
            case 2:{
                headImagePath = [[NSBundle mainBundle] pathForResource:@"zhili" ofType:@"jpg"];
            }
                break;
            default:
                break;
        }
    }
    UIImageView *headImageView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:headImagePath]];
    headImageView.frame = CGRectMake(0, -200, self.view.bounds.size.width, 200);
    self.tableView.contentInset = UIEdgeInsetsMake(headImageView.bounds.size.height, 0, 0, 0);
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.clipsToBounds = YES;
    self.height = headImageView.frame.size.height;
    self.headerView = headImageView;
    [self.tableView addSubview:headImageView];
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
 *    从json中获取英雄的详细信息
 */
- (void)getHeroDetail{
        NSBundle *bundle = [NSBundle mainBundle];
        if (bundle) {
            NSString *fileURLString = [bundle pathForResource:@"heroData" ofType:@"json"];
            if (fileURLString) {
                NSData *data = [NSData dataWithContentsOfFile:fileURLString];
    
                NSDictionary *heroDictory = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSMutableArray *liliangHeroArray = [[NSMutableArray alloc] init];
                NSMutableArray *minjieHeroArray = [[NSMutableArray alloc] init];
                NSMutableArray *zhiliHeroArray = [[NSMutableArray alloc] init];
                [heroDictory enumerateKeysAndObjectsUsingBlock:^(NSString *name,NSDictionary *object,BOOL *stop){

                    heroModel *hero = [[heroModel alloc] init];
                    hero.name = object[@"name"];
                    hero.bio = object[@"bio"];
                    hero.atk_l = object[@"atk_l"];
                    hero.roles_l = object[@"roles_l"];
                    hero.engName = name;
                    
                    
                    if ([self.liliangSet member:object[@"name"]]) {
                        [liliangHeroArray addObject:hero];
                    }else if([self.minjieSet member:object[@"name"]]){
                        [minjieHeroArray addObject:hero];
                    }else if([self.zhiliSet member:object[@"name"]]){
                        [zhiliHeroArray addObject:hero];
                    }
                }];
                self.liliangHeroArray = liliangHeroArray;
                self.minjieHeroArray = minjieHeroArray;
                self.zhiliHeroArray = zhiliHeroArray;
            }
        }
}

- (void)getHeroPictures{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.tag) {
        case (NSInteger)0:
            return [self.liliangHeroArray count];
            break;
        case (NSInteger)1:
            return [self.minjieHeroArray count];
            break;
            
        case (NSInteger)2:
            return [self.zhiliHeroArray count];
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HeroTableViewCell alloc] init];
    }
    heroModel *hero = nil;
    if (!hero) {
        switch (self.tag) {
            case (NSInteger)0:{
                hero = self.liliangHeroArray[indexPath.row];
            }
                break;
            case (NSInteger)1:{
                hero = self.minjieHeroArray[indexPath.row];
            }
                break;
                
            case (NSInteger)2:{
                hero = self.zhiliHeroArray[indexPath.row];
            }
                break;
        }
    }
    cell.heroNameLable.text = hero.name;
    
    NSLog(@"%@",hero.engName);
    
    NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/heroes/%@_full.png",hero.engName];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [cell.profileImageView sd_setImageWithURL:url];
    cell.profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
        NSLog(@"3D Touch有效");
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }{
        NSLog(@"3D Touch无效");
    }
    
    
    return cell;
}

#pragma mark - scrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY<-self.height) {
        CGRect frame = self.headerView.frame;
        frame.size.height = fabs(contentOffsetY);
        frame.origin.y = contentOffsetY;
        self.headerView.frame = frame;
    }
}

#pragma mark - UIViewControllerPreviewingDelegate代理方法
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    
    TestControllerViewController *tvc = [[TestControllerViewController alloc] init];
    tvc.view.backgroundColor = [UIColor redColor];
    
    tvc.preferredContentSize = CGSizeMake(0.0f,500.0f);
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,40);
    previewingContext.sourceRect = rect;
    
    //返回预览界面
    return tvc;
    
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
