//
//  SelfAutoreleasePool.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/10.
//

#import "SelfAutoreleasePool.h"
#import "AutoreleaseStack.h"
#include <pthread.h>


@implementation SelfAutoreleasePool

#pragma mark - 私有变量




#pragma mark - 外部方法实现
+ (SelfAutoreleasePool *)allocate {
    
    SelfAutoreleasePool *pool = [[SelfAutoreleasePool new] allocZonePool];
    return pool;
}

///添加对象
- (void)poolAddObject:(id)object {
    if(self.currentPool->count < 100) {
        self.currentPool->objectArr[self.currentPool->count++] = object;
        
    }
    else {
        self.currentPool = [self addNewStack:self.currentPool addobject:object];
    }
}

///释放池中对象
- (void)poolDrain {
    //oc数组
    while (![self.currentPool->objectArr[self.currentPool->count-1] isEqual:@"哨兵节点"]) {
        [self.currentPool->objectArr[--self.currentPool->count] release];
        [self.currentPool->objectArr removeLastObject];
        if(self.currentPool->count == 0) {
            self.currentPool = self.currentPool->parent;
            free(self.currentPool->child);
            self.currentPool->child = NULL;
        }
    }
    [self.currentPool->objectArr removeObjectAtIndex:--self.currentPool->count];
}

///开启线程池
+ (void)startThreadPool {
    [[SelfAutoreleasePool new] allocZonePool];
}

///销毁线程池
+ (void)deallocThreadpool {
    NSString *thread_ID = [NSString stringWithFormat:@"%lld",(int64_t)pthread_self()];
    AutoreleaseStack *singleStack = [AutoreleaseStack sharedManager];
    if([singleStack.threadPool objectForKey:thread_ID]) {
         [[singleStack.threadPool objectForKey:thread_ID] dealloc];
        [singleStack.threadPool removeObjectForKey:thread_ID];
    }
}




#pragma mark - 内部方法封装

///根据线程ID创建实例对象
- (SelfAutoreleasePool *)allocZonePool {
                               
    SelfAutoreleasePool *pool;

    /*将线程编号字符串化*/
    NSString *thread_ID = [NSString stringWithFormat:@"%lld",(int64_t)pthread_self()];
    /*在全局字典中存取当前线程对应的pool存储池*/
    AutoreleaseStack *singleStack = [AutoreleaseStack sharedManager];
    if([singleStack.threadPool objectForKey:thread_ID]) {
        /*如果当前线程有pool，则直接取它*/
        pool = [singleStack.threadPool objectForKey:thread_ID];
    }
    else {
        /**如果当前线程没有pool，则创建一个并且存入表中*/
        pool = [[SelfAutoreleasePool alloc] init];
        [singleStack.threadPool setObject:pool forKey:thread_ID];
    }
    
    //添加哨兵节点初始化
    pool = [pool initPoolAddGuard:pool];
    
    return pool;
}


///初始化pool,添加哨兵对象
- (SelfAutoreleasePool *)initPoolAddGuard:(SelfAutoreleasePool *)pool {
    
    if(pool.currentPool == NULL) {
        pool.currentPool = [pool newStack];
        pool.currentPool->objectArr[pool.currentPool->count++] = @"哨兵节点";
    }
    else {
        if(pool.currentPool->count < 100) {
            pool.currentPool->objectArr[pool.currentPool->count++] = @"哨兵节点";
        }
        else {
            pool.currentPool = [pool addNewStack:pool.currentPool addobject:@"哨兵节点"];
        }
    }
    return pool;
}







///数组装满创建新表
- (autoreleasePoolPage *)addNewStack:(autoreleasePoolPage *) poolSK addobject:(id)object{
    autoreleasePoolPage *nextStack = [self newStack];
    poolSK->child = nextStack;
    nextStack->parent = poolSK;
    poolSK = nextStack;
    poolSK->objectArr = [[NSMutableArray alloc] initWithCapacity:100];
    poolSK->count = 0;
    poolSK->depth = poolSK->parent->depth+1;
    poolSK->objectArr[poolSK->count++] = object;
    return poolSK;
}

///创建并初始化一个新栈
- (autoreleasePoolPage *)newStack {
    autoreleasePoolPage * poolSK = (autoreleasePoolPage *)malloc(sizeof(autoreleasePoolPage));
    poolSK->objectArr = [[NSMutableArray alloc] initWithCapacity:100];
    poolSK->currentThread = pthread_self();
    poolSK->count = 0;
    poolSK->depth = 0;
    poolSK->parent = NULL;
    poolSK->child = NULL;
    return poolSK;
}




@end

