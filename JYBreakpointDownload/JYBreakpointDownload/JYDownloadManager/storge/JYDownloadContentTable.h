//
//  JYDownloadContentTable.h
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "JYContentTable.h"
#import "JYDownloadContent.h"
@interface JYDownloadContentTable : JYContentTable

- (NSArray<JYDownloadContent *> *)getDownloadUnFinishType:(EDownloadType)type;
- (NSInteger)getDownloadUnFinishCountType:(EDownloadType)type;
- (NSArray<JYDownloadContent *> *)getDownloadFinishType:(EDownloadType)type;
- (NSInteger)getDownloadFinishCountType:(EDownloadType)type;
- (void)deleteDownloadContent:(JYDownloadContent *)aContent;


@end
