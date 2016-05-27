//
//  JYNetWorkConfig.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYNetWorkConfig.h"
#import "ArtNetWorkService.h"

@implementation JYNetWorkConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self rebuildNetWorkDirectory];
    }
    return self;
}

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id shared;
    dispatch_once(&onceToken, ^{
        shared = [[[self class] alloc] init];
    });
    return shared;
}

- (void)rebuildNetWorkDirectory
{
    NSString *netWorkDirectoryName =  @"NetWork";
    self.netWorkDirectory = [netWorkDirectoryName stringByAppendingPathComponent:@"userId"];
}

- (NSString *)getDownloadType:(EDownloadType)aType{
    NSString *typeName = @"";
    switch (aType) {
        case EDownloadBook:
            typeName = @"EDownloadBook";
            break;
            
        case EDownloadVideo:
            typeName = @"EDownloadVideo";
            break;
            
        default:
            break;
    }
    return typeName;
}

- (NSInteger)getMaxDownloadForType:(EDownloadType)aType{
    return 3;
}

- (void)removeDownloadManagerForType:(EDownloadType)aType{
    [[ArtNetWorkService shared] removeDownloadManagerForType:aType];
}

- (NSString *)maxDownloadErrorForType:(EDownloadType)aType{
    return [NSString stringWithFormat:@"已达最大下载数%tu",[self getMaxDownloadForType:aType]];
}

@end
