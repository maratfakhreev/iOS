//
//  Picture.h
//  ImageUploader
//
//  Created by Marik on 11.11.13.
//  Copyright (c) 2013 Marik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSString *hash;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;

-(void) setupWithDictionary:(NSDictionary *) dict;

+(NSArray *)findAllPictures;

@end
