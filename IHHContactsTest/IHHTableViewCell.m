//
//  IHHTableViewCell.m
//  IHHContactsTest
//
//  Created by Ismail on 11/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import "IHHTableViewCell.h"

@implementation IHHTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
