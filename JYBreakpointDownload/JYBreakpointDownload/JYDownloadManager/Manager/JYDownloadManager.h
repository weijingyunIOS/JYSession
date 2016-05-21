//
//  JYDownloadManager.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYDownloadContent.h"
@interface JYDownloadManager : NSObject

@property (nonatomic, copy) NSString *downloadPath; // 存储的文件夹
@property (nonatomic, assign) NSInteger maxDownLoad; // 同时存在的最大下载数

- (void)downloadContent:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete;

- (void)cancelUrlString:(NSString *)urlString;

// 取消block进度回调，线程切换 卡性能
- (void)cancelBlock;

@end
