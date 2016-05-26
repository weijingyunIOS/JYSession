//
//  ArtNetWorkService+downVideo.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtNetWorkService.h"

@interface ArtNetWorkService (downVideo)

- (void)downloadVideoInfo:(ArtVideoInfo *)aVideo onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(ArtVideoInfo* aVideo, NSError* aError))aComplete;

- (void)cancelVideoUrlString:(NSString *)urlString;
- (void)cancelVideoBlock;

- (void)insertVideo:(ArtVideoInfo *)aVideo;
- (NSArray<ArtVideoInfo *> *)getUnFinishVideo;
- (NSInteger)getUnFinishVideoCount;
- (NSArray<ArtVideoInfo *> *)getFinishVideo;
- (NSInteger)getFinishVideoCount;

- (ArtVideoInfo *)getVideoByUrlString:(NSString *)urlString;
- (void)deleteVideoByUrlString:(NSString *)urlString;

@end
