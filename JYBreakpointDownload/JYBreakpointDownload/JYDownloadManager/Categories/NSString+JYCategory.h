//
//  NSString+JYCategory.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/20.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JYCategory)

- (NSString *)MD5String;

// 仅保留 string 前的字符
- (NSString *)deleteString:(NSString*)string;

// 仅保留 string 后的字符
- (NSString *)deleteBeforeString:(NSString*)string;


@end
