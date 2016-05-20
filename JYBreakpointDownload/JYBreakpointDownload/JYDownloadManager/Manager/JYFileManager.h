//
//  JYFileManager.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYFileManager : NSObject

// 下载目录拼接 filePath
+ (NSString*)getCachePathWith:(NSString*)filePath;
+ (NSString*)getCachePathWith:(NSString*)filePath fileName:(NSString*)fileName;


// 获取
+ (long long)getLengthForFilePath:(NSString*)filePath;

// 删除文件
+ (void)deleteLocalFilePath:(NSString*)filePath;

// 写入文件
+ (void)saveData:(NSData*)aData toFilePath:(NSString *)filePath;

@end
