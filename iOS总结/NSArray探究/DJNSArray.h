//
//  DJNSArray.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJNSArray : NSObject
///元素数量
@property (nonatomic) unsigned long long used;
///缓冲区大小
@property (nonatomic) unsigned long long size;
///第一个元素在缓冲区的位置
@property (nonatomic) unsigned long long offset;
///指向缓冲区的指针
@property (nonatomic, strong) DJNSArray *list;












#pragma mark - 禁用初始化方法
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


@end

NS_ASSUME_NONNULL_END
