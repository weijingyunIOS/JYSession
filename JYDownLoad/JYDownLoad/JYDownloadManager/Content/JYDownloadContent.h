//
//  JYDownloadContent.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYNetWorkConfig.h"

typedef NS_ENUM(NSUInteger, EDownloadState) {
    EDownloadStateWaiting, // 等待下载
    EDownloadStateGoing,   // 下载中
    EDownloadStatePause,   // 暂停
    EDownloadStateFaile,   // 失败
    EDownloadStateFinish   // 完成
};

@interface JYDownloadContent : NSObject

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) EDownloadState downLoadState;
@property (nonatomic, copy) NSString *relativePath;         // 下载完成后(或未完成)的相对地址
@property (nonatomic, assign) long long serverFileSize;     // 服务器上文件总大小

// 以下下属性不保存数据库
@property (nonatomic, copy, readonly) NSString *finishPath; // 下载完成后(或未完成)的实际地址
@property (nonatomic, assign) long long currentFileSize;


// 必须重写该方法 用于保存信息
- (void)saveToDB;

@end
