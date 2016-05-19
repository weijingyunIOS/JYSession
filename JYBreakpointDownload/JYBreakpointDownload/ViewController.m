//
//  ViewController.m
//  JYBreakpointDownload
//
//  Created by weijingyun on 16/5/18.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"aaa"];
    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithResumeData:<#(nonnull NSData *)#> completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
