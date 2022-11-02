//
//  MemoryViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/5.
//

#import "MemoryViewController.h"
#import <mach/mach.h>
#import "SelfAutoreleasePool.h"
#import "AutoreleaseStack.h"
#include <pthread.h>

@interface MemoryViewController ()
@property (nonatomic, strong) AutoreleaseStack *singleStack;

@end

@implementation MemoryViewController

#define Log(_var) ({ NSString *name = @#_var; NSLog(@"变量名=%@，地址=%p，引用计数=%lu，值=%@", name, _var,(unsigned long)[_var retainCount], _var); })

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    id obj = [[NSObject alloc] init];
    
    id obj1 = [[NSObject alloc] init];
    
    NSLog(@"");
    
    SelfAutoreleasePool *pool = [SelfAutoreleasePool allocate];
    
    for(int i=1; i<150; i++) {
        id obj = [[NSObject alloc] init];
        [pool poolAddObject:obj];
    }
    
    SelfAutoreleasePool *pool1 = [SelfAutoreleasePool allocate];
    //id obj = [[NSObject alloc] init];
    [pool poolAddObject:obj];
    NSLog(@"");
    
    
    
    
    
//    SelfAutoreleasePool *pool = [SelfAutoreleasePool allocate];
//    for(int i=1; i<150; i++) {
//        id obj = [[NSObject alloc] init];
//        [pool poolAddObject:obj];
//    }
//
//    NSLog(@"");
    
    

        
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        [SelfAutoreleasePool startThreadPool];
        for(int i=1; i<150; i++) {
            id obj = [[NSObject alloc] init];
            [pool poolAddObject:obj];
        }

        [SelfAutoreleasePool deallocThreadpool];
        dispatch_async(dispatch_get_main_queue(), ^{

        });

    });
//
//    NSLog(@"");
//
//    [pool poolDrain];


    
//    for (int i = 0; i<10000000; i++) {
//
//        NSString *abc = [[NSString alloc] initWithFormat:@"21421521521541251大赛分发生非法撒打算251"];
//        if(i%100000 == 0) {
//            double ff = getMemoryUsage();
//           // [array addObject:abc];
//            NSLog(@"i=%d  内存占%fMB",i,ff);
//        }
//        if(i%2 == 0){
//            [abc release];
//        }
//        
//
//    }

    
    NSLog(@"");
    
    
}



/// 打印内存消耗
double getMemoryUsage(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    
    double memoryUsageInMB = kerr == KERN_SUCCESS ? (info.resident_size / 1024.0 / 1024.0) : 0.0;
    
    return memoryUsageInMB;
}







/**
 void *objc_autoreleasePoolPush(void) {
     return AutoreleasePoolPage::push();
 }

 void objc_autoreleasePoolPop(void *ctxt) {
     AutoreleasePoolPage::pop(ctxt);
 }
 */




@end
