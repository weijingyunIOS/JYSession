//
//  JYDownloadContentTable.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadContentTable.h"
#import "FMDatabaseQueue.h"

@implementation JYDownloadContentTable

- (void)configTableName{
    
    self.contentClass = [JYDownloadContent class];
    self.tableName = @"JYDownloadContentTable";
}

- (NSString *)contentId{
    return @"contentID";
}

- (NSArray<NSString *> *)getContentField{
    return @[@"urlString",@"downLoadState",@"downLoadType",@"relativePath",@"serverFileSize",@"extenInfo",@"a1",@"a2",@"a3"];
}


- (id)checkVaule:(id)aVaule forKey:(NSString*)aKey{
//    if ([aKey isEqualToString:@"downLoadState"]) {
//        return @0;
//    }
    return [super checkVaule:aVaule forKey:aKey];
}

- (NSArray<JYDownloadContent *> *)getDownloadUnFinishType:(EDownloadType)type{
    
    __block id contents = nil;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        contents = [self getContentDB:db byconditions:^(JYQueryConditions *make) {
            make.field(@"downLoadType").equalTo([NSString stringWithFormat:@"%tu",type]);
            make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
        }];
    }];
    return contents;
}

- (NSArray<JYDownloadContent *> *)getDownloadFinishType:(EDownloadType)type{
    __block id contents = nil;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        contents = [self getContentDB:db byconditions:^(JYQueryConditions *make) {
            make.field(@"downLoadType").equalTo([NSString stringWithFormat:@"%tu",type]);
            make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
        }];
    }];
    return contents;
}

- (void)deleteDownloadContent:(JYDownloadContent *)aContent{
    
}


@end
