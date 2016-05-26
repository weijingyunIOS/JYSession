//
//  ArtBookTable.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/23.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtBookTable.h"

@implementation ArtBookTable

- (void)configTableName{
    
    self.contentClass = [ArtBookInfo class];
    self.tableName = @"ArtBookTable";
}

- (NSString *)contentId{
    return @"bookID";
}

- (NSArray<NSString *> *)getContentField{
    return [JYDownloadInfo appedExtenArray:@[@"bookName"]];
}

@end
