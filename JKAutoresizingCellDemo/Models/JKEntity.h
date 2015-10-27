//
//  JKEntity.h
//  JKAutoresizingCellDemo
//
//  Created by Jack Huang on 15/10/17.
//  Copyright © 2015年 Jack's app for practice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKEntity : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL hasImage;
@property (nonatomic, assign) BOOL hasAudio;

@end
