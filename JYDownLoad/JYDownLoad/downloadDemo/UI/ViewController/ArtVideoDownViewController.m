//
//  ArtVideoDownViewController.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtVideoDownViewController.h"
#import "ArtDownCell.h"
#import "ArtNetWorkService+downVideo.h"

@implementation ArtVideoDownViewController

- (void)reload{
    self.unfinsh = [[ArtNetWorkService shared] getUnFinishVideo];
    self.finsh = [[ArtNetWorkService shared] getFinishVideo];
    [self.tableView reloadData];
}

- (void)downloadForCell:(ArtDownCell *)aCell info:(ArtVideoInfo *)aInfo{
    __weak typeof (self)weakSelf = self;
    [[ArtNetWorkService shared] downloadVideoInfo:aInfo onProgress:^(int64_t completeBytes, int64_t totalBytes) {
        [aCell updateProgress:aInfo];
    } Complete:^(ArtVideoInfo *aVideo, NSError *aError) {
        [aCell updateState:aInfo];
        if (aError == nil) {
            NSLog(@"%@",aVideo.finishPath);
            [weakSelf reload];
            return;
        }
        
        if (aVideo.downLoadState == EDownloadStateDelete || aVideo == nil) {
            return;
        }
        
        [weakSelf showText:[aError localizedDescription]];
    }];
}

- (void)cacleForInfo:(ArtVideoInfo *)aInfo{
    [[ArtNetWorkService shared] cancelVideoUrlString:aInfo.urlString];
}

- (void)cacleBlock{
    [[ArtNetWorkService shared] cancelVideoBlock];
}

- (void)deleteDownForInfo:(ArtVideoInfo *)aInfo{
    [[ArtNetWorkService shared] deleteVideoByUrlString:aInfo.urlString];
    [self reload];
}

- (void)addDownLoadUrl:(NSString *)urlString{
    if ([[ArtNetWorkService shared] getVideoByUrlString:urlString] != nil) {
        [self showText:@"已下载"];
        return;
    }
    
    ArtVideoInfo *aInfo = [[ArtVideoInfo alloc] init];
    aInfo.urlString = urlString;
    aInfo.downLoadState = EDownloadStateGoing;
    NSInteger count = random();
    while ([[ArtNetWorkService shared] getVideoByVideoID:[NSString stringWithFormat:@"%tu",count]]) {
        count = random();
    }
    aInfo.videoID = [NSString stringWithFormat:@"%tu",count];
    aInfo.videoDesc = [NSString stringWithFormat:@"第 %tu 视频",count];
    [aInfo saveToDB];
    [self reload];
}

@end
