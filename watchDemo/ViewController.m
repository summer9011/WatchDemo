//
//  ViewController.m
//  watchDemo
//
//  Created by 赵立波 on 15/5/8.
//  Copyright (c) 2015年 赵立波. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"

#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelAViewController:) name:@"open" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)controlState:(id)sender {
    NSLog(@"%d", [self.switchControl isOn]);
    
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    dele.isOpen = self.switchControl.on;
}

- (void)modelAViewController:(NSNotification *)notify {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondController *second = (SecondController *)[board instantiateViewControllerWithIdentifier:@"SecondVC"];
    second.key = notify.userInfo[@"id"];
    
    [self presentViewController:second animated:YES completion:^{
        NSLog(@"model");
    }];
}

@end
