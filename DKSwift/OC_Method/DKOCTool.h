//
//  DKOCTool.h
//  DKSwift
//
//  Created by 邓凯 on 2020/6/8.
//  Copyright © 2020 邓凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKOCTool : NSObject

+ (DKOCTool *)manager;

- (void)testSemaphore;

@end

NS_ASSUME_NONNULL_END
