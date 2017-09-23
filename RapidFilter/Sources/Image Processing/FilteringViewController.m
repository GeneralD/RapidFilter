/*
 * Created by Yumenosuke Koukata on 10/25/14.
 * Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
 */

#import <GPUImage/GPUImage.h>
#import <iCarousel/iCarousel.h>
#import <Overline/UIView+OVPositioning.h>
#import <NYXImagesKit/UIImage+Resizing.h>
#import "FilteringViewController.h"
#import "GPUImageOutput+RapidFilter.h"
#import "InformationManager.h"
#import "UIAlertView+BlocksKit.h"

@interface FilteringViewController () <iCarouselDelegate, iCarouselDataSource>
@end

@implementation FilteringViewController {
	__weak IBOutlet UIImageView *imageView;
	__weak IBOutlet iCarousel *carousel;
	NSArray *filters;
	UIImage *thumb;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	// prepare filters
	NSMutableArray *array = [NSMutableArray new];
	{
		GPUImageColorInvertFilter *filter = [GPUImageColorInvertFilter new];
		[array addObject:filter];
	}
	{
		GPUImagePrewittEdgeDetectionFilter *filter = [GPUImagePrewittEdgeDetectionFilter new];
		[array addObject:filter];
	}
	{
		GPUImageFalseColorFilter *filter = [GPUImageFalseColorFilter new];
		[array addObject:filter];
	}
	{
		GPUImageSmoothToonFilter *filter = [GPUImageSmoothToonFilter new];
		[array addObject:filter];
	}
	{
		GPUImageStretchDistortionFilter *filter = [GPUImageStretchDistortionFilter new];
		[array addObject:filter];
	}
	{
		GPUImageErosionFilter *filter = [GPUImageErosionFilter new];
		[array addObject:filter];
	}
	{
		GPUImageEmbossFilter *filter = [GPUImageEmbossFilter new];
		[array addObject:filter];
	}
	{
		GPUImageDilationFilter *filter = [GPUImageDilationFilter new];
		[array addObject:filter];
	}
	{
		GPUImagePolkaDotFilter *filter = [GPUImagePolkaDotFilter new];
		[array addObject:filter];
	}
	{
		GPUImagePosterizeFilter *filter = [GPUImagePosterizeFilter new];
		[array addObject:filter];
	}
	{
		GPUImageSwirlFilter *filter = [GPUImageSwirlFilter new];
		filter.angle = .5f;
		[array addObject:filter];
	}
	filters = [NSArray arrayWithArray:array];

	// set preview image
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	InformationManager *manager = [InformationManager sharedInstance];
	imageView.image = manager.image;

	// prepare thumbnail
	UIImage *image = [InformationManager sharedInstance].image;
	thumb = [image scaleByFactor:carousel.height / image.size.height * (1.f / 1.15f)];

	// setup carousel
	carousel.type = iCarouselTypeLinear;
	carousel.delegate = self;
	carousel.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark - iCarousel Delegate Methods

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	GPUImageFilter *filter = filters[index];
	UIImage *image = [filter imageByFilteringImage:thumb orientation:UIImageOrientationUp];
	UIImageView *imageView = view;

	if (imageView) { // recycle
		imageView.image = image;
	} else { // create new
		imageView = [[UIImageView alloc] initWithImage:image];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
	}

	return imageView;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
	switch (option) {
		case iCarouselOptionWrap:
			value = YES;
			break;
		case iCarouselOptionSpacing:
			value *= 1.15f;
			break;
	}
	return value;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
	NSInteger idx = carousel.currentItemIndex;
	GPUImageFilter *filter = filters[idx];
	InformationManager *manager = [InformationManager sharedInstance];
	imageView.image = [filter imageByFilteringImage:manager.image orientation:UIImageOrientationUp];
}

#pragma mark - IBActions

- (IBAction)backTapped:(id)sender {
	[UIAlertView bk_showAlertViewWithTitle:@"Really Exit?"
								   message:@"Your change will be lost if you don’t save it."
						 cancelButtonTitle:@"Cancel"
						 otherButtonTitles:@[@"OK"]
								   handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
									   switch (buttonIndex) {
										   case 1:
											   [self dismissViewControllerAnimated:YES completion:nil];
											   break;
									   }
								   }];
}

- (IBAction)saveTapped:(id)sender {
	// TODO save
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
	return filters.count;
}

@end
