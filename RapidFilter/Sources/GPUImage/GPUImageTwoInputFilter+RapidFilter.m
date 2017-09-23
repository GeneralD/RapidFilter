/*
 * Created by Yumenosuke Koukata on 5/26/14.
 * Copyright (c) 2014 ZYXW. All rights reserved.
 */

#import "GPUImageTwoInputFilter+RapidFilter.h"
#import "GPUImagePicture.h"

@implementation GPUImageTwoInputFilter (RapidFilter)

+ (UIImage *)imageByFilteringImages:(UIImage *)img1 and:(UIImage *)img2 orientation:(UIImageOrientation)orientation configFilter:(ConfigBlock)config {
	id filter = [self new];
	if (config) config(filter);
	[filter useNextFrameForImageCapture];
	if (img1 && img2)
		for (UIImage *image in @[img1, img2]) {
			GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
			[picture addTarget:filter];
			[picture processImage];
		}
	return [filter imageFromCurrentFramebufferWithOrientation:orientation];
}

- (UIImage *)imageByFilteringImages:(UIImage *)img1 and:(UIImage *)img2 orientation:(UIImageOrientation)orientation {
	[self useNextFrameForImageCapture];
	if (img1 && img2)
		for (UIImage *image in @[img1, img2]) {
			GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
			[picture addTarget:self];
			[picture processImage];
		}
	return [self imageFromCurrentFramebufferWithOrientation:orientation];
}

@end
