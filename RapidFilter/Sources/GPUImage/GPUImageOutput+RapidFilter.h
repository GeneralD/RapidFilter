/*
 * Created by Yumenosuke Koukata on 5/24/14.
 * Copyright (c) 2014 ZYXW. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "GPUImageFilter.h"

typedef void (^ConfigBlock)(id filter);

@interface GPUImageOutput (RapidFilter)
+ (UIImage *)imageByFilteringImage:(UIImage *)src orientation:(UIImageOrientation)orientation configFilterBlock:(ConfigBlock)config;

- (UIImage *)imageByFilteringImage:(UIImage *)src orientation:(UIImageOrientation)orientation;
@end
