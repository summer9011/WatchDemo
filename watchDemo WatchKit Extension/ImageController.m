//
//  ImageController.m
//  watchDemo
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import "ImageController.h"

@interface ImageController ()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *img;

@end

@implementation ImageController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)slider {
//    [self.img startAnimatingWithImagesInRange:NSMakeRange(5, 5) duration:0 repeatCount:0];
//    [self.img stopAnimating];
}

@end



