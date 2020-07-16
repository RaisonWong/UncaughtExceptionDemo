//
//  HPUncaughtExceptionHandle.h
//  异常捕获Demo
//
//  Created by 王海鹏 on 2020/7/16.
//  Copyright © 2020 王海鹏. All rights reserved.
//

#import <Foundation/Foundation.h>




NS_ASSUME_NONNULL_BEGIN

@interface HPUncaughtExceptionHandle : NSObject
+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;
+ (void)takeException:(NSException *) exception;
+ (NSString *)applicationDocumentsDirectory ;
+ (NSString *)applicationExceptionPath ;
@end

NS_ASSUME_NONNULL_END
