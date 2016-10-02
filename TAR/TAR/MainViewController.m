//
//  MainViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 4/5/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@interface MainViewController()//<BaiduMobAdViewDelegate>

@end

@implementation MainViewController

@synthesize appDelegate;

UIActivityIndicatorView* mainSpinner;
UITextField *accessCodeTextField;
//GADBannerView  *bannerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
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
    
    CGFloat height;
    if (screenRect.size.height <= 400) {
        height = 32.0;
    }
    else if(screenRect.size.height > 720){
        height = 90.0;
    }
    else{
        height = 50.0;
    }
    
    //sign out button
//    UIButton *signoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [signoutButton setTitle:@"sign out" forState:UIControlStateNormal];
//    [signoutButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [signoutButton setFrame:CGRectMake(screenRect.size.width - screenRect.size.width*0.21, screenRect.size.height - screenRect.size.width*0.05 - height, screenRect.size.width*0.21, screenRect.size.width*0.05)];
//    [signoutButton addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
//    [signoutButton setTitleColor:AvailableColor forState:UIControlStateNormal];
//    [self.view addSubview:signoutButton];
    
    // admob advertisement
    //        GADBannerView  *bannerview = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:CGPointMake(0, screenRect.size.height - height)];
    //    bannerview.adUnitID = @"ca-app-pub-4823300671805719/3134098385";
    //    bannerview.rootViewController = self;
    //    GADRequest *request = [[GADRequest alloc] init];
    //    request.testDevices = @[ @"b58a64b5fb68d1edd21ac7fc32a335fc" ];
    //    //[bannerview loadRequest:request];
    //    [bannerview loadRequest:[GADRequest request]];
    //    [self.view addSubview:bannerview];
    
    // baidu ad
//    BaiduMobAdView *sharedAdView = [[BaiduMobAdView alloc] init];
//    //把在mssp.baidu.com上创建后获得的代码位id写到这里
//    sharedAdView.AdUnitTag = @"2832247";
//    sharedAdView.AdType = BaiduMobAdViewTypeBanner;
//    sharedAdView.frame = CGRectMake(0, screenRect.size.height - height, screenRect.size.width, height);
//    sharedAdView.delegate = self;
//    [self.view addSubview:sharedAdView];
//    [sharedAdView start];
}

//- (NSString *)publisherId {
//    return @" f25e093b";
//}
//
//-(NSString*) userCity{
//    return @"北京";
//}

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
        [[WDGAuth auth] signInWithEmail:[defaults objectForKey:@"account"] password:[defaults objectForKey:@"password"] completion:^(WDGUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            [mainSpinner stopAnimating];
            NSString *errorMessage = [error localizedDescription];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:alertaction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            appDelegate.uid = user.uid;
            NSLog(@"%@", appDelegate.uid);
            appDelegate.email = [defaults objectForKey:@"account"];
            appDelegate.name = [defaults objectForKey:@"name"];
            if(appDelegate.name == nil || [appDelegate.name isEqualToString:@""]){
                WDGSyncReference *checkIfIsTutor = [[WDGSync sync] referenceWithPath:@"/users"];
                [checkIfIsTutor observeSingleEventOfType:WDGDataEventTypeValue withBlock:^(WDGDataSnapshot *snapshot) {
                    NSDictionary *allUsers = snapshot.value;
                    NSLog(@"%@", allUsers);
                    if([mainSpinner isAnimating]){
                        [mainSpinner stopAnimating];
                    }
                    if([allUsers objectForKey:user.uid]!=nil){
                        allUsers = [allUsers objectForKey:user.uid];
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
            WDGSyncReference *observer = [[WDGSync sync] reference];
            [observer observeSingleEventOfType:WDGDataEventTypeValue withBlock:^(WDGDataSnapshot *snapshot) {
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
                    WDGSyncReference *signin = [[WDGSync sync] referenceWithPath:[NSString stringWithFormat:@"/classes/%@/%@", date_String, accessString]];
                    [signin observeSingleEventOfType:WDGDataEventTypeValue withBlock:^(WDGDataSnapshot *snapshot) {
                        NSMutableDictionary* data = snapshot.value;
                        NSMutableDictionary* students = data[@"students"];
                        NSString* uid = appDelegate.uid;
                        if(students == nil){
                            if (uid != nil && ![uid isEqualToString:@""]) {
                                students = (NSMutableDictionary *)@{uid : @{@"email" : appDelegate.email,
                                                                            @"name" : appDelegate.name,
                                                                            @"startbattery" : [NSString stringWithFormat:@"%@", battery],
                                                                            @"starttime" : time_string}};
                                NSDictionary *newStudent = @{@"students" : students};
                                [signin updateChildValues:newStudent];
                            }
                            else{
                                NSLog(@"error occuered, null uid read");
                            }
                        }
                        else{
                            if (uid != nil && ![uid isEqualToString:@""]) {
                                [students setObject:@{@"email" : appDelegate.email,
                                                  @"name" : appDelegate.name,
                                                 @"startbattery" : [NSString stringWithFormat:@"%@", battery],
                                                  @"starttime" : time_string} forKey:uid];
                                NSDictionary *newStudent = @{@"students" : students};
                                [signin updateChildValues:newStudent];
                            }
                            else{
                                NSLog(@"error occuered, null uid read");
                            }
                        }
                        appDelegate.surveyRef = [[WDGSync sync] referenceWithPath:[NSString stringWithFormat:@"/classes/%@/%@/students", date_String, accessString]];
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

- (void)signOut:(UIButton *)button{
    [[WDGAuth auth] signOut:nil];
    UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self presentViewController:viewcontroller animated:YES completion:nil];
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
