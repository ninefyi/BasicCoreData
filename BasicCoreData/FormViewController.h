//
//  FormViewController.h
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/13/54 BE.
//  Copyright 2554 piti_fee@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FormViewController : UIViewController<UITextFieldDelegate> {
    UITextField *firstnameTextField;
    UITextField *lastnameTextField;
    UISegmentedControl *genderSegmentC;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *genderSegmentC;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UITextField *firstnameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastnameTextField;
- (IBAction)createButton:(id)sender;

@end
