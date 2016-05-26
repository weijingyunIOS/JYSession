//
//  ArtBookDownViewController.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtBookDownViewController.h"
#import "ArtDownCell.h"
#import "ArtNetWorkService+downBook.h"

@implementation ArtBookDownViewController


- (void)reload{
    self.unfinsh = [[ArtNetWorkService shared] getUnFinishBook];
    self.finsh = [[ArtNetWorkService shared] getFinishBook];
    [self.tableView reloadData];
}

- (void)downloadForCell:(ArtDownCell *)aCell info:(ArtBookInfo *)aInfo{
    __weak typeof (self)weakSelf = self;
    [[ArtNetWorkService shared] downloadBookInfo:aInfo onProgress:^(int64_t completeBytes, int64_t totalBytes) {
        [aCell updateProgress:aInfo];
    } Complete:^(ArtBookInfo *aBook, NSError *aError) {
        [aCell updateState:aInfo];
        if (aError == nil) {
            [weakSelf reload];
        }
    }];
}

- (void)cacleForInfo:(ArtBookInfo *)aInfo{
    [[ArtNetWorkService shared] cancelBookUrlString:aInfo.urlString];
}

- (void)cacleBlock{
    [[ArtNetWorkService shared] cancelBookBlock];
}

- (void)deleteDownForInfo:(ArtBookInfo *)aInfo{
    [[ArtNetWorkService shared] deleteBookByUrlString:aInfo.urlString];
    [self reload];
}

@end
