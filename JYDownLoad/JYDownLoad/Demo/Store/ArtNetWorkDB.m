//
//  ArtNetWorkDB.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtNetWorkDB.h"
#import "JYNetWorkConfig.h"
#import "JYFileManager.h"

@interface ArtNetWorkDB ()

@property (nonatomic, strong) ArtBookTable * bookTable;
@property (nonatomic, strong) ArtVideoTable * videoTable;

@end

@implementation ArtNetWorkDB

- (instancetype)init{
    if (self = [super init]) {
        [self construct];
    }
    return self;
}

+ (instancetype)storage{
    ArtNetWorkDB *netWorkStorage = [[ArtNetWorkDB alloc] init];
    return netWorkStorage;
}

- (void)construct{
    NSString *path = [JYFileManager getDocumentPathWith:[JYNetWorkConfig shared].netWorkDirectory fileName:@"JYNetWorkDB.DB"];
    NSLog(@"%@",path);
    [self buildWithPath:path mode:ArtDatabaseModeWrite];
}

#pragma mark - 创建更新表
- (NSInteger)getCurrentDBVersion
{
    return 3;
}

- (void)createAllTable:(FMDatabase *)aDB{
    [self.bookTable createTable:aDB];
    [self.videoTable createTable:aDB];
}

- (void)updateDB:(FMDatabase *)aDB{
    [self.bookTable updateDB:aDB];
    [self.videoTable updateDB:aDB];
}

#pragma make - 懒加载
- (ArtBookTable *)bookTable{
    if (!_bookTable) {
        _bookTable = [[ArtBookTable alloc] init];
        _bookTable.dbQueue = self.dbQueue;
    }
    return _bookTable;
}

- (ArtVideoTable *)videoTable{
    if (!_videoTable) {
        _videoTable = [[ArtVideoTable alloc] init];
        _videoTable.dbQueue = self.dbQueue;
    }
    return _videoTable;
}

@end
