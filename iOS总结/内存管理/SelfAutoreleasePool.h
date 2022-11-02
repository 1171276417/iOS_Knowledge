//
//  SelfAutoreleasePool.h
//  iOS总结
//
//  Created by 邓杰 on 2022/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelfAutoreleasePool : NSObject

typedef struct autoreleasePoolPage {
    ///当前线程
    pthread_t currentThread;
    ///上一个page
    struct autoreleasePoolPage *parent;
    ///下一个page
    struct autoreleasePoolPage *child;
    ///深度（page的页数）
    NSUInteger depth;
    ///数组下标
    int count;
    ///存储OC对象
    NSMutableArray *objectArr;
        
} autoreleasePoolPage;

///当前page
@property autoreleasePoolPage *currentPool;



///初始化自定义释放池
+ (SelfAutoreleasePool *)allocate;
///添加对象
- (void)poolAddObject:(id)object;
///释放池中对象
- (void)poolDrain;
///开启新线程池
+ (void)startThreadPool;
///销毁线程池
+ (void)deallocThreadpool;










#pragma mark - 禁用初始化方法
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)alloc UNAVAILABLE_ATTRIBUTE;
//+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone UNAVAILABLE_ATTRIBUTE;

@end






NS_ASSUME_NONNULL_END
