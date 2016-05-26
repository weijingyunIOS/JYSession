//
//  ArtDownViewController.h
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  JYDownloadInfo,ArtDownCell;

@interface ArtDownViewController : UIViewController

@property (nonatomic, strong) NSArray *unfinsh;
@property (nonatomic, strong) NSArray *finsh;
@property (nonatomic, strong, readonly) UITableView *tableView;

- (void)reload;
- (void)downloadForCell:(ArtDownCell *)aCell info:(JYDownloadInfo *)aInfo;
- (void)cacleForInfo:(JYDownloadInfo *)aInfo;
- (void)deleteDownForInfo:(JYDownloadInfo *)aInfo;
- (void)cacleBlock;
- (void)showText:(NSString *)str;

@end
