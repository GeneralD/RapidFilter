//
//  ViewController.m
//  RapidFilter
//
//  Created by Yumenosuke Koukata on 10/25/14.
//  Copyright (c) 2014 Yumenosuke Koukata. All rights reserved.
//


#import <AssetsLibrary/AssetsLibrary.h>
#import <BlocksKit/UIImagePickerController+BlocksKit.h>
#import "IndexViewController.h"
#import "InformationManager.h"

@interface IndexViewController ()

- (void)imagePickedUp:(UIImage *)image;
@end

@implementation IndexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)libraryButtonTapped:(id)sender {
	UIImagePickerController *imagePickerController = [UIImagePickerController new];
	imagePickerController.bk_didFinishPickingMediaBlock = ^(UIImagePickerController *controller, NSDictionary *dictionary) {
		[controller dismissViewControllerAnimated:NO completion:nil];
		UIImage *image = dictionary[UIImagePickerControllerOriginalImage];
		if (image) [self imagePickedUp:image];
		else { // on iPad, image is nil
			NSURL *url = dictionary[UIImagePickerControllerReferenceURL];
			[[ALAssetsLibrary new] assetForURL:url resultBlock:^(ALAsset *asset) {
				ALAssetRepresentation *representation = [asset defaultRepresentation];
				UIImage *alImage = [UIImage imageWithCGImage:[representation fullScreenImage] scale:[representation scale] orientation:UIImageOrientationUp];
				if (alImage) [self imagePickedUp:image];
				else
					DDLogError(@"Couldn't pick an image!!");
			}                     failureBlock:^(NSError *error) {
				DDLogError(@"Error: %@", [error localizedDescription]);
			}];
		}
	};
	imagePickerController.bk_didCancelBlock = ^(UIImagePickerController *controller) {
		[controller dismissViewControllerAnimated:YES completion:nil];
	};
	[self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickedUp:(UIImage *)image {
	InformationManager *manager = [InformationManager sharedInstance];
	manager.image = image;
	[self performSegueWithIdentifier:@"filter" sender:self];
}

@end
