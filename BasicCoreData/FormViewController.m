//
//  FormViewController.m
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/13/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import "FormViewController.h"

@implementation FormViewController
@synthesize firstnameTextField;
@synthesize lastnameTextField;
@synthesize genderSegmentC;
@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidUnload
{
    [self setFirstnameTextField:nil];
    [self setLastnameTextField:nil];
    [self setGenderSegmentC:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [firstnameTextField release];
    [lastnameTextField release];
    [genderSegmentC release];
    [super dealloc];
}
- (IBAction)createButton:(id)sender {
    
    NSString *firstname = [firstnameTextField text];
    NSString *lastname = [lastnameTextField text];
    NSString *gender = @"Male";
    
    if (genderSegmentC.selectedSegmentIndex == 0) {
        gender = @"Male";
    }else{
        gender = @"Female";
    }
    
    NSManagedObjectContext *context = _managedObjectContext;
    NSManagedObject *person = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Person" 
                                       inManagedObjectContext:context];
    
    
    
    [person setValue:firstname forKey:@"firstName"];
    [person setValue:lastname forKey:@"lastName"];
    [person setValue:gender forKey:@"gender"];
   
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
