//
//  SignUpViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignUpViewController.h"
@interface SignUpViewController ()

@end


@implementation SignUpViewController
@synthesize appDelegate, SignUpButton, SignUpEmailTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)signUp:(UIButton *)sender{
    if ([self isValidEmail:SignUpEmailTextField.text]) {
        [appDelegate.firebase createUser:self.SignUpEmailTextField.text password:@"vqwruiqgfiurtwiortqiwetrirtiwetiqwcqtyygirctyebceg" withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
            if (error) {
                NSString *errorMessage = [error localizedDescription];
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:appDelegate.defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                appDelegate.uid = result[@"uid"];
                appDelegate.name = @"unnamed";
                appDelegate.email = SignUpEmailTextField.text;
                NSDictionary *user_info = @{
                                            @"name" : appDelegate.name,
                                            @"email" : SignUpEmailTextField.text,
                                            @"verified" : @"no"
                                            };
                NSDictionary *new_user = @{appDelegate.uid : user_info};
                [appDelegate.user_ref updateChildValues:new_user];
                NSLog(@"user should have signed up");
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You have signed up!" message:@"An temporary email will be sent to you, be sure to check your spam, your email is not verified until you have changed your password" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    UIViewController *viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordView"];
                    [self presentViewController:viewcontroller animated:YES completion:nil];
                }];
                [alert addAction:alertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [appDelegate.firebase resetPasswordForUser:SignUpEmailTextField.text withCompletionBlock:^(NSError *error) {
                    if (error) {
                        NSLog(@"error when resetting password");
                    } else {
                        NSLog(@"succeed sending resetting password");
                    }
                }];
            }
        }];
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Email entered is invalid" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:appDelegate.defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
}

- (bool) isValidEmail: (NSString *) email{
    if([email isEqualToString:@""]){
        return NO;
    }
    else if([email rangeOfString:@"@"].location == NSNotFound){
        return NO;
    }
    else{
        return YES;
    }
}


@end