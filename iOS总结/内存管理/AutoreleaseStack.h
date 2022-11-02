//
//  AutoreleaseStack.h
//  iOS总结
//
//  Created by 邓杰 on 2022/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoreleaseStack : NSObject

@property (nonatomic, strong) NSMutableDictionary *threadPool;



///单例方法，只创建一个对象
+ (AutoreleaseStack *)sharedManager;

#pragma mark - 禁用初始化方法
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)alloc UNAVAILABLE_ATTRIBUTE;
+ (instancetype)allocWithZone:(struct _NSZone *)zone UNAVAILABLE_ATTRIBUTE;



@end

NS_ASSUME_NONNULL_END
