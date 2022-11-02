//
//  MyselfKVO.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/20.
//

#import "MyselfKVO.h"
#import "objc/runtime.h"

@implementation MyselfKVO

//
//- (void)dj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
//
//    // 1: 验证是否存在setter方法 : 不让实例进来
//    [self judgeSetterMethodFromKeyPath:keyPath];
//    // 2: 动态生成子类
//    Class newClass = [self createChildClassWithKeyPath:keyPath];
//    // 3: isa的指向
//    object_setClass(self, newClass);
//    // 4: 保存观察者
//    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(KJPKVOAssiociateKey), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//
//
///// 判断是否有setter方法
///// - Parameter keyPath: keyPath description
//- (void)judgeSetterMethodFromKeyPath:(NSString *)keyPath {
//    Class superClass    = object_getClass(self);
//    SEL setterSeletor   = NSSelectorFromString(setterForGetter(keyPath));
//    Method setterMethod = class_getInstanceMethod(superClass, setterSeletor);
//    if (!setterMethod) {
//        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"不好意思没有当前%@的setter",keyPath] userInfo:nil];
//    }
//}
//
//
//
///// 动态生成子类
///// - Parameter keyPath: keyPath description
//- (Class)createChildClassWithKeyPath:(NSString *)keyPath {
//
//    NSString *oldClassName = NSStringFromClass([self class]);
//    NSString *newClassName = [NSString stringWithFormat:@"%@%@",kjpKVOPrefix,oldClassName];
//    Class newClass = NSClassFromString(newClassName);
//    // 防止重复创建生成新类
//    if (newClass) return newClass;
//    /**
//     * 如果内存不存在,创建生成
//     * 参数一: 父类
//     * 参数二: 新类的名字
//     * 参数三: 新类的开辟的额外空间
//     */
//    // 2.1 : 申请类
//    newClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
//    // 2.2 : 注册类
//    objc_registerClassPair(newClass);
//    // 2.3.1 : 添加class : class的指向是JPPerson
//    SEL classSEL = NSSelectorFromString(@"class");
//    Method classMethod = class_getInstanceMethod([self class], classSEL);
//    const char *classTypes = method_getTypeEncoding(classMethod);
//    class_addMethod(newClass, classSEL, (IMP)jp_class, classTypes);
//    // 2.3.2 : 添加setter
//    SEL setterSEL = NSSelectorFromString(setterForGetter(keyPath));
//    Method setterMethod = class_getInstanceMethod([self class], setterSEL);
//    const char *setterTypes = method_getTypeEncoding(setterMethod);
//    class_addMethod(newClass, setterSEL, (IMP)jp_setter, setterTypes);
//    return newClass;
//}
//
//
//
///// 返回父类信息
//Class JP_class(id self,SEL _cmd) {
//    return class_getSuperclass(object_getClass(self));
//}
//
//
//
//
//
//static void jp_setter(id self,SEL _cmd,id newValue) {
//    // 4: 消息转发 : 转发给父类
//    // 改变父类的值 --- 可以强制类型转换
//    void (*jp_msgSendSuper)(void *,SEL , id) = (void *)objc_msgSendSuper;
//    // void /* struct objc_super *super, SEL op, ... */
//    struct objc_super superStruct = {
//        .receiver = self,
//        .super_class = class_getSuperclass(object_getClass(self)),
//    };
//    //objc_msgSendSuper(&superStruct,_cmd,newValue)
//    jp_msgSendSuper(&superStruct,_cmd,newValue);
//
//    // 既然观察到了,下一步不就是回调 -- 让我们的观察者调用
//    // - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//    // 1: 拿到观察者
//    id observer = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kJPKVOAssiociateKey));
//
//    // 2: 消息发送给观察者
//    SEL observerSEL = @selector(observeValueForKeyPath:ofObject:change:context:);
//    NSString *keyPath = getterForSetter(NSStringFromSelector(_cmd));
//    objc_msgSend(observer,observerSEL,keyPath,self,@{keyPath:newValue},NULL);
//}
//





@end
