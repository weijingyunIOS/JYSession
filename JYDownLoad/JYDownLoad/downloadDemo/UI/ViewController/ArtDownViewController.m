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
    NSArray *array =
  @[@"http://meishubao-static.oss.aliyuncs.com/ebook/zip/5e8a2354-7a41-4d75-a7cc-1cb337a4a5bd-d59afbae-3c63-49eb-8c61-bd10f4def5db.zip",
    @"http://meishubao-static.oss.aliyuncs.com/ebook/zip/bf8d3aa0-3956-412e-927b-10e92528842b-2833e47b-5a43-4227-a311-bf8956b6f2d6.zip",
    @"http://meishubao-static.oss.aliyuncs.com/ebook/zip/fe898b34-b3a2-4fcc-8e67-e68003f5d612-d725513b-8087-4687-a64d-f2af0ef10679.zip",
    @"http://meishubao-static.oss-cn-hangzhou.aliyuncs.com/video/2016-04-20/bfeac18e955d4b85b30b8856587af00f.mp4",
    @"http://meishubao-static.oss-cn-hangzhou.aliyuncs.com/video/2016-04-19/6a9cb19fd1954b7c85735c7ae62888dd.mp4",
    @"http://meishubao-static.oss-cn-hangzhou.aliyuncs.com/video/2016-04-15/2e8ffbbfcb8b48ff85bdcf8d1b8a576c.mp4",
    @"http://static.meishubao.com/video/2016-05-26/wfA3RrEMTH.mp4",
    @"http://meishubao-static.oss-cn-hangzhou.aliyuncs.com/video/2016-05-26/93515729705d631540b71463f65b9772.mp4",
    @"http://meishubao-static.oss-cn-hangzhou.aliyuncs.com/video/2016-05-26/fb6d9703a3c1f3974a487344f847e72f.mp4"
    ];
    static NSInteger count = 0;
    if (array.count > count) {
        [alert textFieldAtIndex:0].text = array[count];
//        [alert textFieldAtIndex:0].text = @"http://meishubao-static.oss.aliyuncs.com/ebook/zip/5e8a2354-7a41-4d75-a7cc-1cb337a4a5bd-d59afbae-3c63-49eb-8c61-bd10f4def5db.zip";
    }
    count ++;
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
