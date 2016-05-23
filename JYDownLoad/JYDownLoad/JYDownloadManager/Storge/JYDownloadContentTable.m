//
//  JYDownloadContentTable.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadContentTable.h"
#import "FMDatabaseQueue.h"
#import "JYNetWorkService.h"
#import "JYFileManager.h"

@implementation JYDownloadContentTable

- (void)configTableName{
    
    self.contentClass = [JYDownloadContent class];
    self.tableName = @"JYDownloadContentTable";
}

- (NSString *)contentId{
    return @"contentID";
}

- (NSArray<NSString *> *)getContentField{
    return @[@"urlString",@"downLoadState",@"downLoadType",@"relativePath",@"serverFileSize",@"extenInfo"];
}


- (id)checkVaule:(id)aVaule forKey:(NSString*)aKey{
//    if ([aKey isEqualToString:@"downLoadState"]) {
//        return @0;
//    }
    return [super checkVaule:aVaule forKey:aKey];
}

- (NSArray<JYDownloadContent *> *)getDownloadUnFinishType:(EDownloadType)type{
    
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadType").equalTo([NSString stringWithFormat:@"%tu",type]);
        make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSInteger)getDownloadUnFinishCountType:(EDownloadType)type{
    return [self getCountByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadType").equalTo([NSString stringWithFormat:@"%tu",type]);
        make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSArray<JYDownloadContent *> *)getDownloadFinishType:(EDownloadType)type{
    
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadType").equalTo([NSString stringWithFormat:@"%tu",type]);
        make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSInteger)getDownloadFinishCountType:(EDownloadType)type{
    return [self getCountByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadType").equalTo([NSString stringWithFormat:@"%tu",type]);
        make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (void)deleteDownloadContent:(JYDownloadContent *)aContent{
    JYDownloadContent *content = [self getContentByID:aContent.contentID];
    JYDownloadContent *currContent = content.urlString.length > 0 ? content : aContent;    [[JYNetWorkService shared] canceltype:currContent.downLoadType UrlString:currContent.urlString];
    [JYFileManager deleteLocalFilePath:currContent.finishPath];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYFileManager deleteLocalFilePath:currContent.finishPath];
    });
    [self deleteContentByID:currContent.contentID];
}


@end
