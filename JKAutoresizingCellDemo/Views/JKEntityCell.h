//
//  JKEntityCell.h
//  JKAutoresizingCellDemo
//
//  Created by Jack Huang on 15/10/17.
//  Copyright © 2015年 Jack's app for practice. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKEntity;

@interface JKEntityCell : UITableViewCell

- (void)setTitle:(NSString *)title;
- (void)setContent:(NSString *)content;
- (void)setImage:(UIImage *)image;
- (void)showAudio:(BOOL)show;

@end
