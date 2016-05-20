//
//  JYFileManager.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYFileManager.h"

@implementation JYFileManager

+ (NSString*)getCachePathWith:(NSString*)filePath{
    return [self getCachePathWith:filePath fileName:nil];
}

+ (NSString*)getCachePathWith:(NSString*)filePath fileName:(NSString*)fileName{
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [cachePath stringByAppendingPathComponent:filePath];
    // 如果路径不存在就创建
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (fileName != nil) {
        return path = [path stringByAppendingPathComponent:fileName];
    }
    return path;
}

// 获取本地文件的大小长度
+ (long long)getLengthForFilePath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (void)deleteLocalFilePath:(NSString*)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

// 写入文件
+ (void)saveData:(NSData*)aData toFilePath:(NSString *)filePath{
    NSFileHandle *fp = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (fp == nil) {
        [aData writeToFile:filePath atomically:YES];
        return;
    }
    
    [fp seekToEndOfFile];
    [fp writeData:aData];
    [fp closeFile];
}

@end