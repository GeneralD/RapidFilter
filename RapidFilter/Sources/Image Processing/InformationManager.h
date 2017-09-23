/*
 * Created by Yumenosuke Koukata on 10/25/14.
 * Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface InformationManager : NSObject
@property(nonatomic, strong) UIImage *image;

+ (instancetype)sharedInstance;
@end
