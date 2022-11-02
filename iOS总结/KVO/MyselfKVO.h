//
//  MyselfKVO.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyselfKVO : NSObject

- (void)dj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
- (void)dj_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context;
- (void)dj_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;




@end

NS_ASSUME_NONNULL_END

