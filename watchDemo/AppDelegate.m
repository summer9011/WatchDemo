//
//  AppDelegate.m
//  watchDemo
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import "AppDelegate.h"
#import <MapKit/MapKit.h>

#define BEACONUUID @"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"
#define BEACONMAJOR 10001
#define BEACONMINOR 13934

@interface AppDelegate () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.isOpen = YES;
    
    self.lng = 121.56;
    self.lat = 29.86;
    
    //注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //注册iBeacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:BEACONUUID];
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:BEACONMAJOR minor:BEACONMINOR identifier:@"com.tripbe.watch"];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    
    //注册CLLocationManager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply {
    
    if ([userInfo[@"type"] isEqualToString:@"open"]) {
        NSString *key = userInfo[@"id"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"open" object:nil userInfo:@{@"id":key}];
        
        reply(@{@"error":@"0"});
    } else {
        self.lng+=0.01;
        self.lat-=0.01;
        
        reply(@{@"lng":[NSNumber numberWithDouble:self.lng], @"lat":[NSNumber numberWithDouble:self.lat]});
    }
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你好" message:notification.alertBody delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

//发送本地通知
- (void)localNotify:(NSString *)title body:(NSString *)body {
    UILocalNotification *localNotify = [[UILocalNotification alloc] init];
    localNotify.alertTitle = title;
    localNotify.alertBody = body;
    localNotify.alertAction = @"firstButtonAction";
    localNotify.userInfo = @{@"lng":@121.56, @"lat":@29.86};
    localNotify.category = @"myCategory";
    localNotify.soundName = UILocalNotificationDefaultSoundName;
    localNotify.regionTriggersOnce = NO;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotify];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"didEnterRegion");
    
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"didExitRegion");
    
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    for (CLBeacon *beacon in beacons) {
        if ([beacon.proximityUUID.UUIDString isEqualToString:BEACONUUID]) {
            if ([beacon.major longValue] == BEACONMAJOR && [beacon.minor longValue] == BEACONMINOR) {
                
                if (self.isOpen) {
                    [self localNotify:@"宁波" body:@"书藏古今，港通天下"];
                    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
                }
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    [self localNotify:[NSString stringWithFormat:@"错误 %@", [error localizedDescription]] body:@""];
}

@end
