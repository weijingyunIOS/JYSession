//
//  ArtNetWorkService.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArtNetWorkDB.h"
#import "JYDownloadManager.h"
#import "JYNetWorkConfig.h"

@interface ArtNetWorkService : NSObject

@property (nonatomic, strong, readonly) ArtNetWorkDB *netWorkDB;

+ (instancetype)shared;
- (void)removeDownloadManagerForType:(EDownloadType)aType;
- (void)downloadType:(EDownloadType)type content:(JYDownloadInfo *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(id aContent, NSError* aError))aComplete;

- (void)canceltype:(EDownloadType)type UrlString:(NSString *)urlString;
- (void)cancelBlockType:(EDownloadType)type;

@end
