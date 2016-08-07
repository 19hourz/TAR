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
UIButton *button;
UIButton *backButton;
UIButton *submitButton;
UITextField* textField;
NSUserDefaults* surveyAnswers;
NSMutableDictionary* uploadAnswers;
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
    explanation3 = [[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.1, screenRect.size.height*0.35, screenRect.size.width*0.9, screenRect.size.height*0.05)];
    explanation3.text = @"Tutor name";
    [explanation3 setTextAlignment:NSTextAlignmentLeft];
    explanation3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:explanation3];
    //add email text field
    textField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.4, screenRect.size.width*0.7, 31)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = @" Tutor Name";
    textField.delegate = self;
    [textField setKeyboardType:UIKeyboardTypeDefault];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.view addSubview:textField];
    
    //add a button
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.53, screenRect.size.width*0.6, screenRect.size.height*0.1);
    //[button setBackgroundColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1]];
    button.tag = 1;
    [button setTitle:@"Next  " forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    button.layer.cornerRadius = screenRect.size.width*0.4/10.0f;
    button.layer.borderColor=[UIColor grayColor].CGColor;
    button.layer.borderWidth=2.0f;
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
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
    submitButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.77, screenRect.size.width*0.6, screenRect.size.height*0.1);
    submitButton.tag = 3;
    [submitButton setTitle:@"Submit  " forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    if(button.tag == 1){
        if(current == 0){
            current++;
            explanation3.text = @"TA Class";
            [surveyAnswers setObject:textField.text forKey:@"0"];
            [uploadAnswers setObject:textField.text forKey:@"0"];
            textField.placeholder = @" TA Class";
            textField.text = [surveyAnswers objectForKey:@"1"];
            [surveyAnswers synchronize];
        }
        else if(current == 1){
            current++;
            explanation3.text = @"课程节数";
            [surveyAnswers setObject:textField.text forKey:@"1"];
            [uploadAnswers setObject:textField.text forKey:@"1"];
            textField.text = [surveyAnswers objectForKey:@"2"];
            textField.placeholder = @" 课程节数";
            [surveyAnswers synchronize];
        }
        else if(current == 2){
            current++;
            explanation3.text = @"上课日期 (MMDD)";
            [surveyAnswers setObject:textField.text forKey:@"2"];
            [uploadAnswers setObject:textField.text forKey:@"2"];
            textField.text = [surveyAnswers objectForKey:@"3"];
            textField.placeholder = @" 上课日期 (MMDD)";
            [surveyAnswers synchronize];
        }
        else if(current == 3){
            current++;
            explanation3.text = @"是否有趣(out of 10)";
            [surveyAnswers setObject:textField.text forKey:@"3"];
            [uploadAnswers setObject:textField.text forKey:@"3"];
            textField.text = [surveyAnswers objectForKey:@"4"];
            textField.placeholder = @" 是否有趣(out of 10)";
            [surveyAnswers synchronize];
        }
        else if(current == 4){
            current++;
            explanation3.text = @"是否有料(out of 10)";
            [surveyAnswers setObject:textField.text forKey:@"4"];
            [uploadAnswers setObject:textField.text forKey:@"4"];
            textField.text = [surveyAnswers objectForKey:@"5"];
            textField.placeholder = @" 是否有料(out of 10)";
            [surveyAnswers synchronize];
        }
        else if(current == 5){
            current++;
            explanation3.text = @"主管综合评价(out of 10)";
            [surveyAnswers setObject:textField.text forKey:@"5"];
            [uploadAnswers setObject:textField.text forKey:@"5"];
            textField.text = [surveyAnswers objectForKey:@"6"];
            textField.placeholder = @" 主管综合评价(out of 10)";
            [self.view addSubview:submitButton];
            [surveyAnswers synchronize];
        }
        else if(current == 6){
            [surveyAnswers setObject:textField.text forKey:@"6"];
            [uploadAnswers setObject:textField.text forKey:@"6"];
        }
    }
    else if(button.tag == 2){
        if(current == 1){
            current--;
            explanation3.text = @"Tutor name";
            textField.text = [surveyAnswers objectForKey:@"0"];
            textField.placeholder = @" Tutor name";
        }
        else if(current == 2){
            current--;
            explanation3.text = @"TA Class";
            textField.text = [surveyAnswers objectForKey:@"1"];
            textField.placeholder = @" TA Class";
        }
        else if(current == 3){
            current--;
            explanation3.text = @"课程节数";
            textField.text = [surveyAnswers objectForKey:@"2"];
            textField.placeholder = @" 课程节数";
        }
        else if(current == 4){
            current--;
            explanation3.text = @"上课日期 (MMDD)";
            textField.text = [surveyAnswers objectForKey:@"3"];
            textField.placeholder = @" 上课日期 (MMDD)";
        }
        else if(current == 5){
            current--;
            explanation3.text = @"是否有趣(out of 10)";
            textField.text = [surveyAnswers objectForKey:@"4"];
            textField.placeholder = @" 是否有趣(out of 10)";
        }
        else if(current == 6){
            current--;
            explanation3.text = @"是否有料(out of 10)";
            textField.text = [surveyAnswers objectForKey:@"5"];
            textField.placeholder = @" 是否有料(out of 10)";
            [submitButton removeFromSuperview];
        }
    }
    else if(button.tag == 3){
        [surveyAnswers setObject:textField.text forKey:@"6"];
        [uploadAnswers setObject:textField.text forKey:@"6"];
        if(appDelegate.surveyURL == nil){
            appDelegate.surveyURL = [[FIRDatabase database] reference];
            NSString* date_String = [surveyAnswers objectForKey:@"lostdate"];
            NSString* accessString = [surveyAnswers objectForKey:@"lostaccesscode"];
            NSString* uid = appDelegate.uid;
            appDelegate.surveyURL = [[[[[appDelegate.surveyURL  child:@"classes"] child:date_String] child:accessString] child:@"students"] child:uid];
        }
        [appDelegate.surveyURL observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
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
            [appDelegate.surveyURL updateChildValues:survey];
            [surveyAnswers setObject:@"" forKey:@"0"];
            [surveyAnswers setObject:@"" forKey:@"1"];
            [surveyAnswers setObject:@"" forKey:@"2"];
            [surveyAnswers setObject:@"" forKey:@"3"];
            [surveyAnswers setObject:@"" forKey:@"4"];
            [surveyAnswers setObject:@"" forKey:@"5"];
            [surveyAnswers setObject:@"" forKey:@"6"];
            [surveyAnswers setObject:@"MainViewController" forKey:@"initialViewController"];
            [surveyAnswers synchronize];
            UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self presentViewController:viewcontroller animated:YES completion:nil];
        }];
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
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    button.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.53, screenRect.size.width*0.6, screenRect.size.height*0.1);
//    submitButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.77, screenRect.size.width*0.6, screenRect.size.height*0.1);
//    backButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.65, screenRect.size.width*0.6, screenRect.size.height*0.1);
    //[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(withoutKeyboardView:) userInfo:nil repeats:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    button.frame = CGRectMake(screenRect.size.width*0.1, screenRect.size.height*0.48, screenRect.size.width*0.3, screenRect.size.height*0.1);
//    backButton.frame = CGRectMake(screenRect.size.width*0.6, screenRect.size.height*0.48, screenRect.size.width*0.3, screenRect.size.height*0.1);
//    submitButton.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.6, screenRect.size.width*0.6, screenRect.size.height*0.1);
    //[NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(withKeyboardView:) userInfo:nil repeats:YES];
    return YES;
}

//- (void)withoutKeyboardView:(NSTimer*)timer
//{
//    //x -width*0.1; y -height*0.5; w width*0.3; h 0
//    //x width*0.4; y -height*0.17; w -width*0.3
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    bx = screenRect.size.width*0.1/20;
//    by = screenRect.size.height*0.05/20;
//    bw = screenRect.size.width*0.3/20;
//    bbx = screenRect.size.width*0.4/20;
//    bby = screenRect.size.height*0.17/20;
//    //bbx = screenRect.size.
//    button.frame = CGRectMake(button.frame.origin.x + bx, button.frame.origin.y + by, button.frame.size.width + bw, button.frame.size.height + bh);
//    backButton.frame = CGRectMake(backButton.frame.origin.x - bbx, backButton.frame.origin.y + bby, backButton.frame.size.width + bw, backButton.frame.size.height + bbh);
//    if(button.frame.size.width >= screenRect.size.width*0.6)
//    {
//        [timer invalidate];
//    }
//}
//
//- (void)withKeyboardView:(NSTimer*)timer
//{
//    //x -width*0.1; y -height*0.5; w width*0.3; h 0
//    //x width*0.4; y -height*0.17; w -width*0.3
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    bx = screenRect.size.width*0.1/20;
//    by = screenRect.size.height*0.05/20;
//    bw = screenRect.size.width*0.3/20;
//    bbx = screenRect.size.width*0.4/20;
//    bby = screenRect.size.height*0.17/20;
//    //bbx = screenRect.size.
//    button.frame = CGRectMake(button.frame.origin.x - bx, button.frame.origin.y - by, button.frame.size.width - bw, button.frame.size.height + bh);
//    backButton.frame = CGRectMake(backButton.frame.origin.x + bbx, backButton.frame.origin.y - bby, backButton.frame.size.width - bw, backButton.frame.size.height + bbh);
//    if(button.frame.size.width <= screenRect.size.width*0.3)
//    {
//        [timer invalidate];
//    }
//}

@end