//
//  ArtBookInfo.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtBookInfo.h"
#import "ArtNetWorkService+downBook.h"

@implementation ArtBookInfo

- (void)saveToDB{
    [[ArtNetWorkService shared] insertBook:self];
}

- (instancetype)getDBInfo{
    return [[ArtNetWorkService shared] getBookByUrlString:self.urlString];
}

@end
