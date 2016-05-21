//
//  JYDownloadContent.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadContent.h"
#import "JYFileManager.h"

@interface JYDownloadContent()

@property (nonatomic, assign) EDownloadType  downLoadType;  // 下载类型

@end

@implementation JYDownloadContent

- (NSString *)finishPath{
    return [JYFileManager getCachePathWith:self.relativePath];
}

- (long long)currentFileSize{
    return [JYFileManager getLengthForFilePath:self.finishPath];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
