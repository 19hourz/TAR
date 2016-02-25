//
//  ChangePasswordViewController.h
//  TAR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#ifndef ChangePasswordViewController_h
#define ChangePasswordViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface  ChangePasswordViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *OldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *NewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *UpdateButton;
- (IBAction)updateNewPassword:(id)sender;
@end

#endif /* ChangePasswordViewController_h */
