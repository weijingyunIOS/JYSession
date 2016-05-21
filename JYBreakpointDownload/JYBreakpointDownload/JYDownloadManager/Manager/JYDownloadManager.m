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
@interface JYDownloadManager()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *downloadDicM;
@property (nonatomic, strong) NSMutableArray *waitingArray;

@end

@implementation JYDownloadManager

- (instancetype)init{
    if (self = [super init]) {
        self.maxDownLoad = 1;
        self.downloadPath = @"downloadPath";
    }
    return self;
}

- (void)downloadContent:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(JYDownloadContent* aContent, NSError* aError))aComplete{
    if (aContent.urlString.length <= 0) {
        NSLog(@"下载链接不能为空－－－－－");
        return;
    }
    
    if (self.downloadDicM.count >= self.maxDownLoad) {
        if (aComplete) {
            NSString *errorString = [NSString stringWithFormat:@"已达最大下载数%tu",self.maxDownLoad];
            NSError *aError = [NSError errorWithDomain:@"超过最大下载数" code:1 userInfo:@{@"NSLocalizedDescription" : errorString}];
            aComplete(aContent,aError);
        }
        return;
    }
    
    NSString *key = [aContent.urlString MD5String];
    JYDownload *download = self.downloadDicM[key];
    if (download == nil) {
        download = [[JYDownload alloc] init];
        download.aContent = aContent;
        download.session = self.session;
        download.downloadPath = self.downloadPath;
        [self setDownload:download forUrlString:aContent.urlString];
        [download startDownload];
    }
    aContent.downLoadState = EDownloadStateGoing;
    __weak typeof(JYDownloadManager*)weakSelf = self;
    download.successBlock = ^(JYDownload *aCmd){
        aContent.downLoadState = EDownloadStateFinish;
        if (aComplete) {
            aComplete(aCmd.aContent,nil);
        }
        [weakSelf.downloadDicM removeObjectForKey:key];
    };
    
    download.failBlock = ^(JYDownload*aCmd, NSError*aError){
        if (aError.code != -999) {
            aContent.downLoadState = EDownloadStateFaile;
        }else {
            aContent.downLoadState = EDownloadStatePause;
            aError = [NSError errorWithDomain:@"暂停下载" code:0 userInfo:@{@"NSLocalizedDescription" : @"暂停下载"}];
        }
        
        if (aComplete) {
            aComplete(nil,aError);
        }
        [self.downloadDicM removeObjectForKey:key];
    };
    
    download.downloadProgress = ^(int64_t completeBytes, int64_t totalBytes){
        if (aProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                aProgress(completeBytes,totalBytes);
            });
        }
    };
}

- (void)cancelUrlString:(NSString *)urlString{
    NSString *key = [urlString MD5String];
     JYDownload *download = self.downloadDicM[key];
    [download cancel];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    NSLog(@"%s", __func__);
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

@end
