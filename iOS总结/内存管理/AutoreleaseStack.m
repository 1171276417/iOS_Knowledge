//
//  AutoreleaseStack.m
//  iOS总结
//
//  Created by 邓杰 on 2022/10/10.
//

#import "AutoreleaseStack.h"
#include <pthread.h>

@implementation AutoreleaseStack
//NSMutableDictionary *threadPool;

+ (AutoreleaseStack *)sharedManager {
    static dispatch_once_t onceToken;
    static AutoreleaseStack *sharedManager;
    dispatch_once(&onceToken, ^{
    sharedManager = [[AutoreleaseStack alloc] init];
        if(!sharedManager.threadPool) {
            sharedManager.threadPool = [[NSMutableDictionary alloc] init];
        }
    });
    
 
    
    
    
  return sharedManager;
}

@end
