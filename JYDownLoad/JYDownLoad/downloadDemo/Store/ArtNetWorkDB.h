//
//  ArtNetWorkDB.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <JYDataBase/JYDataBase.h>
#import "ArtBookTable.h"
#import "ArtVideoTable.h"

@interface ArtNetWorkDB : JYDataBase

@property (nonatomic, strong, readonly) ArtBookTable * bookTable;
@property (nonatomic, strong, readonly) ArtVideoTable * videoTable;

+ (instancetype)storage;

@end
