//
//  Person.m
//  TestMessageTransmit
//
//  Created by wendongsheng on 15/4/27.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "Person.h"
#import <objc/objc-class.h>
#import "Car.h"

@implementation Person

void run (id self, SEL _cmd){
    NSLog(@"%@  %s",self, sel_getName(_cmd));
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
////    if (sel == @selector(run)) {
////        class_addMethod(self,sel,(IMP)run, "v@:");
////        return YES;
////    }
//    return [super resolveInstanceMethod:sel];
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    return [[Car alloc] init];
//}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *sel = NSStringFromSelector(aSelector);
    
    //判断你要转发的sel
    if ([sel isEqualToString:@"run"]) {
        //为你转发方法手动生成签名
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    
    //新建需要转发消息的对象
    Car *car = [[Car alloc] init];
    if ([car respondsToSelector:selector]) {
        //唤醒方法
        [anInvocation invokeWithTarget:car];
    }
}


@end
