//
//  MainViewController.m
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/23.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "heroModel.h"
#import "HeroListViewController.h"

@interface MainViewController ()



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Dota2英雄";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setButtonWithIndex:0 backgroundImage:@"liliang.jpg" title:@"力量"];
    [self setButtonWithIndex:1 backgroundImage:@"minjie.jpg" title:@"敏捷"];
    [self setButtonWithIndex:2 backgroundImage:@"zhili.jpg" title:@"智力"];
    
    NSString *urlString = @"http://db.dota2.com.cn/hero/lina/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
//    NSBundle *bundle = [NSBundle mainBundle];
//    if (bundle) {
//        NSString *fileURLString = [bundle pathForResource:@"heroData" ofType:@"json"];
//        if (fileURLString) {
//            NSData *data = [NSData dataWithContentsOfFile:fileURLString];
//            
//            NSDictionary *heroDictory = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSMutableArray *heroArray = [[NSMutableArray alloc] init];
//            [heroDictory enumerateKeysAndObjectsUsingBlock:^(NSString *name,NSDictionary *object,BOOL *stop){
//                heroModel *hero = [[heroModel alloc] init];
//                hero.name = object[@"name"];
//                hero.bio = object[@"bio"];
//                hero.atk_l = object[@"atk_l"];
//                hero.roles_l = object[@"roles_l"];
//                [heroArray addObject:hero];
//            }];
//            self.heroArray = heroArray;
//            NSLog(@"%@",((heroModel *)heroArray[0]).bio);
//    
//        }
//    }
    

}

- (void)setButtonWithIndex:(int)i backgroundImage:(NSString *)imageName title:(NSString *)title{
    CGRect buttonFrame = self.view.frame;
    buttonFrame.size.height -= 64;
    buttonFrame.size.height /= 3;
    buttonFrame.origin.y += 64;
    buttonFrame.origin.y += i*buttonFrame.size.height;
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.tag = i;
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    button.imageView.clipsToBounds = YES;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:33]];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)pushViewController:(UIButton *)button{
    HeroListViewController *hvc = [[HeroListViewController alloc] initWithStyle:UITableViewStylePlain andTag:button.tag];
    [self.navigationController pushViewController:hvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
