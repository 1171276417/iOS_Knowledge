//
//  ViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/18.
//

#import "ViewController.h"
#import "KVOViewController.h"
#import "NotificationViewController.h"
#import "SelfNotificationViewController.h"
#import "NSStringViewController.h"
#import "NSArrayViewController.h"
#import "DJGenericsViewController.h"
#import "MemoryViewController.h"
#import "TaggedPointerViewController.h"
#import "StringSortingViewController.h"
#import "WordTreeViewController.h"
#import "CharSearchViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SelfNotificationViewController *selfNotificationVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setFrame:CGRectMake(0, 0, 390, 844)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

///设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


///设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


///设置内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if(indexPath.row == 0) {
        cell.textLabel.text = @"KVO";
    }
    if(indexPath.row == 1) {
        cell.textLabel.text = @"Notification";
    }
    if(indexPath.row == 2) {
        cell.textLabel.text = @"自定义Notification";
    }
    if(indexPath.row == 3) {
        cell.textLabel.text = @"NSString探究";
    }
    if(indexPath.row == 4) {
        cell.textLabel.text = @"NSArray探究";
    }
    if(indexPath.row == 5) {
        cell.textLabel.text = @"自定义泛型";
    }
    if(indexPath.row == 6) {
        cell.textLabel.text = @"内存管理";
    }
    if(indexPath.row == 7) {
        cell.textLabel.text = @"TaggedPointer探究";
    }
    if(indexPath.row == 8) {
        cell.textLabel.text = @"字符串排序";
    }
    if(indexPath.row == 9) {
        cell.textLabel.text = @"单词查找树";
    }
    if(indexPath.row == 10) {
        cell.textLabel.text = @"子字符串查找";
    }
    return cell;
}


///进入会话
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        KVOViewController *KVOVC = [[KVOViewController alloc] init];
        [self presentViewController:KVOVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 1) {
        NotificationViewController *notificationVC = [[NotificationViewController alloc] init];
        [self presentViewController:notificationVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 2) {
        _selfNotificationVC = [[SelfNotificationViewController alloc] init];
        [self presentViewController:_selfNotificationVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 3) {
        NSStringViewController *nssVC = [[NSStringViewController alloc] init];
        [self presentViewController:nssVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 4) {
        NSArrayViewController *arrayVC = [[NSArrayViewController alloc] init];
        [self presentViewController:arrayVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 5) {
        DJGenericsViewController *genericsVC = [[DJGenericsViewController alloc] init];
        [self presentViewController:genericsVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 6) {
        MemoryViewController *memoryVC = [[MemoryViewController alloc] init];
        [self presentViewController:memoryVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 7) {
        TaggedPointerViewController *tagVC = [[TaggedPointerViewController alloc] init];
        [self presentViewController:tagVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 8) {
        StringSortingViewController *stringVC = [[StringSortingViewController alloc] init];
        [self presentViewController:stringVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 9) {
        WordTreeViewController *wordVC = [[WordTreeViewController alloc] init];
        [self presentViewController:wordVC animated:YES completion:^{
        }];
    }
    if(indexPath.row == 10) {
        CharSearchViewController *charVC = [[CharSearchViewController alloc] init];
        [self presentViewController:charVC animated:YES completion:^{
        }];
    }
}



@end
