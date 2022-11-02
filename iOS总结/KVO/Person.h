//
//  Person.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/18.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
///person的名字
@property (nonatomic, copy) NSString *name;
///Dog对象
@property (nonatomic, strong) Dog *dog;

@property (nonatomic, strong) NSMutableArray *array;



@end

NS_ASSUME_NONNULL_END
