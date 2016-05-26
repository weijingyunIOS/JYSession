//
//  ArtNetWorkService+downVideo.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtNetWorkService+downVideo.h"

@implementation ArtNetWorkService (downVideo)

- (void)downloadVideoInfo:(ArtVideoInfo *)aVideo onProgress:(void(^)(int64_t completeBytes, int64_t totalBytes))aProgress Complete:(void(^)(ArtVideoInfo* aVideo, NSError* aError))aComplete{
    [self downloadType:EDownloadVideo content:aVideo onProgress:aProgress Complete:aComplete];
}

- (void)cancelVideoUrlString:(NSString *)urlString{
    [self canceltype:EDownloadVideo UrlString:urlString];
}

- (void)cancelVideoBlock{
    [self cancelBlockType:EDownloadVideo];
}

- (void)insertVideo:(ArtVideoInfo *)aVideo{
    [self.netWorkDB.videoTable insertContent:aVideo];
}

- (NSArray<ArtVideoInfo *> *)getUnFinishVideo{
    return [self.netWorkDB.videoTable getUnFinishDownload];
}

- (NSInteger)getUnFinishVideoCount{
    return [self.netWorkDB.videoTable getUnFinishDownloadCount];
}

- (NSArray<JYDownloadInfo *> *)getFinishVideo{
    return [self.netWorkDB.videoTable getFinishDownload];
}

- (NSInteger)getFinishVideoCount{
    return [self.netWorkDB.videoTable getFinishDownloadCount];
}

- (JYDownloadInfo *)getVideoByUrlString:(NSString *)urlString{
    return [self.netWorkDB.videoTable getDownloadByUrlString:urlString];
}

- (void)deleteVideoByUrlString:(NSString *)urlString{
    [self.netWorkDB.videoTable deleteDownloadByUrlString:urlString forType:EDownloadVideo];
}

@end
