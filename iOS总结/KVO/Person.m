//
//  Person.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/18.
//

#import "Person.h"

@implementation Person

///初始化
- (instancetype)init {
    if(self = [super init]) {
        _dog = [[Dog alloc]init];
        _array = @[].mutableCopy;
       }
       return self;
}

///控制触发方式
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    //手动触发 name属性的KVO观察
    if([key isEqualToString:@"name"]) {
        return NO;
    }
    //如果返回YES就是自动触发
    else
        return YES;
}




+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSLog(@"%@",key);/**key为Person的属性名*/
      
      //可不可以观察到dog属性
      NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
      if([key isEqualToString:@"dog"]){
          
          NSArray *aggectingkeys = @[@"_dog.age",@"_dog.level"];
          
        keyPaths =  [keyPaths setByAddingObjectsFromArray:aggectingkeys];
      }
      return keyPaths;
}
    





@end
