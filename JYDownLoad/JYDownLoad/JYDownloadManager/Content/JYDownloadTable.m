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
#import "JYNetWorkConfig.h"
#import "JYFileManager.h"

@implementation JYDownloadTable

- (BOOL)enableCache{
    return NO;
}

- (NSArray<JYDownloadInfo *> *)getUnFinishDownload{
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSInteger)getUnFinishDownloadCount{
    return [self getCountByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").notEqualTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSArray<JYDownloadInfo *> *)getFinishDownload{
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (NSInteger)getFinishDownloadCount{
    return [self getCountByConditions:^(JYQueryConditions *make) {
        make.field(@"downLoadState").equalTo([NSString stringWithFormat:@"%tu",EDownloadStateFinish]);
    }];
}

- (JYDownloadInfo *)getDownloadByUrlString:(NSString *)urlString{
    return [self getContentByConditions:^(JYQueryConditions *make) {
        make.field(@"urlString").equalTo(urlString);
    }].lastObject;
}

- (void)deleteDBByUrlString:(NSString *)urlString{
   [self deleteContentByConditions:^(JYQueryConditions *make) {
       make.field(@"urlString").equalTo(urlString);
   }];
}

- (void)deleteDownloadByUrlString:(NSString *)urlString forType:(EDownloadType)aType{
    JYDownloadInfo *aInfo = [self getDownloadByUrlString:urlString];
    [[ArtNetWorkService shared] canceltype:aType UrlString:urlString];
    [JYFileManager deleteLocalFilePath:aInfo.finishPath];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYFileManager deleteLocalFilePath:aInfo.finishPath];
    });
    [self deleteDBByUrlString:urlString];
}

@end
