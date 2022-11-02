//
//  DJNotificationCenter.m
//  iOS总结
//
//  Created by 邓杰 on 2022/9/22.
//

#import "DJNotificationCenter.h"
#import "ObservationStruct.h"
#import "Singleton.h"
#import "DJNotification.h"

@implementation DJNotificationCenter

- (void)DJaddObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject {
    ObservationStruct *observerStuct = [[ObservationStruct alloc] init];
    observerStuct.observer = observer;
    observerStuct.selector = aSelector;
    
    
    Singleton *center = [Singleton sharedManager];
    //如果有name
    if(aName) {
        //如果该name已经存储
        if([center.nameTable objectForKey:aName]) {
            //如果有object
            if(anObject) {
                //如果object在表中，将该观察者结构体加入链表
                if([[center.nameTable objectForKey:aName] objectForKey:anObject]) {
                    ObservationStruct *ob0 = ([[center.nameTable objectForKey:aName] objectForKey:anObject]);
                    observerStuct.next = ob0;
                    [[center.nameTable objectForKey:aName] setObject:(observerStuct) forKey:anObject];
                }
                //如果object不在表中，则添加K-V
                else {
                    observerStuct.next = NULL;
                    [[center.nameTable objectForKey:aName] setObject:(observerStuct) forKey:anObject];
                }
            }
            //如果没有object
            else {
                //将观察者加入到wildcard链表
                if([[center.nameTable objectForKey:aName] objectForKey:@"wildcard"]) {
                    ObservationStruct *ob0 = ([[center.nameTable objectForKey:aName] objectForKey:@"wildcard"]);
                    observerStuct.next = ob0;
                    [[center.nameTable objectForKey:aName] setObject:(observerStuct) forKey:@"wildcard"];
                }
                //如果wildcard链表为空
                else {
                    observerStuct.next = NULL;
                    [[center.nameTable objectForKey:aName] setObject:(observerStuct) forKey:@"wildcard"];
                }
            }
        }
        //如果该name不在表中，加入该name
        else {
            NSMutableDictionary *objectTable = [NSMutableDictionary dictionary];
            //如果有object
            if(anObject) {
                observerStuct.next = NULL;
                [objectTable setObject:observerStuct forKey:anObject];
            }
            //如果没有object就存入wildcard链表
            else {
                observerStuct.next = NULL;
                [objectTable setObject:(observerStuct) forKey:@"wildcard"];
            }
            [center.nameTable setObject:objectTable forKey:aName];
        }
    }
    
    //如果没有name
    else {
        //如果有object
        if(anObject) {
            //如果object在表中，将该观察者结构体加入链表
            if([center.namelessTable objectForKey:anObject]) {
                ObservationStruct *ob0 = ([center.namelessTable objectForKey:anObject]);
                observerStuct.next = ob0;
                [center.namelessTable setObject:(observerStuct) forKey:anObject];
            }
            //如果object不在表中，则添加K-V
            observerStuct.next = NULL;
            [center.namelessTable setObject:(observerStuct) forKey:anObject];
        }
        //如果没有object
        else {
            //将观察者加入到wildcard链表
            if([center.namelessTable objectForKey:@"wildcard"]) {
                ObservationStruct *ob0 = [center.namelessTable objectForKey:@"wildcard"];
                observerStuct.next = ob0;
                [center.namelessTable setObject:(observerStuct) forKey:@"wildcard"];
            }
            //如果wildcard链表为空
            else {
                observerStuct.next = NULL;
                [center.namelessTable setObject:(observerStuct) forKey:@"wildcard"];
            }
        }
    }
    NSLog(@"");
}



- (void)DJpostNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    DJNotification *notification = [[DJNotification alloc] init];
    notification.name = aName;
    notification.object = anObject;
    notification.userinfo = aUserInfo;
    
    Singleton *center = [Singleton sharedManager];
    
    //存放通知对象的数组
    NSMutableArray *observerArray = @[].mutableCopy;
    //如果有name和object    添加 无name无object、无name object相同、name相同无object、name和object相同
    if(aName && anObject) {
        //无name、object相同
        if([center.namelessTable objectForKey:anObject]) {
            ObservationStruct *observation = [center.namelessTable objectForKey:anObject];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
        //无name无object
        if([center.namelessTable objectForKey:@"wildcard"]) {
            ObservationStruct *observation = [center.namelessTable objectForKey:@"wildcard"];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
        //name相同无object
        if([[center.nameTable objectForKey:aName] objectForKey:@"wildcard"]) {
            ObservationStruct *observation = [[center.nameTable objectForKey:aName] objectForKey:@"wildcard"];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
        //name相同object相同
        if([[center.nameTable objectForKey:aName] objectForKey:anObject]) {
            ObservationStruct *observation = [[center.nameTable objectForKey:aName] objectForKey:anObject];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
    }
    
    //只有name 添加name中所有对象,和nameless表中所有对象
    if(aName && !anObject) {
        //添加nameless中无object的对象
        ObservationStruct *ob = [center.namelessTable objectForKey:@"wildcard"];
        [observerArray addObject:ob];
        while (ob.next) {
            ob = ob.next;
            [observerArray addObject:ob];
        }
        //添加name相同的无object对象
        if([[center.nameTable objectForKey:aName] objectForKey:@"wildcard"]) {
            ObservationStruct *observation = [[center.nameTable objectForKey:aName] objectForKey:@"wildcard"];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
    }
    
    //没有name，只有object
    if(!aName && anObject) {
        //namelessTabel中object相同的或者wildcard
        if([center.namelessTable objectForKey:anObject]) {
            ObservationStruct *observation = [center.namelessTable objectForKey:anObject];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
        if([center.namelessTable objectForKey:@"wildcard"]) {
            ObservationStruct *observation = [center.namelessTable objectForKey:@"wildcard"];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
    }
    
    //没有name没有objcet
    if(!aName && !anObject) {
        if([center.namelessTable objectForKey:@"wildcard"]) {
            ObservationStruct *observation = [center.namelessTable objectForKey:@"wildcard"];
            [observerArray addObject:observation];
            while (observation.next) {
                observation = observation.next;
                [observerArray addObject:observation];
            }
        }
    }
    
    
    
    NSLog(@"");
    
    
    for (ObservationStruct *info in observerArray) {
        [info.observer performSelector:info.selector withObject:notification];
    }
    
    
   
}








@end
