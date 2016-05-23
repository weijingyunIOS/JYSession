//
//  JYDownloadTable.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYContentTable.h"
#import "JYDownloadInfo.h"

@interface JYDownloadTable : JYContentTable

- (NSArray<JYDownloadInfo *> *)getDownloadUnFinish;
- (NSInteger)getDownloadUnFinishCount;
- (NSArray<JYDownloadInfo *> *)getDownloadFinish;
- (NSInteger)getDownloadFinishCount;

- (JYDownloadInfo *)getInfoByUrlString:(NSString *)urlString;
- (void)deleteInfoByUrlString:(NSString *)urlString;

@end
