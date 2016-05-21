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

- (void)downloadContent:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete;

- (void)cancelUrlString:(NSString *)urlString;

@end
