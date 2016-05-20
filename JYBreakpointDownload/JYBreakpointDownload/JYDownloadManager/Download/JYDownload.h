//
//  JYDownload.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYDownloadContent.h"

@interface JYDownload : NSObject

@property (nonatomic, copy) NSString *downloadPath; // 存储的文件夹
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) JYDownloadContent *aContent;

@property (nonatomic, copy) void (^successBlock)(JYDownload*);
@property (nonatomic, copy) void (^failBlock)(JYDownload*, NSError*);
@property (nonatomic, copy) void (^downloadProgress)(int64_t completeBytes, int64_t totalBytes);

- (void)startDownload;
- (void)cancel;

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;

@end
