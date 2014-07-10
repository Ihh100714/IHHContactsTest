//
//  IHHAppDelegate.h
//  IHHContactsTest
//
//  Created by Ismail on 10/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
