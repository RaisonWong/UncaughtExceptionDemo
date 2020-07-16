//
//  HPUncaughtExceptionHandle.m
//  异常捕获Demo
//
//  Created by 王海鹏 on 2020/7/16.
//  Copyright © 2020 王海鹏. All rights reserved.
//

#import "HPUncaughtExceptionHandle.h"
#include <sys/signal.h>

@interface HPUncaughtExceptionHandle ()
{
    int UncaughtException;
}
@end

@implementation HPUncaughtExceptionHandle
// 沙盒的地址
NSString * applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
NSString * applicationExceptionPath() {
    return [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
}
// 崩溃时的回调函数
void UncaughtException(NSException *exception) {
    
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason]; // // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = applicationExceptionPath();
    // 将一个txt文件写入沙盒
    BOOL success = [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"save crash log success: %d, path: %@", success, path);
}
void SignalHandler(int signal) {
    NSLog(@"%s", __func__);
}

+ (void)setDefaultHandle {
    NSSetUncaughtExceptionHandler(&UncaughtException);
    //添加想要监听的signal类型，当发出相应类型的signal时，会回调SignalHandler方法
    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
}

+ (NSUncaughtExceptionHandler *)getHandler {
    return NSGetUncaughtExceptionHandler();
}

+ (void)takeException:(NSException *)exception {
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason];
    NSString * name = [exception name];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)applicationDocumentsDirectory {
    return applicationDocumentsDirectory();
}
+ (NSString *)applicationExceptionPath {
    return [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
}

@end
