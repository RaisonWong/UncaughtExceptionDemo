//
//  UncaughtExceptionHandler.h
//  UncaughtExceptionDemo
//
//  Created by 王海鹏 on 2020/7/16.
//  Copyright © 2020 王海鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}
@end
void HandleException(NSException *exception);
void SignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);  
NS_ASSUME_NONNULL_END
