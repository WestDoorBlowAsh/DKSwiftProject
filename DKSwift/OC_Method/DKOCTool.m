//
//  DKOCTool.m
//  DKSwift
//
//  Created by 邓凯 on 2020/6/8.
//  Copyright © 2020 邓凯. All rights reserved.
//

#import "DKOCTool.h"

@implementation DKOCTool

+ (DKOCTool *)manager {
    DKOCTool *tool = [[DKOCTool alloc] init];
    NSLog(@"tool init");
    return tool;
}

- (void)testSemaphore {
    NSInteger res = [self methodSync];
    NSLog(@"testSemaphore %zd", res);
}

- (NSInteger)methodSync {
    NSLog(@"methodSync 开始");
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    __block NSInteger result = 0;

    [self methodAsync:^(NSInteger value) {
        result = value;
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"methodSync 结束 result:%ld", (long)result);
    return result;
}

- (NSInteger)methodSyncGroup {
    NSLog(@"methodSync 开始");
    __block NSInteger result = 0;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);

    [self methodAsync:^(NSInteger value) {
        result = value;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"methodSync 结束 result:%ld", (long)result);
    return result;
}

// 异步方法
- (void)methodAsync:(void(^)(NSInteger value))callBack {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"methodAsync 异步开始 %@", [NSThread currentThread]);
        sleep(2);
        NSLog(@"methodAsync 异步结束");
        
        dispatch_queue_t con = dispatch_queue_create("DanCONCURRENT", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(con, ^{
            if (callBack) {
                callBack(5);
            }
        });
        
        // 这个不行
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"dispatch_get_main_queue  回到主线程");
//
//            if (callBack) {
//                callBack(5);
//            }
//        });
    });
}

@end
