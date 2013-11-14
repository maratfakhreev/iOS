//
//  imageCacher.h
//  TwitterParser
//
//  Created by Marik on 24.10.13.
//  Copyright (c) 2013 Danis Ziganshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageCacher : NSObject

+(imageCacher*) sharedCacher;

@property (nonatomic, strong) NSMutableDictionary *images;
-(void) setImage:(UIImage*) img forURL:(NSString*)urlString;
-(UIImage*) getImageForURL: (NSString*)urlString;
@end
