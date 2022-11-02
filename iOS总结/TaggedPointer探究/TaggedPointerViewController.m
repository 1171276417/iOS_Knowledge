//
//  TaggedPointerViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/7.
//

#import "TaggedPointerViewController.h"

@interface TaggedPointerViewController ()

@end

@implementation TaggedPointerViewController

extern uintptr_t objc_debug_taggedpointer_obfuscator;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSString *number1 = [NSString stringWithFormat:@"1"];
    NSString *number2 = [NSString stringWithFormat:@"2"];
    NSString *number3 = [NSString stringWithFormat:@"abc<"];
    NSString *numberFFFF = [NSString stringWithFormat:@"(0xFFFF"];
    
    
    NSLog(@"number1 pointer is %p---真实地址:==0x%lx", number1,_objc_decodeTaggedPointer_(number1));
    NSLog(@"number2 pointer is %p---真实地址:==0x%lx", number2,_objc_decodeTaggedPointer_(number2));
    NSLog(@"number3 pointer is %p---真实地址:==0x%lx", number3,_objc_decodeTaggedPointer_(number3));
    NSLog(@"numberffff pointer is %p---真实地址:==0x%lx", numberFFFF,_objc_decodeTaggedPointer_(numberFFFF));
    
    
        
    NSLog(@"");
}

uintptr_t _objc_decodeTaggedPointer_(id  ptr) {
    NSString *p = [NSString stringWithFormat:@"%ld",ptr];
    return [p longLongValue] ^ objc_debug_taggedpointer_obfuscator;
}

@end
