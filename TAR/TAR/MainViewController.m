//
//  MainViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 4/5/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@import iAd;
@interface MainViewController()

@end

@implementation MainViewController

@synthesize appDelegate;

UIActivityIndicatorView* mainSpinner;
UITextField *accessCodeTextField;
ADBannerView *bannerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //add iad
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        [bannerView setFrame:CGRectMake(screenRect.size.width*0, screenRect.size.height - bannerView.frame.size.height, screenRect.size.width, bannerView.frame.size.height)];
    }
    else {
        bannerView = [[ADBannerView alloc] init];
    }
    [self.view addSubview:bannerView];
    
    //add a spinner
    mainSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [mainSpinner setCenter:CGPointMake(screenRect.size.width/2,  screenRect.size.height*0.47)];
    [self.view addSubview:mainSpinner];

    
    //add access code text field
    accessCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.3, screenRect.size.width*0.7, 31)];
    accessCodeTextField.borderStyle = UITextBorderStyleNone;
    accessCodeTextField.placeholder = @" Enter access code here";
    accessCodeTextField.delegate = self;
    [accessCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:accessCodeTextField];
    
    //add line below email textfield
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(screenRect.size.width*0.15, screenRect.size.height*0.3 + 31)];
    [path1 addLineToPoint:CGPointMake(screenRect.size.width*0.85, screenRect.size.height*0.3 + 31)];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] CGColor];
    shapeLayer1.lineWidth = 2.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer1];
    
    //add a button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 1;
    [button setTitle:@"Join Class" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button setTitleColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(screenRect.size.width*0.3, screenRect.size.height*0.5, screenRect.size.width*0.4, screenRect.size.width*0.4);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = screenRect.size.width*0.4/2.0f;
    button.layer.borderColor=[UIColor redColor].CGColor;
    button.layer.borderWidth=2.0f;
    [self.view addSubview:button];
    }

-(void)viewDidAppear:(BOOL)animated{
    //get user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    //attemp to sign in if not yet sign in
    //if (YES) {
        NSLog(@"empty");
        [mainSpinner startAnimating];
        UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
            [self presentViewController:viewcontroller animated:YES completion:nil];
        }];
        [appDelegate.firebase authUser:[defaults objectForKey:@"account"] password:[defaults objectForKey:@"password"] withCompletionBlock:^(NSError *error, FAuthData *authData) {
            if (error) {
                [mainSpinner stopAnimating];
                NSString *errorMessage = [error localizedDescription];
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:alertaction];
                [self presentViewController:alert animated:YES completion:nil];
                
            } else {
                appDelegate.uid = authData.uid;
                NSLog(@"%@", appDelegate.uid);
                appDelegate.email = [defaults objectForKey:@"account"];
                appDelegate.name = [defaults objectForKey:@"name"];
                if(appDelegate.name == nil || [appDelegate.name isEqualToString:@""]){
                    Firebase* checkIfIsTutor = [[Firebase alloc] initWithUrl:@"https://taruibe.firebaseio.com"];
                    checkIfIsTutor = [checkIfIsTutor childByAppendingPath:@"users"];
                    [checkIfIsTutor observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                        NSDictionary *allUsers = snapshot.value;
                        NSLog(@"%@", allUsers);
                        if([mainSpinner isAnimating]){
                            [mainSpinner stopAnimating];
                        }
                        if([allUsers objectForKey:authData.uid]!=nil){
                            allUsers = [allUsers objectForKey:checkIfIsTutor.authData.uid];
                            NSLog(@"%@", allUsers);
                        }
                        if(allUsers[@"name"] != nil && ![allUsers[@"name"] isEqualToString:@""]){
                            appDelegate.name = allUsers[@"name"];
                            [defaults setObject:allUsers[@"name"] forKey:@"name"];
                        }
                        else{
                            UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
                                [self presentViewController:viewcontroller animated:YES completion:nil];
                            }];
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry, your identity can not be verified" preferredStyle:UIAlertControllerStyleAlert];
                            [alert addAction:alertaction];
                            [self presentViewController:alert animated:YES completion:nil];
                        }
                        
                    }];
                }
                NSString* viewcontrollerToPresent = [defaults objectForKey:@"initialViewController"];
                if (viewcontrollerToPresent == nil || [viewcontrollerToPresent isEqualToString:@""]) {
                    viewcontrollerToPresent = @"MainViewController";
                }
                if([mainSpinner isAnimating]){
                    [mainSpinner stopAnimating];
                }
                if([viewcontrollerToPresent isEqualToString:@"SurveyViewController"]){
                    UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:viewcontrollerToPresent];
                    [self presentViewController:viewcontroller animated:YES completion:nil];
                }
                NSLog(@"user should have signed in");
            }
        }];
    //}
}

- (void)didTapButton:(UIButton *)button{
    if([mainSpinner isAnimating]){
        return;
    }
    else if(button.tag == 1){
        NSUInteger accessCode = [accessCodeTextField.text intValue];
        NSString* accessString = accessCodeTextField.text;
        if([accessString isEqualToString:@""]){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ops..." message:@"Please enter a code" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if(accessCode < 10000 || accessCode > 99999){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ops..." message:@"Code is in unexpected format\nPlease enter a Wu Wei Shu" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:appDelegate.defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            [mainSpinner startAnimating];
            [UIDevice currentDevice].batteryMonitoringEnabled = YES;
            float batteryLevel = [UIDevice currentDevice].batteryLevel;
            __block NSNumber* battery;
            if (batteryLevel < 0.0) {
                batteryLevel = 0.0;
            }
            battery = [NSNumber numberWithFloat:batteryLevel];
            Firebase *oberser = appDelegate.firebase;
            [oberser childByAppendingPath:@"classes"];
        
            [oberser observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
            [dateformate setDateFormat:@"dd-MM-YYYY"];
            NSString *date_String=[dateformate stringFromDate:[NSDate date]];
            [dateformate setDateFormat:@"dd-MM-HH-mm-ss"];
            NSString *time_string = [dateformate stringFromDate:[NSDate date]];
            NSMutableDictionary *allDates = snapshot.value[@"classes"];
            if(allDates[date_String] == nil){
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ops..." message:@"There seems to be some problem\nNo class is found" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:appDelegate.defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else{
                NSMutableDictionary *allClasses = allDates[date_String];
                if(allClasses[accessString] == nil){
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ops..." message:@"There seems to be some problem\nNo class is found" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:appDelegate.defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else{
                    Firebase *signin = [[Firebase alloc] initWithUrl:@"https://taruibe.firebaseio.com/classes"];
                    signin = [signin childByAppendingPath:date_String];
                    signin = [signin childByAppendingPath:accessString];
                    [signin observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                        NSMutableDictionary* data = snapshot.value;
                        NSMutableDictionary* students = data[@"students"];
                        if(students == nil){
                            students = (NSMutableDictionary *)@{signin.authData.uid : @{@"email" : appDelegate.email,
                                                                                        @"name" : appDelegate.name,
                                                                                        @"startbattery" : [NSString stringWithFormat:@"%@", battery],
                                                                                        @"starttime" : time_string}};
                            NSDictionary *newStudent = @{@"students" : students};
                            [signin updateChildValues:newStudent];
                        }
                        else{
                            [students setObject:@{@"email" : appDelegate.email,
                                                  @"name" : appDelegate.name,
                                                 @"startbattery" : [NSString stringWithFormat:@"%@", battery],
                                                  @"starttime" : time_string} forKey:signin.authData.uid];
                            NSDictionary *newStudent = @{@"students" : students};
                            [signin updateChildValues:newStudent];
                        }
                        appDelegate.surveyURL = [[Firebase alloc] initWithUrl:@"https://taruibe.firebaseio.com"];
                        appDelegate.surveyURL = [[[[[appDelegate.surveyURL  childByAppendingPath:@"classes"] childByAppendingPath:date_String] childByAppendingPath:accessString] childByAppendingPath:@"students"] childByAppendingPath:signin.authData.uid];
                        UIAlertAction* alertaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"CurrentClassViewController"];
                                [self presentViewController:viewcontroller animated:YES completion:nil];
                        }];
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Yeah..." message:@"Class Found\nYou have signed in" preferredStyle:UIAlertControllerStyleAlert];
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:@"SurveyViewController" forKey:@"initialViewController"];
                        [defaults setObject:date_String forKey:@"lostdate"];
                        [defaults setObject:accessString forKey:@"lostaccesscode"];
                        [defaults synchronize];
                        [alert addAction:alertaction];
                        [self presentViewController:alert animated:YES completion:nil];
                    }];
                }
            }
            [mainSpinner stopAnimating];
            }];
            }
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