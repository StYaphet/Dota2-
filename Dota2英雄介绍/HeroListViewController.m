//
//  HeroListViewController.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/23.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HeroListViewController.h"
#import "HeroModel.h"
#import "HeroTableViewCell.h"
#import "TestControllerViewController.h"
#import "HreoList.h"
#import "HYPSegViewController.h"

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
//    [self setHeroNameSet];
    //  从json中获取英雄的详细信息
    [self getHeroDetail];
    
    [self getHeroPictures];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[HeroTableViewCell class] forCellReuseIdentifier:@"HeroCell"];
    
    
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
 *    从json中获取英雄的详细信息
 */
- (void)getHeroDetail{
        NSBundle *bundle = [NSBundle mainBundle];
        if (bundle) {
            NSString *fileURLString = [bundle pathForResource:@"heroData" ofType:@"json"];
            if (fileURLString) {
                NSData *data = [NSData dataWithContentsOfFile:fileURLString];
    
                NSDictionary *heroDictory = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                [heroDictory enumerateKeysAndObjectsUsingBlock:^(NSString *name,NSDictionary *object,BOOL *stop){

                    HeroModel *hero = [[HeroModel alloc] init];
                    hero.name = object[@"name"];
                    hero.bio = object[@"bio"];
                    hero.atk_l = object[@"atk_l"];
                    hero.roles_l = object[@"roles_l"];
                    hero.engName = name;
                    
                    HreoList *heroList = [HreoList sharedHeroList];
                    [heroList addHero:hero];
                }];
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
    NSLog(@"力量英雄数：%lu",(unsigned long)[HreoList sharedHeroList].liliangHeroArray.count);
    switch (self.tag) {
        case (NSInteger)0:
            return [[HreoList sharedHeroList].liliangHeroArray count];
            break;
        case (NSInteger)1:
            return [[HreoList sharedHeroList].minjieHeroArray count];
            break;
            
        case (NSInteger)2:
            return [[HreoList sharedHeroList].zhiliHeroArray count];
            break;
    }
    return 0;
}

//  设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HeroTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeroCell"];
    }
    //  根据自身的tag值确定取那个英雄数组的数据
    HeroModel *hero = nil;
    if (!hero) {
        switch (self.tag) {
            case (NSInteger)0:{
                hero = [HreoList sharedHeroList].liliangHeroArray[indexPath.row];
            }
                break;
            case (NSInteger)1:{
                hero = [HreoList sharedHeroList].minjieHeroArray[indexPath.row];
            }
                break;
                
            case (NSInteger)2:{
                hero = [HreoList sharedHeroList].zhiliHeroArray[indexPath.row];
            }
                break;
        }
    }
    
    [cell updateWithObject:hero];
    
    cell.heroNameLable.text = hero.name;
    
    //  查看设备是否支持3D touch
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
        NSLog(@"3D Touch有效");
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }{
        NSLog(@"3D Touch无效");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *one = [[UIViewController alloc] init];
    one.view.backgroundColor = [UIColor redColor];
    one.title = @"one";
    
    UIViewController *two = [[UIViewController alloc] init];
    two.view.backgroundColor = [UIColor greenColor];
    two.title = @"two";
    
    UIViewController *three = [[UIViewController alloc] init];
    three.view.backgroundColor = [UIColor blueColor];
    three.title = @"three";
    
    UIViewController *four = [[UIViewController alloc] init];
    four.view.backgroundColor = [UIColor orangeColor];
    four.title = @"four";
    
    HYPSegViewController *controller = [[HYPSegViewController alloc] initWithControllers:@[one,two,three,four]];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
