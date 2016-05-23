//
//  JYDownloadTable.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadTable.h"
#import "ArtNetWorkService.h"
#import "JYFileManager.h"

@implementation JYDownloadTable


- (NSArray<JYDownloadInfo *> *)getDownloadUnFinish{
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSInteger)getDownloadUnFinishCount{
    return [self getCountByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSArray<JYDownloadInfo *> *)getDownloadFinish{
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSInteger)getDownloadFinishCount{
    return [self getCountByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (JYDownloadInfo *)getInfoByUrlString:(NSString *)urlString{
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"urlString").equalTo(urlString);
    }].lastObject;
}

- (void)deleteInfoByUrlString:(NSString *)urlString{
   [self deleteContentByConditions:^(JYQueryConditions *make) {
       make.field(@"urlString").equalTo(urlString);
   }];
}

@end
