//
//  JYDownloadInfo.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadInfo.h"
#import "JYFileManager.h"

@interface JYDownloadInfo()


@end

@implementation JYDownloadInfo
- (NSString *)finishPath{
    return [JYFileManager getCachePathWith:self.relativePath];
}

- (long long)currentFileSize{
    return [JYFileManager getLengthForFilePath:self.finishPath];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)saveToDB{
    NSLog(@"%s",__func__);
}

@end