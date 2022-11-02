//
//  DJNotification.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/22.
//

#import <Foundation/Foundation.h>
#import "SelfNotificationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJNotification : NSObject

///标识符name
@property (nonatomic, strong) NSString *name;
///被监听对象
@property (nonatomic, strong) id object;
///传递附加消息
@property (nonatomic, strong) NSDictionary *userinfo;


@end

NS_ASSUME_NONNULL_END
