//
//  FormDetailController.m
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/14/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import "FormDetailController.h"

@implementation FormDetailController

@synthesize firstnameTextField;
@synthesize lastnameTextField;
@synthesize genderSegmentC;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize currentPerson = _currentPerson;

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)updateButton:(id)sender
{
    NSString *firstname = [firstnameTextField text];
    NSString *lastname = [lastnameTextField text];
    NSString *gender = @"Male";
    
    if (genderSegmentC.selectedSegmentIndex == 0) {
        gender = @"Male";
    }else{
        gender = @"Female";
    }
    
    NSManagedObjectContext *context = self.currentPerson.managedObjectContext;
    
    
    self.currentPerson.gender = gender;
    self.currentPerson.firstName = firstname;
    self.currentPerson.lastName = lastname;
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't update: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

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

    
    self.firstnameTextField.text = self.currentPerson.firstName;
    self.lastnameTextField.text = self.currentPerson.lastName;
    
    if ([self.currentPerson.gender isEqualToString:@"Male"]) {
        self.genderSegmentC.selectedSegmentIndex = 0;
    }else{
       self.genderSegmentC.selectedSegmentIndex = 1;
    }
    
    self.navigationController.toolbarHidden = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [self setFirstnameTextField:nil];
    [self setLastnameTextField:nil];
    [self setGenderSegmentC:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [firstnameTextField release];
    [lastnameTextField release];
    [genderSegmentC release];
    [super dealloc];
}

@end
