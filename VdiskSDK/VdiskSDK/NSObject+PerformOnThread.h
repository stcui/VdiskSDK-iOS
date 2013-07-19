//
//  NSObject+PerformOnThread.h
//  VdiskSDK
//
//  Created by stcui on 13-7-19.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformOnThread)
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr waitUntilDone:(BOOL)wait withObjects:(id)arg, ...; 
@end
