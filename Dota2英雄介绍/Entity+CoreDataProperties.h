//
//  Entity+CoreDataProperties.h
//  Dota2英雄介绍
//
//  Created by 郝一鹏 on 16/4/7.
//  Copyright © 2016年 bupt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *introduction;

@end

NS_ASSUME_NONNULL_END
