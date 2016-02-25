//
//  ViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 2/20/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

@synthesize batteryLevelLabel, batteryStateLabel, appDelegate;

- (void)batteryLevelChanged:(NSNotification *)notification
{
    float batteryLevel = [UIDevice currentDevice].batteryLevel;
    if (batteryLevel < 0.0) {
        // -1.0 means battery state is UIDeviceBatteryStateUnknown
        self.batteryLevelLabel.text = NSLocalizedString(@"Unknown", @"");
        NSLog(@"Battery level: Unknwon");
    }
    else {
        static NSNumberFormatter *numberFormatter = nil;
        if (numberFormatter == nil) {
            numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
            [numberFormatter setMaximumFractionDigits:1];
        }
    
        NSNumber *levelObj = [NSNumber numberWithFloat:batteryLevel];
        self.batteryLevelLabel.text = [numberFormatter stringFromNumber:levelObj];
        NSLog(@"Battery level: %f%%", batteryLevel*100);
    }
}
- (void)batteryStateChanged:(NSNotification *)notification
{
    UIDeviceBatteryState currentState = [UIDevice currentDevice].batteryState;
    NSString* batteryState = @"";
    switch (currentState) {
        case 0:
            batteryState = @"unknow";
            break;
        case 1:
            batteryState = @"unplugged";
            break;
        case 2:
            batteryState = @"charging";
            break;
        case 3:
            batteryState = @"full";
            break;
        default:
            break;
    }
    self.batteryStateLabel.text = batteryState;
    NSLog(@"Battery state: %@", batteryState);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [self batteryLevelChanged:nil];
    [self batteryStateChanged:nil];
    // Register for battery level and state change notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryLevelChanged:)
                                                 name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryStateChanged:)
                                                 name:UIDeviceBatteryStateDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end