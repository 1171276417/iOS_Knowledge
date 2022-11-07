//
//  KMP.h
//  iOS总结
//
//  Created by 邓杰 on 2022/10/27.
//

#import <Foundation/Foundation.h>
#import "RegExp.h"

NS_ASSUME_NONNULL_BEGIN

@interface KMP : NSObject

void kmp(void);


///标准化字符串
typedef struct StringArr {
    /**将字符串转为char指针数组*/
    char *_Nullable* _Nullable stringArr;
    /**字符数组**/
    char *_Nullable* _Nullable charArr;
    /**字符串成员的集合（不重复）**/
    char *_Nullable* _Nullable charSet;
    /**字符串长度（数组长度）*/
    int length;
    /**字符数组长度**/
    int charCount;
    /**字符种类数（集合大小）*/
    int setSize;
}StringArr;


/// 将字符串标准化返回StringArr
/// - Parameter initialLength: 字符串初始长度
StringArr* initStringArray(char target[_Nullable], int initialLength);


/// 获得该字符在集合的位置
/// - Parameters:
///   - arr: 目标字符串
///   - data: 查询的字符
int getLocationInArray(StringArr *arr, char *data);






@end

NS_ASSUME_NONNULL_END
