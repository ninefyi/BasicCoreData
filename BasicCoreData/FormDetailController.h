//
//  FormDetailController.h
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/14/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface FormDetailController : UIViewController<UITextFieldDelegate> {
    UITextField *firstnameTextField;
    UITextField *lastnameTextField;
    UISegmentedControl *genderSegmentC;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *genderSegmentC;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UITextField *firstnameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastnameTextField;
@property (nonatomic, retain) Person *currentPerson;

- (IBAction)updateButton:(id)sender;

@end
