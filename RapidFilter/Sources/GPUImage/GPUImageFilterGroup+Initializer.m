/*
 * Created by Yumenosuke Koukata on 2/11/14.
 * Copyright (c) 2014 ZYXW. All rights reserved.
 */

#import "GPUImageFilterGroup+Initializer.h"

@implementation GPUImageFilterGroup (Initializer)

+ (id)initWithFilters:(NSArray *)filters {
	GPUImageFilterGroup *filterGroup = [GPUImageFilterGroup new];
	GPUImageOutput *beforeFilter = nil;
	for (GPUImageOutput *filter in filters) {
		[filterGroup addTarget:filter];
		if (!beforeFilter) {
			beforeFilter = filter;
			continue;
		}
		[beforeFilter addTarget:filter];
		beforeFilter = filter;
	}
	GPUImageOutput *firstFilter = [filters firstObject];
	[filterGroup setInitialFilters:@[firstFilter]];
	GPUImageOutput *endFilter = [filters lastObject];
	[filterGroup setTerminalFilter:endFilter];
	return filterGroup;
}

+ (id)initWithFilter:(GPUImageOutput *)filter {
	return [self initWithFilters:@[filter]];
}

@end
