/*
 * Created by Yumenosuke Koukata on 5/24/14.
 * Copyright (c) 2014 ZYXW. All rights reserved.
 */

#import "GPUImageOutput+RapidFilter.h"
#import "GPUImagePicture.h"

@implementation GPUImageOutput (RapidFilter)

+ (UIImage *)imageByFilteringImage:(UIImage *)src orientation:(UIImageOrientation)orientation configFilterBlock:(ConfigBlock)config {
	id filter = [self new];
	if (config) config(filter);
	[filter useNextFrameForImageCapture];
	GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:src];
	[picture addTarget:filter];
	[picture processImage];
	return [filter imageFromCurrentFramebufferWithOrientation:orientation];
}

- (UIImage *)imageByFilteringImage:(UIImage *)src orientation:(UIImageOrientation)orientation {
	[self useNextFrameForImageCapture];
	GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:src];
	[picture addTarget:self];
	[picture processImage];
	return [self imageFromCurrentFramebufferWithOrientation:orientation];
}

@end
