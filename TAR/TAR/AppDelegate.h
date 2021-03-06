//
//  AppDelegate.h
//  TAR
//
//  Created by Jiasheng Zhu on 2/20/16.
//  Copyright © 2016 Jiasheng Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Wilddog.h"
//#import "BaiduMobAdSDK/BaiduMobAdView.h"
//#import "BaiduMobAdSDK/BaiduMobAdDelegateProtocol.h"
//#import "BaiduMobAdSDK/BaiduMobAdSplash.h"
#define AvailableColor [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0]

//@import Firebase;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UIStoryboard *storyboard;
@property (strong, nonatomic) UIAlertAction *defaultAction;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) WDGSyncReference *wilddog;
@property (strong, nonatomic) WDGSyncReference *surveyRef;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

