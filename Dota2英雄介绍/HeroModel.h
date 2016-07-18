//
//  heroModel.h
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/3/23.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeroModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *atk_l;
@property (nonatomic,copy) NSString *bio;
@property (nonatomic,copy) NSArray *roles_l;
@property (nonatomic,copy) NSString *engName;
@property (nonatomic,strong) UIImage *profileImage;



@end
