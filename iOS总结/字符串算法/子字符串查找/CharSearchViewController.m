//
//  CharSearchViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/25.
//

#import "CharSearchViewController.h"
#import "Boyer-Moore.h"
#import "KMP.h"
#import "RegExp.h"

@interface CharSearchViewController ()

@end

@implementation CharSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //KMP算法
    kmp();
    
    
    //BoyerMoore算法
    //boyerMoore();
    
    regularExpression();
    
    
    
}



@end
