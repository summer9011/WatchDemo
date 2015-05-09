//
//  NotificationController.m
//  watchDemo WatchKit Extension
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()

@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    NSLog(@"%@", localNotification.userInfo);
    
    NSDictionary *userInfo = localNotification.userInfo;
    double lng = [userInfo[@"lng"] doubleValue];
    double lat = [userInfo[@"lat"] doubleValue];
    
    [self.map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lng), MKCoordinateSpanMake(0.5, 0.5))];
    [self.map addAnnotation:CLLocationCoordinate2DMake(lat, lng) withImageNamed:localNotification.alertTitle centerOffset:CGPointZero];
    
    [self.label setText:localNotification.alertBody];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}

/*
- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    NSLog(@"remoteNotification %@", remoteNotification);
    
    NSDictionary *alert = remoteNotification[@"alert"];
    NSDictionary *userInfo = remoteNotification[@"userInfo"];
    double lng = [userInfo[@"lng"] doubleValue];
    double lat = [userInfo[@"lat"] doubleValue];

    [self.map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(29.86, 121.56), MKCoordinateSpanMake(0.5, 0.5))];
    [self.map addAnnotation:CLLocationCoordinate2DMake(29.86, 121.56) withImageNamed:@"宁波" centerOffset:CGPointZero];
    
    [self.label setText:[NSString stringWithFormat:@"1111%@", remoteNotification]];
 
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}
 */

- (IBAction)goPage {
    
}

@end



