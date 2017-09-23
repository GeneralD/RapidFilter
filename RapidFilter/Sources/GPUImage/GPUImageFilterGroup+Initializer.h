/*
 * Created by Yumenosuke Koukata on 2/11/14.
 * Copyright (c) 2014 ZYXW. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "GPUImageFilterGroup.h"

@interface GPUImageFilterGroup (Initializer)
+ (id)initWithFilters:(NSArray *)filters;

+ (id)initWithFilter:(GPUImageOutput *)filter;
@end
