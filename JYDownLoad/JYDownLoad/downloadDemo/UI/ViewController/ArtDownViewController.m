//
//  ArtDownViewController.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtDownViewController.h"
#import "ArtDownCell.h"
#import "ArtNetWorkService+downBook.h"
#import "Masonry.h"

@interface ArtDownViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ArtDownViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configurationTableView];
    [self configurationRightView];
    [self reload];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    [self cacleBlock];
}

- (void)configurationRightView{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增下载" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
}

- (void)rightClick{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新增下载" message:@"下载链接" delegate: self  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag != 1000) {
        return;
    }
    
    if (buttonIndex != 1) {
        return;
    }
    NSString *urlString = [alertView textFieldAtIndex:0].text;
    urlString = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self addDownLoadUrl:urlString];
}

- (void)configurationTableView{
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.view);
   }];
   [self.tableView registerClass:[ArtDownCell class] forCellReuseIdentifier:@"ArtDownCell"];
}

- (void)reload{
    
}

- (void)cacleBlock{
    
}

- (void)downloadForCell:(ArtDownCell *)aCell info:(JYDownloadInfo *)aInfo{
  
}

- (void)cacleForInfo:(JYDownloadInfo *)aInfo{
}

- (void)deleteDownForInfo:(JYDownloadInfo *)aInfo{
}

- (void)addDownLoadUrl:(NSString *)urlString{
}

- (void)showText:(NSString *)str{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate: self  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (JYDownloadInfo *)getInfoFor:(NSIndexPath *)indexPath{
    NSArray *array;
    if (indexPath.section == 0) {
        array = self.unfinsh;
    }else{
        array = self.finsh;
    }
    
    return array[indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = self.unfinsh.count;
            break;
            
        case 1:
            count = self.finsh.count;
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArtDownCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"ArtDownCell" forIndexPath:indexPath];
    JYDownloadInfo *aInfo = [self getInfoFor:indexPath];
    if (aInfo.downLoadState == EDownloadStateGoing) {
        [self downloadForCell:aCell info:aInfo];
    }
    [aCell updateInfo:aInfo];
    return aCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ArtDownCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYDownloadInfo *aInfo = [self getInfoFor:indexPath];
    if (aInfo.downLoadState == EDownloadStateGoing) {
        [self cacleForInfo:aInfo];
    }else if(aInfo.downLoadState != EDownloadStateFinish){
        ArtDownCell *aCell = [tableView cellForRowAtIndexPath:indexPath];
        [self downloadForCell:aCell info:aInfo];
        [aCell updateInfo:aInfo];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @"";
    switch (section) {
        case 0:
            str = @"未完成";
            break;
            
        case 1:
            str = @"已完成";
            break;
    }
    return str;
}

#pragma mark 删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYDownloadInfo *aInfo = [self getInfoFor:indexPath];
    [self deleteDownForInfo:aInfo];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
