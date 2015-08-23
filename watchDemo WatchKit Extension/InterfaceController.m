//
//  InterfaceController.m
//  watchDemo WatchKit Extension
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    NSLog(@"awakeWithContext");
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSLog(@"willActivate");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
    NSLog(@"didDeactivate");
}

- (IBAction)openView {
    NSDictionary *dic = @{@"type":@"open", @"id":@"a"};
    
    [WKInterfaceController openParentApplication:dic reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@, error %@", replyInfo, error);
    }];
}

@end



