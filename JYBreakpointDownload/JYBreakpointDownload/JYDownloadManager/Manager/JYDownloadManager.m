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

@property (nonatomic, copy) NSString *downloadPath; // 存储的文件夹
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *downloadDicM;

@end

@implementation JYDownloadManager

- (void)downloadContent:(JYDownloadContent *)aContent onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(NSString* aFilePath, NSError* aError))aComplete{
    if (aContent.urlString.length <= 0) {
        return;
    }
    NSString *key = [aContent.urlString MD5String];
    JYDownload *download = self.downloadDicM[key];
    if (download == nil) {
        download = [[JYDownload alloc] init];
        download.aContent = aContent;
        download.session = self.session;
        download.downloadPath = @"aaaaa";
        [self setDownload:download forUrlString:aContent.urlString];
        [download startDownload];
    }
    
    __weak typeof(JYDownloadManager*)weakSelf = self;
    download.successBlock = ^(JYDownload *aCmd){
//        [self upState:EDownLoadstateFinish downLoadUrl:aUrl];
        if (aComplete) {
            aComplete(aCmd.completeFilePath,nil);
        }
        [weakSelf.downloadDicM removeObjectForKey:key];
    };
    
    download.failBlock = ^(JYDownload*aCmd, NSError*aError){
//        if ([self getDownLoadstateFor:aUrl] == EDownLoadstateGoing) {
//            [self upState:EDownLoadstateFaile downLoadUrl:aUrl];
//        }else {
//            
//            aError = [NSError errorWithDomain:@"暂停下载" code:0 userInfo:@{@"NSLocalizedDescription" : @"暂停下载"}];
//        }
        
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
    [self.downloadDicM removeObjectForKey:key];
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
