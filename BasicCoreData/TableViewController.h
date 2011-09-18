//
//  TableViewController.h
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/13/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "FormViewController.h"
#import "FormDetailController.h"

@interface TableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) NSMutableArray *arrayList;

@property(nonatomic, retain) NSIndexPath *deleteIndexPath;

-(void)loadCoreData;
-(void)loadFormView;
-(void)searchTableViewWithOption:(NSInteger)searchOptions;

@end
