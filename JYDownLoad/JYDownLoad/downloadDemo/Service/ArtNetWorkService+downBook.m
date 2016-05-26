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
    [self canceltype:EDownloadBook urlString:urlString];
}

- (void)cancelBookBlock{
    [self cancelBlockType:EDownloadBook];
}

- (void)insertBook:(ArtBookInfo *)aBook{
    [self.netWorkDB.bookTable insertContent:aBook];
}

- (NSArray<ArtBookInfo *> *)getUnFinishBook{
    return [self.netWorkDB.bookTable getUnFinishDownload];
}

- (NSInteger)getUnFinishBookCount{
    return [self.netWorkDB.bookTable getUnFinishDownloadCount];
}

- (NSArray<JYDownloadInfo *> *)getFinishBook{
    return [self.netWorkDB.bookTable getFinishDownload];
}

- (NSInteger)getFinishBookCount{
    return [self.netWorkDB.bookTable getFinishDownloadCount];
}

- (JYDownloadInfo *)getBookByUrlString:(NSString *)urlString{
    return [self.netWorkDB.bookTable getDownloadByUrlString:urlString];
}

- (void)deleteBookByUrlString:(NSString *)urlString{
    [self.netWorkDB.bookTable deleteDownloadByUrlString:urlString forType:EDownloadBook];
}

- (ArtBookInfo *)getBookByBookID:(NSString *)bookID{
    return [self.netWorkDB.bookTable getContentByID:bookID];
}

@end
