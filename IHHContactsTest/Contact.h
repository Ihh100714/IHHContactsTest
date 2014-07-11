//
//  Contact.h
//  IHHContactsTest
//
//  Created by Ismail on 11/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSNumber * pictureDownloaded;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic ,retain) UIImage  * picture;


@end
