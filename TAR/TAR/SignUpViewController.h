//
//  SignUpViewController.h
//  TAR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#ifndef SignUpViewController_h
#define SignUpViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SignUpViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIButton *SignUpButton;
@property (weak, nonatomic) IBOutlet UITextField *SignUpEmailTextField;


- (IBAction)signUp:(UIButton *)sender;
- (bool) isValidEmail: (NSString *) email;
@end

#endif /* SignUpViewController_h */
