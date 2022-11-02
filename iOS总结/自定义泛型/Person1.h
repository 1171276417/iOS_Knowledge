//
//  Person1.h
//  iOS总结
//
//  Created by 邓杰 on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import "Language.h"
#import "iOS.h"
#import "Java.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person1<__covariant ObjectType> : NSObject
@property (nonatomic, strong ,null_unspecified) ObjectType language;

@end

NS_ASSUME_NONNULL_END
