//
//  JYNetWorkConfig.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EDownloadType) {
    EDownloadTypeNone
};

@interface JYNetWorkConfig : NSObject

@property (nonatomic, strong) NSString* netWorkDirectory;
+ (instancetype)shared;
- (NSString *)getDownloadType:(EDownloadType)aType;
- (NSInteger)getMaxDownloadForType:(EDownloadType)aType;

@end
