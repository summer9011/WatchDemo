//
//  AppDelegate.h
//  watchDemo
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) BOOL isOpen;

- (void)localNotify:(NSString *)title body:(NSString *)body;

@end

