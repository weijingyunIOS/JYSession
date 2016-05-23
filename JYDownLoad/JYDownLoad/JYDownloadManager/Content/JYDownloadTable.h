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

- (NSArray*)getUnFinishDownload;
- (NSInteger)getUnFinishDownloadCount;
- (NSArray*)getFinishDownload;
- (NSInteger)getFinishDownloadCount;

- (JYDownloadInfo *)getDownloadByUrlString:(NSString *)urlString;
- (void)deleteDBByUrlString:(NSString *)urlString;
- (void)deleteDownloadByUrlString:(NSString *)urlString forType:(EDownloadType)aType;

@end
