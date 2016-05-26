//
//  ArtVideoTable.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtVideoTable.h"

@implementation ArtVideoTable

- (void)configTableName{
    
    self.contentClass = [ArtVideoInfo class];
    self.tableName = @"ArtVideoTable";
}

- (NSString *)contentId{
    return @"videoID";
}

- (NSArray<NSString *> *)getContentField{
    return [JYDownloadInfo appedExtenArray:@[@"videoDesc"]];
}

@end
