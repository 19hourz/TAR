//
//  SurveyViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 4/14/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyViewController.h"
@interface SurveyViewController()

@end

@implementation SurveyViewController

@synthesize appDelegate;

NSUInteger current;
UIButton *nextButton;
UIButton *backButton;
UIButton *submitButton;
UITextField* textField;
NSUserDefaults* surveyAnswers;
NSMutableDictionary* uploadAnswers;
UILabel *process;
UILabel *explanation3;
CGFloat bx,by,bw,bh;
CGFloat bbx,bby,bbw,bbh;
- (void)viewDidLoad {
    [super viewDidLoad];
    current = 0;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //add a label
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.1, screenRect.size.width*0.6, 50)];
    title.text = @"Survey";
    [title setTextAlignment:NSTextAlignmentCenter];
    title.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:title];
    //add three explanations
    UILabel *explanation1 = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.1, screenRect.size.height*0.15 + 50, screenRect.size.width*0.8, 20)];
    explanation1.text = @"Please finish this survey";
    [explanation1 setTextAlignment:NSTextAlignmentCenter];
    explanation1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:explanation1];
     UILabel *explanation2 = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.15 + 75, screenRect.size.width*0.9, 20)];
    explanation2.text = @"in order to be able to sign in to next class";
    [explanation2 setTextAlignment:NSTextAlignmentCenter];
    explanation2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:explanation2];
    process = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.15 + 100, screenRect.size.width*0.9, 20)];
    process.text = [NSString stringWithFormat: @"( %lu / 2 )", (unsigned long)(current+1)];
    [process setTextAlignment:NSTextAlignmentCenter];
    process.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:process];
    explanation3 = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.1, screenRect.size.height*0.35, screenRect.size.width*0.9, screenRect.size.height*0.05)];
    explanation3.text = @"Comments for this class and tutor";//@"对本堂课以及tutor有什么意见以及建议";
    [explanation3 setTextAlignment:NSTextAlignmentLeft];
    explanation3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:explanation3];
    //add email text field
    textField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.4, screenRect.size.width*0.7, 31)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = @" comments";
    textField.delegate = self;
    [textField setKeyboardType:UIKeyboardTypeDefault];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:textField];
    
    //add a button
    nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.53, screenRect.size.width*0.6, screenRect.size.height*0.1);
    //[button setBackgroundColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1]];
    nextButton.tag = 1;
    [nextButton setTitle:@"Next  " forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    nextButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    nextButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    nextButton.layer.borderColor=[UIColor grayColor].CGColor;
    nextButton.layer.borderWidth=2.0f;
    [nextButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    //add a back button
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.65, screenRect.size.width*0.6, screenRect.size.height*0.1);
    backButton.tag = 2;
    [backButton setTitle:@"Back  " forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    backButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    backButton.layer.borderColor=[UIColor grayColor].CGColor;
    backButton.layer.borderWidth=2.0f;
    [backButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //add a submit button
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.53, screenRect.size.width*0.6, screenRect.size.height*0.1);
    //submitButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.77, screenRect.size.width*0.6, screenRect.size.height*0.1);
    submitButton.tag = 3;
    [submitButton setTitle:@"Submit  " forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [submitButton setTitleColor:AvailableColor forState:UIControlStateNormal];
    submitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    submitButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    submitButton.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    submitButton.layer.borderColor=[UIColor grayColor].CGColor;
    submitButton.layer.borderWidth=2.0f;
    [submitButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];

    
    //add a path
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(screenRect.size.width*0.10, screenRect.size.height*0.4 + 31)];
    [path1 addLineToPoint:CGPointMake(screenRect.size.width*0.9, screenRect.size.height*0.4 + 31)];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer1.lineWidth = 1.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer1];
    
    //local data
    surveyAnswers = [NSUserDefaults standardUserDefaults];
    [surveyAnswers synchronize];
    uploadAnswers = [[NSMutableDictionary alloc] initWithCapacity:7];
}

- (void)didTapButton:(UIButton *)button{
    if (explanation3.text && [explanation3.text containsString:@"out of 10"]) {
        if (button.tag == 1 || button.tag == 3) {
            if ([textField.text isEqualToString:@""]) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Put a number!" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:appDelegate.defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            else if ([textField.text integerValue] < 0 || [textField.text integerValue] > 10) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid number!" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:appDelegate.defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        }
    }
    if(button.tag == 1){
        if(current == 0){
            if ([textField.text isEqualToString:@""]) {
                int comment = arc4random()%10;
                NSString *errorHead, *errorMsg;
                switch (comment) {
                    case 0:
                        errorHead = @"哥";
                        errorMsg = @"给点评价吧";
                        break;
                    case 1:
                        errorHead = @"亲";
                        errorMsg = @"给点评价吧";
                        break;
                    case 2:
                        errorHead = @"哎呀";
                        errorMsg = @"给点评价吧";
                        break;
                    default:
                        errorHead = @"同学";
                        errorMsg = @"给点评价吧";
                        break;
                        break;
                }
                errorHead = @"Hey";
                errorMsg = @"Please leave some comments";
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:errorHead message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:appDelegate.defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            } else {
                current++;
                explanation3.text = @"Overall rate(out of 10)";
                [surveyAnswers setObject:textField.text forKey:@"0"];
                [uploadAnswers setObject:textField.text forKey:@"0"];
                textField.text = [surveyAnswers objectForKey:@"1"];
                textField.placeholder = @" Overall rate(out of 10)";
                [self.view addSubview:submitButton];
                [nextButton removeFromSuperview];
                [surveyAnswers synchronize];
            }
        }
        else if(current == 1){
            [surveyAnswers setObject:textField.text forKey:@"1"];
            [uploadAnswers setObject:textField.text forKey:@"1"];
        }
        process.text = [NSString stringWithFormat: @"( %lu / 2 )", (unsigned long)(current+1)];
    }
    else if(button.tag == 2){
        if(current == 1){
            current--;
            explanation3.text = @"Comments for this class and tutor";//@"对本堂课以及tutor有什么意见以及建议";
            textField.text = [surveyAnswers objectForKey:@"0"];
            textField.placeholder = @" comments";//@" 意见以及建议";
            [submitButton removeFromSuperview];
            [self.view addSubview:nextButton];
            [surveyAnswers synchronize];
        }
        process.text = [NSString stringWithFormat: @"( %lu / 2 )", (unsigned long)(current+1)];
    }
    else if(button.tag == 3){
        [surveyAnswers setObject:textField.text forKey:@"1"];
        [uploadAnswers setObject:textField.text forKey:@"1"];
        WDGSyncReference *surveyRef = [[WDGSync sync] reference];
            NSString* date_String = [surveyAnswers objectForKey:@"lostdate"];
            NSString* accessString = [surveyAnswers objectForKey:@"lostaccesscode"];
            NSString* uid = appDelegate.uid;
            surveyRef = [[[[[surveyRef  child:@"classes"] child:date_String] child:accessString] child:@"students"] child:uid];
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd-MM-HH-mm-ss"];
        float batteryLevel = [UIDevice currentDevice].batteryLevel;
        NSNumber* battery;
        if (batteryLevel < 0.0) {
            batteryLevel = 0.0;
        }
        battery = [NSNumber numberWithFloat:batteryLevel];
        NSString *time_string = [dateformate stringFromDate:[NSDate date]];
        NSDictionary *survey = @{@"survey" : uploadAnswers,
                                @"endbattery" : [NSString stringWithFormat:@"%@", battery],
                                @"endtime" : time_string};
        [surveyRef updateChildValues:survey];
        [surveyAnswers setObject:@"" forKey:@"0"];
        [surveyAnswers setObject:@"" forKey:@"1"];
        [surveyAnswers setObject:@"MainViewController" forKey:@"initialViewController"];
        [surveyAnswers synchronize];
        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self presentViewController:viewcontroller animated:YES completion:nil];
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

@end
