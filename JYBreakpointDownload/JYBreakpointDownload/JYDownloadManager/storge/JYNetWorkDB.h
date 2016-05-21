//
//  JYNetWorkDB.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <JYDataBase/JYDataBase.h>
#import "JYDownloadContentTable.h"

@interface JYNetWorkDB : JYDataBase

@property (nonatomic, strong, readonly) JYDownloadContentTable * downloadTable;

// 相对路径 数据库存在document 下
+ (instancetype)storage;

@end
