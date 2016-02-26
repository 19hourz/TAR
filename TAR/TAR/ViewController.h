//
//  ViewController.h
//  TAR
//
//  Created by Jiasheng Zhu on 2/20/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *batteryLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryStateLabel;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)SignIn:(id)sender;

@end

