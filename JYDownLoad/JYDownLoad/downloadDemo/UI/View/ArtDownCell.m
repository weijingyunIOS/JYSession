//
//  ArtDownCell.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtDownCell.h"
#import "Masonry.h"
#import "ArtBookInfo.h"
#import "ArtVideoInfo.h"


@interface ArtDownCell()

@property (nonatomic, strong) UILabel *titileLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) JYDownloadInfo *downInfo;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation ArtDownCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configurationView];
    }
    return self;
}

- (void)configurationView{
    [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(8);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titileLabel);
        make.right.equalTo(self.contentView).offset(-8);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.titileLabel);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.left.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.height.mas_equalTo(5);
    }];
    
}

+ (CGFloat)height{
    return 50;
}

#pragma mark - 显示更新
- (void)updateInfo:(JYDownloadInfo*)aInfo{
    self.downInfo = aInfo;
    if ([aInfo isKindOfClass:[ArtBookInfo class]]) {
        ArtBookInfo *info = (ArtBookInfo *)aInfo;
        self.titileLabel.text = info.bookID;
        self.nameLabel.text = info.bookName;
    }else{
        ArtVideoInfo *info = (ArtVideoInfo *)aInfo;
        self.titileLabel.text = info.videoID;
        self.nameLabel.text = info.videoDesc;
    }
    
    [self updateState:aInfo];
    CGFloat progress = aInfo.serverFileSize <= 0 ? 0.0 : aInfo.currentFileSize / (CGFloat)aInfo.serverFileSize;
    [self.progressView setProgress:progress];
}

- (void)updateProgress:(JYDownloadInfo*)aInfo{
    if (self.downInfo != aInfo) {
        return;
    }
    CGFloat progress = aInfo.serverFileSize <= 0 ? 0.0 : aInfo.downLoadSize / (CGFloat)aInfo.serverFileSize;
    NSLog(@"%f",progress);
    [self.progressView setProgress:progress];
}

- (void)updateState:(JYDownloadInfo*)aInfo{
    if (self.downInfo != aInfo) {
        return;
    }
    NSString *str = @"";
    switch (aInfo.downLoadState) {
        case EDownloadStateWaiting:
            str = @"等待下载";
            break;
            
        case EDownloadStateGoing:
            str = @"正在下载";
            break;
            
        case EDownloadStatePause:
            str = @"暂停下载";
            break;
            
        case EDownloadStateFinish:
            str = @"完成下载";
            break;
            
        case EDownloadStateFaile:
            str = @"下载失败";
            break;
            
        case EDownloadStateDelete:
            str = @"已删除";
            break;
    }
    self.stateLabel.text = str;
}

#pragma mark -  懒加载
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        [self.contentView addSubview:_progressView];
    }
    return _progressView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)titileLabel{
    if (!_titileLabel) {
        _titileLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titileLabel];
    }
    return _titileLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
