//
//  ArtNetWorkService.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtNetWorkService.h"

@interface ArtNetWorkService ()

@property (nonatomic, strong) ArtNetWorkDB *netWorkDB;
@property (nonatomic, strong) NSMutableDictionary *downloadDicM;

@end

@implementation ArtNetWorkService

- (instancetype)init{
    if (self = [super init]) {
        self.netWorkDB = [ArtNetWorkDB storage];
    }
    return self;
}

+ (instancetype)shared{
    static ArtNetWorkService *globalService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalService = [[self alloc] init];
    });
    return globalService;
}

- (void)downloadType:(EDownloadType)type content:(JYDownloadInfo *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadInfo* aContent, NSError* aError))aComplete{
    JYDownloadManager *downloadManager = [self getDownloadManagerForType:type];
    [downloadManager downloadContent:aContent onProgress:aProgress Complete:aComplete];
}

#pragma mark - downloadManager 创建
- (void)setDownloadManager:(JYDownloadManager *)downloadManager forType:(EDownloadType)type{
    NSString *typeName = [[JYNetWorkConfig shared] getDownloadType:type];
    self.downloadDicM[typeName] = downloadManager;
}

- (JYDownloadManager *)getDownloadManagerForType:(EDownloadType)type{
    NSString *typeName = [[JYNetWorkConfig shared] getDownloadType:type];
    JYDownloadManager *downloadManager = self.downloadDicM[typeName];
    if (downloadManager == nil) {
        downloadManager = [[JYDownloadManager alloc] init];
        downloadManager.downloadPath = [[JYNetWorkConfig shared].netWorkDirectory stringByAppendingPathComponent:typeName];
        downloadManager.type = type;
        downloadManager.maxDownLoad = [[JYNetWorkConfig shared] getMaxDownloadForType:type];
        [self setDownloadManager:downloadManager forType:type];
    }
    return downloadManager;
}

- (void)removeDownloadManagerForType:(EDownloadType)type{
    NSString *typeName = [[JYNetWorkConfig shared] getDownloadType:type];
    [self.downloadDicM removeObjectForKey:typeName];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)downloadDicM{
    if (!_downloadDicM) {
        _downloadDicM = [[NSMutableDictionary alloc] init];
    }
    return _downloadDicM;
}

@end
