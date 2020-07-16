//
//  AppDelegate+Crash.m
//  异常捕获Demo
//
//  Created by 王海鹏 on 2020/7/16.
//  Copyright © 2020 王海鹏. All rights reserved.
//

#import "AppDelegate+Crash.h"
#import "HPUncaughtExceptionHandle.h"
#import <AFNetworking.h>
@implementation AppDelegate (Crash)

- (void)initUncaughtHandle {
    [HPUncaughtExceptionHandle setDefaultHandler];
    // 发送崩溃
    NSString *dataPath = [HPUncaughtExceptionHandle applicationExceptionPath];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    if (data != nil) {
        [self sendExceptionLogWithData:data path:dataPath];
    }
}

#pragma mark -- 发送崩溃日志
- (void)sendExceptionLogWithData:(NSData *)data path:(NSString *)path {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0f;
    //告诉AFN，支持接受 text/xml 的数据
    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *urlString = @"后台地址";
    
    
    [manager POST:urlString parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"Exception.txt" mimeType:@"txt"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 删除文件
        NSFileManager *fileManger = [NSFileManager defaultManager];
        [fileManger removeItemAtPath:path error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
