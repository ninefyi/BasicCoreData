//
//  Person.h
//  BasicCoreData
//
//  Created by Piti Champeethong on 9/13/54 BE.
//  Copyright (c) 2554 piti_fee@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * gender;

@end
