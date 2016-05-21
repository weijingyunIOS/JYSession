//
//  JYDownloadContent.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, copy) NSString *relativePath;         // 下载完成后的相对地址

// 一下属性不保存数据库
@property (nonatomic, copy, readonly) NSString *finishPath; // 下载完成后的实际地址

@end
