/*
 * Created by Yumenosuke Koukata on 5/26/14.
 * Copyright (c) 2014 ZYXW. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "GPUImageTwoInputFilter.h"

typedef void (^ConfigBlock)(id filter);

@interface GPUImageTwoInputFilter (RapidFilter)
+ (UIImage *)imageByFilteringImages:(UIImage *)img1 and:(UIImage *)img2 orientation:(UIImageOrientation)orientation configFilter:(ConfigBlock)config;

- (UIImage *)imageByFilteringImages:(UIImage *)img1 and:(UIImage *)img2 orientation:(UIImageOrientation)orientation;
@end
