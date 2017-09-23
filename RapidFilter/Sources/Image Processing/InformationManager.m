/*
 * Created by Yumenosuke Koukata on 10/25/14.
 * Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
 */

#import "InformationManager.h"

@implementation InformationManager {}

+ (instancetype)sharedInstance {
	static id sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{sharedInstance = [self new];});
	return sharedInstance;
}

@end
