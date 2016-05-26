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
            [weakSelf reload];
            return;
        }
        [self showText:[aError localizedDescription]];
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

@end
