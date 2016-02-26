//
//  UserViewController.m
//  TAR
//
//  Created by Jiasheng Zhu on 2/25/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"
#import "QR/UIImage+MDQRCode.h"
@interface UserViewController ()

@end


@implementation UserViewController
@synthesize appDelegate;
NSString* QR_UID;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDelegate.uid isEqualToString:@""]){
        QR_UID = @"ERROR";
    }
    else{
        QR_UID = appDelegate.uid;
    }
    CGFloat imageSize = ceilf(self.view.bounds.size.width * 0.6f);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf(self.view.bounds.size.width * 0.5f - imageSize * 0.5f), floorf(self.view.bounds.size.height * 0.5f - imageSize * 0.5f), imageSize, imageSize)];
    imageView.image = [UIImage mdQRCodeForString:QR_UID size:imageView.bounds.size.width fillColor:[UIColor darkGrayColor]];
//    [self.view addSubview:imageView];
}

@end