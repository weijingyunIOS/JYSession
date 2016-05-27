//
//  JYDownloadManager.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadManager.h"
#import "JYDownload.h"
#import "NSString+JYCategory.h"
#import "JYNetWorkConfig.h"
@interface JYDownloadManager()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *downloadDicM;

@end

@implementation JYDownloadManager

- (instancetype)init{
    if (self = [super init]) {
        self.maxDownLoad = 3;
        self.downloadPath = @"downloadPath";
    }
    return self;
}

- (void)downloadContent:(JYDownloadInfo *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadInfo* aContent, NSError* aError))aComplete{
    if (aContent.urlString.length <= 0) {
        NSLog(@"下载链接不能为空－－－－－");
        return;
    }
    
    aContent = [aContent updeToDB];
    NSString *key = [aContent.urlString MD5String];
    JYDownload *download = self.downloadDicM[key];
     aContent.downLoadState = EDownloadStateGoing;
    BOOL newDownload = download == nil;
    if (newDownload) {
        
        if (self.downloadDicM.count >= self.maxDownLoad) {
            if (aComplete) {
                aContent.downLoadState = EDownloadStateWaiting;
                NSString *errorString = [[JYNetWorkConfig shared] maxDownloadErrorForType:self.type];
                NSError *aError = [NSError errorWithDomain:@"超过最大下载数" code:1 userInfo:@{@"NSLocalizedDescription" : errorString}];
                [aContent saveToDB];
                aComplete(aContent,aError);
            }
            return;
        }
        
        download = [[JYDownload alloc] init];
        aContent.downLoadState = EDownloadStateGoing;
    }
   
    __weak typeof(JYDownloadManager*)weakSelf = self;
    download.successBlock = ^(JYDownload *aCmd){
        aContent.downLoadState = EDownloadStateFinish;
        [aContent saveToDB];
        if (aComplete) {
            aComplete(aCmd.aContent,nil);
        }
        [weakSelf.downloadDicM removeObjectForKey:key];
        [weakSelf finish];
    };
    
    download.failBlock = ^(JYDownload*aCmd, NSError*aError){
        if (aError.code != -999) {
            aContent.downLoadState = EDownloadStateFaile;
            [aContent saveToDB];
        }else if (aContent.downLoadState == EDownloadStatePause){
            aError = [NSError errorWithDomain:@"暂停下载" code:0 userInfo:@{@"NSLocalizedDescription" : @"暂停下载"}];
            [aContent saveToDB];
        }else if (aContent.downLoadState == EDownloadStateDelete){
            aError = [NSError errorWithDomain:@"删除下载" code:1 userInfo:@{@"NSLocalizedDescription" : @"已删除"}];
        }
        
        if (aComplete) {
            aComplete(aContent,aError);
        }
        [weakSelf.downloadDicM removeObjectForKey:key];
        [weakSelf finish];
    };
    
    download.downloadProgress = ^(int64_t completeBytes, int64_t totalBytes){
        if (aProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                aContent.downLoadSize = completeBytes;
                aProgress(completeBytes,totalBytes);
            });
        }
    };
    
    download.aContent = aContent;
    if (newDownload) {
        download.session = self.session;
        download.downloadPath = self.downloadPath;
        [self setDownload:download forUrlString:aContent.urlString];
        [download startDownload];
    }
}

- (void)deleteUrlString:(NSString *)urlString{
    [self cancelState:EDownloadStateDelete url:urlString];
}

- (void)cancelUrlString:(NSString *)urlString{
    [self cancelState:EDownloadStatePause url:urlString];
}

- (void)cancelState:(EDownloadState)state url:(NSString *)urlString{
    NSString *key = [urlString MD5String];
    JYDownload *download = self.downloadDicM[key];
    download.aContent.downLoadState = state;
    [download cancel];
}

// 取消block进度回调，线程切换 卡性能
- (void)cancelBlock{
    [self.downloadDicM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        JYDownload *download = self.downloadDicM[key];
        [self downloadContent:download.aContent onProgress:nil Complete:nil];
    }];
}

- (void)finish{
    if (self.downloadDicM.count > 0) {
        return;
    }
    [[JYNetWorkConfig shared] removeDownloadManagerForType:self.type];
    [self.session invalidateAndCancel];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
//    NSLog(@"%s", __func__);
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    JYDownload *download = self.downloadDicM[task.taskDescription];
    [download URLSession:session task:task didCompleteWithError:error];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    JYDownload *download = self.downloadDicM[dataTask.taskDescription];
    [download URLSession:session dataTask:dataTask didReceiveData:data];
}

- (void)setDownload:(JYDownload *)download forUrlString:(NSString *)urlString{
    self.downloadDicM[[urlString MD5String]] = download;
}


#pragma mark - 懒加载
- (NSURLSession *)session{
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    }
    return _session;
}

- (NSMutableDictionary *)downloadDicM{
    if (!_downloadDicM) {
        _downloadDicM = [[NSMutableDictionary alloc] init];
    }
    return _downloadDicM;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
