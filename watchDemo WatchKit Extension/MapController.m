//
//  MapController.m
//  watchDemo
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import "MapController.h"

@interface MapController ()

@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MapController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self.map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(29.86, 121.56), MKCoordinateSpanMake(0.5, 0.5))];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getLocation:) userInfo:nil repeats:YES];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)getLocation:(NSTimer *)timer {
    [WKInterfaceController openParentApplication:@{@"type":@"location"} reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"watch data %@, error %@", replyInfo, [error localizedDescription]);
        
        double lng = [replyInfo[@"lng"] doubleValue];
        double lat = [replyInfo[@"lat"] doubleValue];
        
        [self.map removeAllAnnotations];
        [self.map addAnnotation:CLLocationCoordinate2DMake(lat, lng) withImageNamed:@"宁波" centerOffset:CGPointZero];
    }];
}

@end



