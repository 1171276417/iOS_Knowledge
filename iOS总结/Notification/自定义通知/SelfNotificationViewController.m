//
//  SelfNotificationViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/21.
//

#import "SelfNotificationViewController.h"
#import "DJNotificationCenter.h"
#import "Singleton.h"
#import "DJNotification.h"


@interface SelfNotificationViewController ()
@property (nonatomic, strong) DJNotificationCenter *DJNotification;
@property (nonatomic, strong) Singleton *center;
@property (nonatomic, strong) SelfNotificationViewController *selfVC;

@end

@implementation SelfNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    _DJNotification = [[DJNotificationCenter alloc] init];
    
    _center = [Singleton sharedManager];
    
    _selfVC = [[SelfNotificationViewController alloc] init];
    
    
    
    [_DJNotification DJaddObserver:self selector:@selector(SelectNotification:) name:nil object:nil];
    [_DJNotification DJaddObserver:self selector:@selector(SelectNotification:) name:nil object:nil];
    
    [_DJNotification DJaddObserver:self selector:@selector(SelectNotification:) name:@"2" object:nil];
    
    [_DJNotification DJaddObserver:self selector:@selector(SelectNotification:) name:@"3" object:[NSArray new]];
    [_DJNotification DJaddObserver:self selector:@selector(SelectNotification:) name:@"4" object:nil];

    NSLog(@"");
      
}


- (void)SelectNotification:(DJNotification *)notification {
    NSLog(@"");
}


///触屏代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSDictionary *dic = @{@"123":@"asdfaf"};
    
    [_DJNotification DJpostNotificationName:@"4" object:dic userInfo:dic];
    
}



@end
