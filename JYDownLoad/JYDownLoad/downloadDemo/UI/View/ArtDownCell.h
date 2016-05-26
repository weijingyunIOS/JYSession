//
//  ArtDownCell.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JYDownloadInfo;

@interface ArtDownCell : UITableViewCell

+ (CGFloat)height;

- (void)updateProgress:(JYDownloadInfo*)aInfo;
- (void)updateInfo:(JYDownloadInfo*)aInfo;
- (void)updateState:(JYDownloadInfo*)aInfo;

@end
