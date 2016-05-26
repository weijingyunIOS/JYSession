//
//  JYDownloadManager.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYDownloadInfo.h"
#import "JYNetWorkConfig.h"
@interface JYDownloadManager : NSObject

@property (nonatomic, copy) NSString *downloadPath; // 存储的文件夹
@property (nonatomic, assign) NSInteger maxDownLoad; // 同时存在的最大下载数
@property (nonatomic, assign) EDownloadType type;

- (void)downloadContent:(JYDownloadInfo *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadInfo* aContent, NSError* aError))aComplete;

- (void)deleteUrlString:(NSString *)urlString;
- (void)cancelUrlString:(NSString *)urlString;

// 取消block进度回调，线程切换 卡性能
- (void)cancelBlock;

@end
