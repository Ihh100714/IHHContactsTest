//
//  IHHTableViewCell.h
//  IHHContactsTest
//
//  Created by Ismail on 11/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHHTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ivPicture;
@property (strong, nonatomic) IBOutlet UILabel *lblFirstName;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblSex;

@property (strong, nonatomic) IBOutlet UILabel *lblLastName;
@end
