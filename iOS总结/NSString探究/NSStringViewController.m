//
//  NSStringViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/26.
//

#import "NSStringViewController.h"

@interface NSStringViewController ()

@end

@implementation NSStringViewController

#define Log(_var) ({ NSString *name = @#_var; NSLog(@"变量名=%@，类型=%@， 地址=%p，引用计数=%lu，值=%@", name, [_var class], _var,(unsigned long)[_var retainCount], _var); })

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSString *s0 = [[NSString alloc] init];
    NSString *s1 = @"djdjdj";
    NSString *s3 = [[NSString alloc] initWithString:@"djdjdj"];
    NSString *s4 = [[NSString alloc] initWithString:s0];

    NSString *s5 = [[NSString alloc] initWithFormat:@"djdjdjdj"];
    NSString *s6 = [NSString stringWithFormat:@"%@", s5];
    NSString *s7 = [NSString stringWithFormat:@"djdjdjdjdjdd"];  //字符串长度>=12或者含有中文，将是NSCFString类型，否则为NSTaggedpointerString

    NSString *s8 = [NSString stringWithFormat:@"啊啊啊啊啊sagas"];

    NSString *s9 = s1.copy;
    NSString *s10 = s1.mutableCopy;
    NSString *s11 = s5.copy;
    NSString *s12 = s5.mutableCopy;
    NSString *s13 = s8.copy;
    NSString *s14 = s8.mutableCopy;

    
    
    Log(s0);
    Log(s1);
    Log(s3);
    Log(s4);
    Log(s5);
    Log(s6);
    Log(s7);
    Log(s8);
    Log(s9);
    Log(s10);
    Log(s11);
    Log(s12);
    Log(s13);
    Log(s14);
 


}



@end
