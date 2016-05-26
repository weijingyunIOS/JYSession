//
//  ArtVideoInfo.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtVideoInfo.h"
#import "ArtNetWorkService+downVideo.h"

@implementation ArtVideoInfo

- (void)saveToDB{
    [[ArtNetWorkService shared] insertVideo:self];
}

- (instancetype)getDBInfo{
    return [[ArtNetWorkService shared] getVideoByUrlString:self.urlString];
}

@end
