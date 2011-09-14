//
//  TableViewController.m
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/13/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import "TableViewController.h"

@implementation TableViewController

@synthesize managedObjectContext = _managedObjectContext;

@synthesize arrayList = _arrayList;

@synthesize deleteIndexPath = _deleteIndexPath;


#pragma mark - Search

-(void)searchTableViewWithOption:(NSInteger)searchOptions
{
  NSString *searchKey = self.searchDisplayController.searchBar.text;
    
    NSMutableArray *searchList = [[NSMutableArray alloc] init];
    
    for (Person *p in self.arrayList) {
        NSRange foundRange = [p.firstName rangeOfString:searchKey 
                                            options:NSCaseInsensitiveSearch];
        
        if (searchOptions == 1) {
            if (foundRange.length > 0 && [p.gender isEqualToString:@"Male"])
            {
                [searchList addObject:p];
            }
        }else if(searchOptions == 2){
            if (foundRange.length > 0 && [p.gender isEqualToString:@"Female"])
            {
                [searchList addObject:p];
            }
        }else{
            if (foundRange.length > 0)
            {
                [searchList addObject:p];
            }
        }
            
    }
    
    self.arrayList = searchList;
    
    [searchList release];

}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller 
        shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length > 0) {
        [self searchTableViewWithOption:0];
    }else{
        [self loadCoreData];
    }
    
    [self.tableView reloadData];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller 
        shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self searchTableViewWithOption:searchOption];
    return YES;
}



#pragma mark - Normal


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)loadCoreData
{
    self.arrayList = [NSArray array];
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Person" 
                                   inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.managedObjectContext 
                               executeFetchRequest:fetchRequest error:&error];
    
    self.arrayList = [NSMutableArray arrayWithArray:fetchedObjects];
    
    [fetchRequest release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    [self loadCoreData];
    
    
    UIBarButtonItem *createButtomItem = [[UIBarButtonItem alloc] 
                                         initWithTitle:@"CREATE" 
                                         style:UIBarButtonItemStyleBordered 
                                         target:self 
                                         action:@selector(loadFormView)];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    self.navigationController.toolbarHidden = NO;
    self.toolbarItems = [NSArray arrayWithObject:createButtomItem];
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] 
                              initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)]; 
    searchBar.delegate = self;  
    searchBar.showsCancelButton = YES;  
    searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"ALL", @"Male", @"Female", nil]; 
	[searchBar sizeToFit];  
    
    UISearchDisplayController *searchDC = [[UISearchDisplayController alloc] 
                                            initWithSearchBar:searchBar 
                                            contentsController:self];
    searchDC.searchResultsDataSource = self;
    searchDC.searchResultsDelegate = self;
    searchDC.delegate = self;
    
	self.tableView.tableHeaderView = searchDC.searchBar; 
    
    
    [createButtomItem release];
}

-(void)loadFormView
{
    FormViewController *fVC = [[FormViewController alloc] init];
    fVC.title = @"CREATE";
    fVC.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:fVC animated:YES];
    
    [fVC release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
    [self loadCoreData];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
    numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    Person *obj = (Person *)[self.arrayList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@"
                           , obj.firstName
                           , obj.lastName];
    cell.detailTextLabel.text = obj.gender;
    
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView 
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.deleteIndexPath = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] 
                                initWithTitle:@"MY APP" 
                                message:@"Are you sure to delete" 
                                delegate:self 
                                cancelButtonTitle:@"NO" 
                                otherButtonTitles:@"YES", nil];
        
        [alert show];
        [alert release];
        
        self.deleteIndexPath = indexPath;
        
    }
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) 
    {
        
        Person *p = (Person *)[self.arrayList objectAtIndex:self.deleteIndexPath.row];
        
        if(p){
            [self.arrayList removeObjectAtIndex:self.deleteIndexPath.row];
            [self.managedObjectContext deleteObject:p];
            [self.tableView reloadData];
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                exit(-1);  // Fail
                
            }
        }

        
        
    }
}

@end
