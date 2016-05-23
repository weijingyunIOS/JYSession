//
//  JYNetWorkService.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYNetWorkDB.h"
#import "JYDownloadManager.h"
#import "JYNetWorkConfig.h"

@interface JYNetWorkService : NSObject

+ (instancetype)shared;
- (void)removeDownloadManagerForType:(EDownloadType)type;

// 默认 EDownloadTypeNone
- (void)downloadContent:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete;

- (void)downloadType:(EDownloadType)type content:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete;

// 一个urlString 不该做为多种 EDownloadType。
- (void)cancelUrlString:(NSString *)urlString;
- (void)canceltype:(EDownloadType)type UrlString:(NSString *)urlString;
- (void)cancelBlockType:(EDownloadType)type;

#pragma mark - downloadManager数据库操作
- (void)insertDownloadContent:(JYDownloadContent *)aContent;
- (void)deleteDownloadContent:(JYDownloadContent *)aContent;
- (NSArray<JYDownloadContent *> *)getDownloadUnFinishType:(EDownloadType)type;
- (NSArray<JYDownloadContent *> *)getDownloadFinishType:(EDownloadType)type;
- (NSInteger)getDownloadFinishCountType:(EDownloadType)type;
- (NSInteger)getDownloadUnFinishCountType:(EDownloadType)type;

@end
