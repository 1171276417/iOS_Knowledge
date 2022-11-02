//
//  DJGenericsViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/28.
//

#import "DJGenericsViewController.h"
#import "Person1.h"

@interface DJGenericsViewController ()

@end

@implementation DJGenericsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    Person1<Language *> *P = [[Person1 alloc] init];
    
    
    Person1<iOS *> *p1 = [[Person1 alloc] init];
    p1.language = [[iOS alloc] init];
    
    P = p1;

    
    
    Person1<Java *> *p2 = [[Person1 alloc] init];
    
    NSLog(@"");
    
}


@end
