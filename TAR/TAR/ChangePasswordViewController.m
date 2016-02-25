//
//  ChangePasswordViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePasswordViewController.h"
@interface ChangePasswordViewController ()

@end


@implementation ChangePasswordViewController
@synthesize appDelegate, OldPasswordTextField, NewPasswordTextField, ConfirmPasswordTextField, UpdateButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)updateNewPassword:(id)sender {
    if(![NewPasswordTextField.text isEqualToString:ConfirmPasswordTextField.text]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Different passwords." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:appDelegate.defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [appDelegate.firebase changePasswordForUser:appDelegate.email fromOld:OldPasswordTextField.text
                                          toNew:NewPasswordTextField.text withCompletionBlock:^(NSError *error) {
                                              if (error) {
                                                  NSString *errorMessage = [error localizedDescription];
                                                  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                                                  [alert addAction:appDelegate.defaultAction];
                                                  [self presentViewController:alert animated:YES completion:nil];
                                              }
                                              else {
                                                  Firebase *curr_user = [appDelegate.user_ref childByAppendingPath:appDelegate.uid];
                                                  NSDictionary *user_info = @{@"verified" : @"yes"};
                                                  [curr_user updateChildValues:user_info];
                                                  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Great" message:@"Successfully change your password." preferredStyle:UIAlertControllerStyleAlert];
                                                  [alert addAction:appDelegate.defaultAction];
                                                  [self presentViewController:alert animated:YES completion:nil];
                                              }
                                          }];
}

@end