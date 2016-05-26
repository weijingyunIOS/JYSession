//
//  JYDownloadInfo.h
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
    EDownloadStateFinish,  // 完成
    EDownloadStateDelete   // 删除 删除不要保存
};

@interface JYDownloadInfo : NSObject

@property (nonatomic, copy) NSString *eTag;                 // 文件标识
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) EDownloadState downLoadState;
@property (nonatomic, copy) NSString *relativePath;         // 下载完成后(或未完成)的相对地址
@property (nonatomic, assign) long long serverFileSize;     // 服务器上文件总大小

// 以下下属性不保存数据库
@property (nonatomic, copy, readonly) NSString *finishPath; // 下载完成后(或未完成)的实际地址
@property (nonatomic, assign, readonly) long long currentFileSize; // 查询文件路径大小（真实）
@property (nonatomic, assign) long long downLoadSize; // 记录大小只有下载才有


// 必须重写该方法 用于保存信息
- (void)saveToDB;

// 根据 aInfo 更新 self 基本数据为 0 也不更新 最好用NSNumber
- (void)updateInfo:(JYDownloadInfo *)aInfo;

// 会将 self 与数据库 对比 将 self 的非空字段更新到数据库
- (instancetype)updeToDB;

- (instancetype)getDBInfo;
+ (NSArray<NSString *> *)appedExtenArray:(NSArray <NSString*>*)aExtens;


@end
