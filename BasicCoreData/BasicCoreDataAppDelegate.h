//
//  BasicCoreDataAppDelegate.h
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/13/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicCoreDataAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
