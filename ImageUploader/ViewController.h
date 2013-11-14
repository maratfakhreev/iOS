//
//  ViewController.h
//  ImageUploader
//
//  Created by Marik on 11.11.13.
//  Copyright (c) 2013 Marik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) UIImage *image;
+(ViewController *)instance;
-(id) initWithNoteIndex:(int)index;
@end
