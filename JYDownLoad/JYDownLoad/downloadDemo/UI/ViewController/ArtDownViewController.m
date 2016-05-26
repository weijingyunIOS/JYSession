//
//  ArtDownViewController.m
//  JYDownLoad
//
//  Created by weijingyun on 16/5/26.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtDownViewController.h"
#import "ArtDownCell.h"

@interface ArtDownViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ArtDownViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configurationTableView];
}

- (void)configurationTableView{
   CGSize size = [UIScreen mainScreen].bounds.size;
   self.tableView.frame = CGRectMake(0, 0, size.width, size.height);
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArtDownCell *aCell = [[ArtDownCell alloc] init];
//    aCell.backgroundColor = [UIColor redColor];
    return aCell;
}


#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
