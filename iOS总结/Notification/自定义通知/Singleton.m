//
//  Singleton.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/23.
//

#import "Singleton.h"

@implementation Singleton

+ (Singleton *)sharedManager {
  static dispatch_once_t onceToken;
  static Singleton *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[Singleton alloc] init];
  });
  return sharedManager;
}

@end
