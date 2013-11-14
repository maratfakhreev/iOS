//
//  CoreDataHelper.h
//  TwitterParser
//
//  Created by Marik on 01.11.13.
//  Copyright (c) 2013 Danis Ziganshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSManagedObjectContext *moc;

@end
