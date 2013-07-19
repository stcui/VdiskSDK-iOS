//
//  NSObject+PerformOnThread.m
//  VdiskSDK
//
//  Created by stcui on 13-7-19.
//
//

#import "NSObject+PerformOnThread.h"

@implementation NSObject (PerformOnThread)
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr waitUntilDone:(BOOL)wait withObjects:(id)arg, ...;
{
    NSString *selectorName = NSStringFromSelector(aSelector);
    const char *name = [selectorName UTF8String];
    int cnt = 0;
    for (int i = 0; i < selectorName.length; ++i) {
        cnt += (name[i] == ':');
    }
    
    NSMethodSignature *sig = [self methodSignatureForSelector:aSelector];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    [inv setTarget:self];
    [inv setSelector:aSelector];
    
    va_list ap;
    va_start(ap, arg);
    [inv setArgument:&ap atIndex:2];
    for (int i = 1; i < cnt; ++i) {
        va_arg(ap, id);
        [inv setArgument:&ap atIndex:i + 2];
    }
    va_end(ap);
    [inv retainArguments];
    [inv performSelector:@selector(invoke) onThread:thr withObject:nil waitUntilDone:NO];
}
@end
