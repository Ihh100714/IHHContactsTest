//
//  IHHContactsFetcher.h
//  IHHContactsTest
//
//  Created by Ismail on 11/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHHContactsFetcher : NSObject

@property (strong,atomic) NSManagedObjectContext* privateContext;
+ (instancetype)shared;

- (void)fetchContacts:(void(^)(bool done)) block;
- (void)fetchImageFromURL:(NSString *)imageUrl completion:(void(^)(UIImage *image, NSString *uri, NSError *error)) block;
@end
