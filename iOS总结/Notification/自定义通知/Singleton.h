//
//  Singleton.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject

///存储有name的观察者
@property (nonatomic, strong) NSMutableDictionary *nameTable;
///存储只有object的观察者
@property (nonatomic, strong) NSMutableDictionary *namelessTable;



///单例方法，只创建一个对象
+ (Singleton *)sharedManager;

#pragma mark - 禁用初始化方法
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)alloc UNAVAILABLE_ATTRIBUTE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone UNAVAILABLE_ATTRIBUTE;


@end

NS_ASSUME_NONNULL_END
