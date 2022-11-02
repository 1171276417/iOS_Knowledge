//
//  KVOViewController.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/20.
//

#import "KVOViewController.h"
#import "Person.h"
#import "objc/runtime.h"

@interface KVOViewController ()
@property (nonatomic, strong) Person *person;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];

    self.person = [[Person alloc] init];
    __unused NSArray *arr = [[NSArray alloc] initWithObjects:@"123", nil];


    NSLog(@"Before addObserver------------------------");
    [self printClasses:[Person class]];

    //添加观察name
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:NULL];


    NSLog(@"After addObserver------------------------");
    [self printClasses:[Person class]];



    //添加观察person的dog的age
    [_person addObserver:self forKeyPath:@"dog" options:NSKeyValueObservingOptionNew context:nil];
    //添加观察数组array
    [_person addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionNew context:nil];



}

#pragma mark - 遍历类以及子类
- (void)printClasses:(Class)cls{
 // 注册类的总数
 int count = objc_getClassList(NULL, 0);
 // 创建一个数组， 其中包含给定对象
 NSMutableArray *mArray = [NSMutableArray arrayWithObject:cls];
 // 获取所有已注册的类
 Class* classes = (Class*)malloc(sizeof(Class)*count);
 objc_getClassList(classes, count);
 for (int i = 0; i<count; i++) {
      if (cls == class_getSuperclass(classes[i])) {
            [mArray addObject:classes[i]];
      }
 }
 free(classes);
 NSLog(@"classes = %@", mArray);
}






///触屏代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
static int a;
//KVO手动触发必须实现以下两个函数，自动触发时则自动实现
[_person willChangeValueForKey:@"name"]; /**通过KVC取得旧值，所以必须满足KVC取值的规则*/
_person.name = [NSString stringWithFormat:@"%d", a++];
[_person didChangeValueForKey:@"name"]; /**调用Observer的监听方法，所以Observer必须实现监听方法*/


//改变dog类属性监听变化
_person.dog.level = a;
_person.dog.age = a++;

/**
 array会被改变，但是直接无法被监听到
 因为addobject 并没有setter方法.观察者观察到的是setter方法的改变
 KVO不仅可以调用setter方法,还可以调用插入,删除,代替方法,观察者也可以观察到属性值的变化
 */

NSMutableArray *tempArr = [_person mutableArrayValueForKeyPath:@"array"];
[tempArr addObject:@"123"];


}



/// 观察接收观察对象消息
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
NSLog(@"%@", change);
NSLog(@"");

[self printClasses:[Person class]];

}


/**
kind 的值含义
NSKeyValueChangeSetting = 1,
//插入
NSKeyValueChangeInsertion = 2,
//删除
NSKeyValueChangeRemoval = 3,
//替换
NSKeyValueChangeReplacement = 4
*/


@end
