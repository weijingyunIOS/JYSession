//
//  JYDownload.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownload.h"
#import "JYFileManager.h"
#import "NSString+JYCategory.h"

typedef NS_ENUM(NSUInteger, EDownloadType) {
    EDownloadNone,    //重新下载
    EDownloadEnd,     //已下载完成
    EDownloadRange,   //断点下载
};

@interface JYDownload()

@property (nonatomic, copy) NSString *downloadFilePath;
@property (nonatomic, assign) long long startLenght;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation JYDownload

- (void)startDownload{

    __weak typeof(self)weakSelf = self;
    [self getFileHead:^(NSDictionary *headerFields) {
        
        long long length = [headerFields[@"Content-Length"] longLongValue];
        NSString *contentType = headerFields[@"Content-Type"];
        NSLog(@"contentType--%@",contentType);
        NSInteger type = [self needDownload:length];
        switch (type) {
            case EDownloadNone:
                [weakSelf downloadWithStart:-1];
                break;
                
            case EDownloadRange:
                [self downloadWithStart:[self getLocalFileLength]];
                break;
                
            case EDownloadEnd:
                // 成功
                [self notifySuccess];
                break;
                
            default:
                break;
        }
    }];
}

- (void)cancel{
    [self.dataTask cancel];
}

// range下载
- (void)downloadWithStart:(long long)start{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.aContent.urlString]];
    if (start > 0) {
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", start];
        [request setValue:requestRange forHTTPHeaderField:@"Range"];
    }
    
    self.dataTask = [self.session dataTaskWithRequest:request];
    self.dataTask.taskDescription = [self.aContent.urlString MD5String];
    self.startLenght = start;
    [self.dataTask resume];
}

#pragma mark - 请求封装，获取文件头信息 从0下载 断点下载
// 获取请求头信息
- (void)getFileHead:(void (^)(NSDictionary *headerFields))aBlock{

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.aContent.urlString]];
    request.HTTPMethod = @"HEAD";
    
    __weak typeof(self)weakSelf = self;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            [weakSelf notifyFailWithError:error];
            return;
        }
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            aBlock(((NSHTTPURLResponse*)response).allHeaderFields);
        }
    }];

    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error == nil) {
        [self notifySuccess];
    }else{
        [self notifyFailWithError:error];
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"%@",[NSThread currentThread]);
    [self saveFileData:data];
    if (self.downloadProgress) {
        self.downloadProgress(dataTask.countOfBytesReceived + self.startLenght,dataTask.countOfBytesExpectedToReceive + self.startLenght);
    }
    NSLog(@"%tu    %tu",dataTask.countOfBytesReceived + self.startLenght,dataTask.countOfBytesExpectedToReceive + self.startLenght);
}


#pragma mark - 失败成功回调
- (void)notifySuccess{
    NSLog(@"download object success!");
    if (self.successBlock) {
        self.successBlock(self);
    }
}

- (void)notifyFailWithError:(NSError *)aError{
    NSLog(@"head object failed, error: %@" ,aError);
    if (self.failBlock) {
        self.failBlock(self,aError);
    }
}

// 写入文件
- (void)saveFileData:(NSData*)aData{
    [JYFileManager saveData:aData toFilePath:self.downloadFilePath];
}

#pragma mark - 下载状态判断
- (EDownloadType)needDownload:(long long)length{
    long long localLength = [self getLocalFileLength];
    
    if (localLength == 0) {
        return EDownloadNone;
    }
    
    if (localLength == length) {
        return EDownloadEnd;
    }
    
    //本地大于服务端 删除后重下
    if (localLength > length) {
        [self deleteLocalFile];
        return EDownloadNone;
    }
    
    // 本地小于服务端 就 断点下载
    return EDownloadRange;
}

#pragma mark - 文件处理
// 获取本地文件的大小长度
- (long long)getLocalFileLength{
    return [JYFileManager getLengthForFilePath:self.downloadFilePath];
}

// 删除文件
- (void)deleteLocalFile{
    return [JYFileManager deleteLocalFilePath:self.downloadFilePath];
}

#pragma mark - 懒加载
- (NSString *)downloadFilePath{
    if (!_downloadFilePath) {
        _downloadFilePath = [JYFileManager getCachePathWith:self.downloadPath fileName:[self.aContent.urlString MD5String]];
    }
    return _downloadFilePath;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
