//
//  ArtNetWorkService+downBook.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtNetWorkService.h"

@interface ArtNetWorkService (downBook)

- (void)downloadBookInfo:(ArtBookInfo *)aBook onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(ArtBookInfo* aBook, NSError* aError))aComplete;

- (void)cancelBookUrlString:(NSString *)urlString;
- (void)cancelBookBlock;

- (void)insertBook:(ArtBookInfo *)aBook;
- (NSArray<ArtBookInfo *> *)getUnFinishBook;
- (NSInteger)getUnFinishBookCount;
- (NSArray<ArtBookInfo *> *)getFinishBook;
- (NSInteger)getFinishBookCount;

- (ArtBookInfo *)getBookByUrlString:(NSString *)urlString;
- (void)deleteBookByUrlString:(NSString *)urlString;

@end
