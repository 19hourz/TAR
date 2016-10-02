//
//  CurrentClassViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 4/13/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentClassViewController.h"
@interface CurrentClassViewController()

@end

@implementation CurrentClassViewController

@synthesize appDelegate;
NSTimer *timer;
CAShapeLayer *circleLayer;
CGFloat size;
CGFloat x;
CGFloat y;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 1;
    [button setTitle:@"Hold to sign off" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:247.0/255.0 blue:248.0/255.0 alpha:1] forState:UIControlStateNormal];
    //[button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(screenRect.size.width*0.2, screenRect.size.height*0.5, screenRect.size.width*0.6, screenRect.size.width*0.4);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = screenRect.size.width*0.4/2.0f;
    button.layer.borderColor=[UIColor whiteColor].CGColor;
    button.layer.borderWidth=4.0f;
    [button setBackgroundColor:[UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(removeFromSuperlayer:) forControlEvents:UIControlEventTouchCancel];
    [button addTarget:self action:@selector(removeFromSuperlayer:) forControlEvents:UIControlEventTouchDragExit];
    [button addTarget:self action:@selector(removeFromSuperlayer:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(removeFromSuperlayer:) forControlEvents:UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(removeFromSuperlayer:) forControlEvents:UIControlEventTouchUpOutside];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)removeFromSuperlayer:(UIButton *)button{
    if(circleLayer != nil){
        [circleLayer removeFromSuperlayer];
        [timer invalidate];
    }
}

- (void)didTapButton:(UIButton *)button{
    if(circleLayer != nil){
        [circleLayer removeFromSuperlayer];
    }
    circleLayer = [CAShapeLayer layer];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    size = 0;
    x = screenRect.size.width*0.5;
    y = screenRect.size.height*0.5 + screenRect.size.width*0.2;
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, size, size)] CGPath]];
    circleLayer.fillColor = [UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1].CGColor;
    [self.view.layer insertSublayer:circleLayer atIndex:0];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateView:) userInfo:nil repeats:YES];
}

- (void)updateView:(NSTimer*)timer
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x-=3;
    y-=3;
    size+=6;
    CGFloat alpha = 1 - size/screenRect.size.height*2;
    alpha*=10;
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, size, size)] CGPath]];
    circleLayer.fillColor = [UIColor colorWithRed:26/255.0 green:102/255.0 blue:140/255.0 alpha:1].CGColor;
    if(size >= screenRect.size.height*1.4)
    {
        [timer invalidate];
        UIViewController* viewcontroller = [appDelegate.storyboard instantiateViewControllerWithIdentifier:@"SurveyViewController"];
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

@end
