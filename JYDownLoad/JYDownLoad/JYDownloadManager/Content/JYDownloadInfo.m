//
//  JYDownloadInfo.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/19.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYDownloadInfo.h"
#import "JYFileManager.h"
#import <objc/runtime.h>

@interface JYDownloadInfo()


@end

@implementation JYDownloadInfo

- (NSString *)finishPath{
    return [JYFileManager getCachePathWith:self.relativePath];
}

- (long long)currentFileSize{
    return [JYFileManager getLengthForFilePath:self.finishPath];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)saveToDB{
    NSLog(@"%s",__func__);
}

- (instancetype)getDBInfo{
    NSLog(@"%s",__func__);
    return nil;
}

- (instancetype)updeToDB{
    JYDownloadInfo *aInfo = [self getDBInfo];
    [aInfo updateInfo:self];
    [aInfo saveToDB];
    return self;
}

- (void)updateInfo:(JYDownloadInfo *)aInfo
{
    if (aInfo == nil) {
        return;
    }
    unsigned int outCount;
    Class infoClass = [self class];
    while (class_getSuperclass(infoClass) != nil) {
        
        objc_property_t *properties = class_copyPropertyList(infoClass, &outCount);
        for (NSInteger index = 0; index < outCount; index++) {
            NSString *tmpName = [NSString stringWithFormat:@"%s",property_getName(properties[index])];
            if ([tmpName isEqualToString:@"finishPath"] || [tmpName isEqualToString:@"currentFileSize"]) {
                continue;
            }
            NSObject *tmpValue = [aInfo valueForKey:tmpName];
            if (tmpValue && ![tmpValue isEqual:@(0)]) {
                [self setValue:tmpValue forKey:tmpName];
            }
        }
        if (properties) {
            free(properties);
        }
        
        infoClass = class_getSuperclass(infoClass);
    };

}


+ (NSArray<NSString *> *)appedExtenArray:(NSArray <NSString*>*)aExtens{
    NSMutableArray *arryM = [[NSMutableArray alloc] initWithArray:@[@"eTag",@"urlString",@"downLoadState",@"relativePath",@"serverFileSize"]];
    if (aExtens.count > 0) {
        [arryM addObjectsFromArray:aExtens];
    }
    return [arryM copy];
}

@end
