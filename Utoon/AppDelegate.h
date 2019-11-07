//
//  AppDelegate.h
//  Utoon
//
//  Created by Macbook Pro on 30/01/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

