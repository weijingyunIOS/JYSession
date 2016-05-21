//
//  JYNetWorkDB.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYNetWorkDB.h"
#import "JYNetWorkConfig.h"
#import "JYFileManager.h"
@interface JYNetWorkDB ()

@property (nonatomic, strong) JYDownloadContentTable * downloadTable;

@end

@implementation JYNetWorkDB

+ (instancetype)storage{
    JYNetWorkDB *netWorkStorage = [[JYNetWorkDB alloc] init];
    [netWorkStorage construct];
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
    return 1;
}

- (void)createAllTable:(FMDatabase *)aDB{
    [self.downloadTable createTable:aDB];
}

- (void)updateDB:(FMDatabase *)aDB{
    [self.downloadTable updateDB:aDB];
}

#pragma make - 懒加载
- (JYDownloadContentTable *)downloadTable{
    if (!_downloadTable) {
        _downloadTable = [[JYDownloadContentTable alloc] init];
        _downloadTable.dbQueue = self.dbQueue;
    }
    return _downloadTable;
}


@end
