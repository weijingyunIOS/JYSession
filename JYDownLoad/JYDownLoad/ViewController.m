//
//  ViewController.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/18.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ViewController.h"
#import "ArtNetWorkService+downBook.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button1 = [self addButtonTitle:@"开始1" action:@selector(start1:)];
    button1.frame = CGRectMake(0, 64, 80, 50);
    
    UIButton *button2 = [self addButtonTitle:@"取消1" action:@selector(cancel1:)];
    button2.frame = CGRectMake(100, 64, 80, 50);
    
    UIButton *button3 = [self addButtonTitle:@"开始2" action:@selector(start2:)];
    button3.frame = CGRectMake(0, 164, 80, 50);
    
    UIButton *button4 = [self addButtonTitle:@"取消2" action:@selector(cancel2:)];
    button4.frame = CGRectMake(100, 164, 80, 50);
    
    UIButton *button5 = [self addButtonTitle:@"已完成" action:@selector(finish:)];
    button5.frame = CGRectMake(0, 264, 80, 50);
    
    UIButton *button6 = [self addButtonTitle:@"未完成" action:@selector(unfinish:)];
    button6.frame = CGRectMake(100, 264, 80, 50);
    
    UIButton *button7 = [self addButtonTitle:@"删除1" action:@selector(delete1:)];
    button7.frame = CGRectMake(0, 364, 80, 50);
    UIButton *button8 = [self addButtonTitle:@"删除2" action:@selector(delete2:)];
    button8.frame = CGRectMake(100, 364, 80, 50);
}

- (void)delete1:(UIButton *)but{
    NSString *urlString = @"http://static.meishubao.com/video/2016-05-18/mCah6DSkD5.mp4";
    [[ArtNetWorkService shared] deleteBookByUrlString:urlString];
}

- (void)delete2:(UIButton *)but{
//    JYDownloadContent *aContent = [[JYDownloadContent alloc] init];
//    aContent.contentID = @"456";
//    [[JYNetWorkService shared] deleteDownloadContent:aContent];
}

- (void)finish:(UIButton *)but{
    NSArray<ArtBookInfo*>* infos = [[ArtNetWorkService shared] getFinishBook];
    NSInteger count = [[ArtNetWorkService shared] getFinishBookCount];
    NSLog(@"%@ -- %tu",infos,count);
}

- (void)unfinish:(UIButton *)but{
    NSArray<ArtBookInfo*>* infos = [[ArtNetWorkService shared] getUnFinishBook];
    NSInteger count = [[ArtNetWorkService shared] getUnFinishBookCount];
    NSLog(@"%@ -- %tu",infos,count);
}

- (void)start1:(UIButton *)but{
    ArtBookInfo *aBook = [[ArtBookInfo alloc] init];
    aBook.urlString = @"http://static.meishubao.com/video/2016-05-18/mCah6DSkD5.mp4";
    aBook.bookID = @"123";
    aBook.bookName = @"bookName";
    [[ArtNetWorkService shared] downloadBookInfo:aBook onProgress:^(int64_t completeBytes, int64_t totalBytes) {
        NSLog(@"%f",completeBytes / (CGFloat)(totalBytes));
    } Complete:^(ArtBookInfo *aBook, NSError *aError) {
        if (aError != nil) {
            NSLog(@"%@",[aError localizedDescription]);
            return;
        }
        NSLog(@"%@-%@-%@-%@",aBook.bookID,aBook.bookName,aBook.urlString,aBook.finishPath);
    }];
}

- (void)start2:(UIButton *)but{
//    JYDownloadContent *aContent = [[JYDownloadContent alloc] init];
//    aContent.contentID = @"456";
//    aContent.urlString = @"http://192.168.1.126/resources/HHHorizontalPagingView.zip.1";
//    [[JYNetWorkService shared] downloadContent:aContent onProgress:^(int64_t completeBytes, int64_t totalBytes) {
//        
//    } Complete:^(JYDownloadContent* aContent, NSError *aError) {
//        NSLog(@"%@",aContent.finishPath);
//        NSLog(@"%@",aError);
//    }];
}

- (void)cancel1:(UIButton*)but{
    [[ArtNetWorkService shared] cancelBookUrlString:@"http://static.meishubao.com/video/2016-05-18/mCah6DSkD5.mp4"];
}

- (void)cancel2:(UIButton*)but{
//    [[JYNetWorkService shared] cancelUrlString:@"http://192.168.1.126/resources/qwe.mp4"];
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
