//
//  IHHContactDetailsViewController.h
//  IHHContactsTest
//
//  Created by Ismail on 11/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface IHHContactDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *ivPicture;
@property (strong, nonatomic) IBOutlet UITextView *tvNotes;
@property (strong, nonatomic) Contact * contact;

@end
