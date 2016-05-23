//
//  ArtNetWorkService+downBook.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtNetWorkService+downBook.h"

@implementation ArtNetWorkService (downBook)

- (void)downloadBookInfo:(ArtBookInfo *)aBook onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(ArtBookInfo* aBook, NSError* aError))aComplete{
    [self downloadType:EDownloadBook content:aBook onProgress:aProgress Complete:aComplete];
}

- (void)cancelBookUrlString:(NSString *)urlString{
    [self canceltype:EDownloadBook UrlString:urlString];
}

- (void)cancelBookBlock{
    [self cancelBlockType:EDownloadBook];
}

@end
