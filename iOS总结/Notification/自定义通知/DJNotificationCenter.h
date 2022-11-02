//
//  DJNotificationCenter.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJNotificationCenter : NSObject

/// 注册观察者
/// - Parameters:
///   - observer: 观察者对象
///   - aSelector: 观察者所执行的方法
///   - aName: 标识符
///   - anObject: 监听对象
- (void)DJaddObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject;



/// 发送通知
/// - Parameters:
///   - aName: 标识符
///   - anObject: 被监听对象
///   - aUserInfo: 附加信息
- (void)DJpostNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;



@end

NS_ASSUME_NONNULL_END
