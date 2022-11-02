//
//  ObservationStruct.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObservationStruct : NSObject
///观察者对象
@property (nonatomic, strong) id observer;
///通知对象的方法
@property (nonatomic ) SEL __nullable selector;
///指向下一个观察者对象
@property (nonatomic, strong) ObservationStruct *__nullable next;




//
/////观察者对象
//id observer;
/////通知对象的方法
//SEL selector;
/////指向下一个观察者对象
//struct Obs *next;
/////引用计数
//int retained;

@end

NS_ASSUME_NONNULL_END
