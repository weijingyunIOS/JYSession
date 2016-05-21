//
//  JYNetWorkService.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYNetWorkService.h"

@interface JYNetWorkService ()

@property (nonatomic, strong) JYNetWorkDB *netWorkDB;
@property (nonatomic, strong) NSMutableDictionary *downloadDicM;

@end

@implementation JYNetWorkService

- (instancetype)init{
    if (self = [super init]) {
        self.netWorkDB = [JYNetWorkDB storage];
    }
    return self;
}

+ (instancetype)shared{
    static JYNetWorkService *globalService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalService = [[JYNetWorkService alloc] init];
    });
    return globalService;
}

- (void)downloadType:(EDownloadType)type content:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete{
    JYDownloadManager *downloadManager = [self getDownloadManagerForType:type];
    [aContent setValue:@(type) forKey:@"downLoadType"];
    [downloadManager downloadContent:aContent onProgress:aProgress Complete:aComplete];
}

- (void)downloadContent:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete{
     [self downloadType:EDownloadTypeNone content:aContent onProgress:aProgress Complete:aComplete];
}

- (void)cancelUrlString:(NSString *)urlString{
    [self.downloadDicM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        JYDownloadManager *downloadManager = self.downloadDicM[key];
        [downloadManager cancelUrlString:urlString];
    }];
}

- (void)cancelBlockType:(EDownloadType)type{
    JYDownloadManager *downloadManager = [self getDownloadManagerForType:type];
    [downloadManager cancelBlock];
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

#pragma mark - downloadManager数据库操作
- (void)insertDownloadContent:(JYDownloadContent *)aContent{
    [self.netWorkDB.downloadTable insertContent:aContent];
}

- (void)deleteDownloadContent:(JYDownloadContent *)aContent{
    [self.netWorkDB.downloadTable deleteDownloadContent:aContent];
}

- (NSArray<JYDownloadContent *> *)getDownloadUnFinishType:(EDownloadType)type{
    return [self.netWorkDB.downloadTable getDownloadUnFinishType:type];
}

- (NSArray<JYDownloadContent *> *)getDownloadFinishType:(EDownloadType)type{
    return [self.netWorkDB.downloadTable getDownloadFinishType:type];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)downloadDicM{
    if (!_downloadDicM) {
        _downloadDicM = [[NSMutableDictionary alloc] init];
    }
    return _downloadDicM;
}


@end
