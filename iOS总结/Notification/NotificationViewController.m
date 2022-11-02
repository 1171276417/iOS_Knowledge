//
//  NotificationViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/20.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notification) name:@"123" object:nil];
    
    [center addObserverForName:@"123" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"");
        [[NSNotificationCenter defaultCenter] removeObserver:self]; /**使用block仍然需要手动移除观察者**/
    }];

}



- (void)notification {
    NSLog(@"");

}


///触屏代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSNotification *noti = [[NSNotification alloc] initWithName:@"123" object:nil userInfo:nil];
    [center postNotification:noti];
}


@end
