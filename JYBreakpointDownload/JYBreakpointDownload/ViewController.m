//
//  ViewController.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/18.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ViewController.h"
#import "JYDownloadManager.h"

@interface ViewController ()

@property (nonatomic, strong) JYDownloadManager *download;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JYDownloadManager *download = [[JYDownloadManager alloc] init];
    self.download = download;
    
    UIButton *button1 = [self addButtonTitle:@"开始1" action:@selector(start1:)];
    button1.frame = CGRectMake(0, 64, 80, 50);
    
    UIButton *button2 = [self addButtonTitle:@"取消1" action:@selector(cancel1:)];
    button2.frame = CGRectMake(100, 64, 80, 50);
   
    UIButton *button3 = [self addButtonTitle:@"开始2" action:@selector(start2:)];
    button3.frame = CGRectMake(0, 164, 80, 50);
    
    UIButton *button4 = [self addButtonTitle:@"取消2" action:@selector(cancel2:)];
    button4.frame = CGRectMake(100, 164, 80, 50);
}

- (void)start1:(UIButton *)but{
    JYDownloadContent *aContent = [[JYDownloadContent alloc] init];
    aContent.urlString = @"http://static.meishubao.com/video/2016-05-18/mCah6DSkD5.mp4";
    aContent.contentID = @"123";
    [self.download downloadContent:aContent onProgress:^(int64_t completeBytes, int64_t totalBytes) {
        
    } Complete:^(JYDownloadContent* aContent, NSError *aError) {
        NSLog(@"%@",aContent.finishPath);
        NSLog(@"%@",aError);
    }];
}

- (void)start2:(UIButton *)but{
    JYDownloadContent *aContent = [[JYDownloadContent alloc] init];
    aContent.contentID = @"456";
    aContent.urlString = @"http://192.168.1.126/resources/HHHorizontalPagingView.zip.1";
    [self.download downloadContent:aContent onProgress:^(int64_t completeBytes, int64_t totalBytes) {
        
    } Complete:^(JYDownloadContent* aContent, NSError *aError) {
        NSLog(@"%@",aContent.finishPath);
        NSLog(@"%@",aError);
    }];
}

- (void)cancel1:(UIButton*)but{
    [self.download cancelUrlString:@"http://static.meishubao.com/video/2016-05-18/mCah6DSkD5.mp4"];
}

- (void)cancel2:(UIButton*)but{
    [self.download cancelUrlString:@"http://192.168.1.126/resources/qwe.mp4"];
}

- (UIButton *)addButtonTitle:(NSString*)aTitle action:(SEL)aSel{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button addTarget:self action:aSel forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
