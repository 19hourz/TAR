//
//  SignUpViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 4/5/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignUpViewController.h"
@interface SignUpViewController()

@end

@implementation SignUpViewController

@synthesize appDelegate;

UITextField *nameTextField;
UITextField *emailTextField;
UITextField *passwordTextField;
UITextField *confirmPasswordTextField;
UIActivityIndicatorView* spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //add name text field
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.3, screenRect.size.width*0.7, 31)];
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.placeholder = @" Name";
    nameTextField.delegate = self;
    [nameTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [nameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:nameTextField];
    
    //add line below name textfield
    UIBezierPath *path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.3 + 31)];
    [path0 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.3 + 31)];
    CAShapeLayer *shapeLayer0 = [CAShapeLayer layer];
    shapeLayer0.path = [path0 CGPath];
    shapeLayer0.strokeColor = [[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] CGColor];
    shapeLayer0.lineWidth = 2.0;
    shapeLayer0.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer0];
    
    //add email text field
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.4, screenRect.size.width*0.7, 31)];
    emailTextField.borderStyle = UITextBorderStyleNone;
    emailTextField.placeholder = @" Email";
    emailTextField.delegate = self;
    [emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];

    [self.view addSubview:emailTextField];
    
    //add line below email textfield
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.4 + 31)];
    [path1 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.4 + 31)];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] CGColor];
    shapeLayer1.lineWidth = 2.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer1];
    
    //add password text field
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.5, screenRect.size.width*0.7, 31)];
    [passwordTextField setSecureTextEntry:YES];
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.placeholder = @" Password";
    passwordTextField.delegate = self;
    [self.view addSubview:passwordTextField];
    
    //add line below email textfield
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.5 + 31)];
    [path2 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.5 + 31)];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = [path2 CGPath];
    shapeLayer2.strokeColor = [[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] CGColor];
    shapeLayer2.lineWidth = 2.0;
    shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer2];
    
    //add password text field
    confirmPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.6, screenRect.size.width*0.7, 31)];
    [confirmPasswordTextField setSecureTextEntry:YES];
    confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
    confirmPasswordTextField.placeholder = @" Confirm password";
    confirmPasswordTextField.delegate = self;
    [self.view addSubview:confirmPasswordTextField];
    
    //add line below email textfield
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.6 + 31)];
    [path3 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.6 + 31)];
    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.path = [path3 CGPath];
    shapeLayer3.strokeColor = [[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] CGColor];
    shapeLayer3.lineWidth = 2.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer3];
    
    //add sign up button
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signInButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.65 + 35, screenRect.size.width*0.6, 50);
    [signInButton setBackgroundColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1]];
    signInButton.tag = 1;
    [signInButton setTitle:@"Sign Up  " forState:UIControlStateNormal];
    [signInButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [signInButton setTitleColor:[UIColor colorWithRed:229.0/255.0 green:247.0/255.0 blue:248.0/255.0 alpha:1] forState:UIControlStateNormal];
    signInButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    signInButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [signInButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    //add back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(screenRect.size.width*0.20, screenRect.size.height*0.75 + 50, screenRect.size.width*0.6, 50);
    [backButton setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:247.0/255.0 blue:248.0/255.0 alpha:1]];
    backButton.tag = 2;
    [backButton setTitle:@"Back  " forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [backButton setTitleColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [backButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //add a spinner
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:CGPointMake(screenRect.size.width/2,  screenRect.size.height*0.625 + 30)];
    [self.view addSubview:spinner];
}

- (void)didTapButton:(UIButton *)button
{
    if(button.tag == 2){
        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        [self presentViewController:viewcontroller animated:YES completion:nil];
    }
    else if(button.tag == 1){
        //sign up
        if(![passwordTextField.text isEqualToString:confirmPasswordTextField.text]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Different passwords" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            passwordTextField.text = @"";
            confirmPasswordTextField.text = @"";
            return;
        }
        else if([nameTextField.text isEqualToString:@""]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a name" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        else{
            [spinner startAnimating];
            [[WDGAuth auth] createUserWithEmail:emailTextField.text password:passwordTextField.text completion:^(WDGUser * _Nullable user, NSError * _Nullable error) {
                if (error) {
                    [spinner stopAnimating];
                    NSString *errorMessage = [error localizedDescription];
                    if ([error code] == 0) {
                        errorMessage = @"Your password is too easy";
                    }
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:appDelegate.defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:emailTextField.text forKey:@"account"];
                    [defaults setObject:nameTextField.text forKey:@"name"];
                    [defaults setObject:passwordTextField.text forKey:@"password"];
                    [defaults setObject:@"False" forKey:@"signOut"];
                    [defaults synchronize];
                    appDelegate.uid = user.uid;
                    [[WDGAuth auth] signInWithEmail:emailTextField.text password:passwordTextField.text completion:^(WDGUser * _Nullable user, NSError * _Nullable error) {
                        NSDictionary *user_info = @{
                                                    @"email" : emailTextField.text,
                                                    @"id" : @"student",
                                                    @"name" : nameTextField.text
                                                    };
                        WDGSyncReference *userInfo = [[WDGSync sync] referenceWithPath:@"/users"];
                        [[userInfo childByAutoId] setValue:user_info];
                    }];
                    appDelegate.email = emailTextField.text;
                    appDelegate.name = nameTextField.text;
                    NSLog(@"user should have signed up");
                    [spinner stopAnimating];
                    UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                    [self presentViewController:viewcontroller animated:YES completion:nil];
                }
            }];
        }
        //sign up end here
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
