//
//  JKEntityCell.m
//  JKAutoresizingCellDemo
//
//  Created by Jack Huang on 15/10/17.
//  Copyright © 2015年 Jack's app for practice. All rights reserved.
//

#import "JKEntityCell.h"

@interface JKEntityCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *entityImageView;
@property (nonatomic, strong) UIView *entityAudioView;

@property (nonatomic, strong) NSLayoutConstraint *titleTop;
@property (nonatomic, strong) NSLayoutConstraint *titleBottomToContentTop;
@property (nonatomic, strong) NSLayoutConstraint *contentBottomToImageTop;
@property (nonatomic, strong) NSLayoutConstraint *imageBottomToAudioTop;

@property (nonatomic, strong) NSLayoutConstraint *imageHeight;
@property (nonatomic, strong) NSLayoutConstraint *audioHeight;

@end

#define kJKEntityCellInsetX 12.0
#define kJKEntityCellInsetY 12.0

#define kJKEntityCellImageWidth 120
#define kJKEntityCellImageHeight 120
#define kJKEntityCellAudioHeight 40

@implementation JKEntityCell
{
    BOOL _didUpdateConstraints;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//}

//// 这里会多次调用
//- (void)updateConstraints
//{
//    [super updateConstraints];
//}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 确保contentView已经加载了layout，并且subviews已经设置好了frame
    // 这样就方便接下来给需要多行显示的label设置最大宽度限制
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // 将label的frame作为最大宽度限制
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
}

- (void)setupSubviews
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0; // 别忘了！不然无法多行显示
    _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_contentLabel];
    
    _entityImageView = [[UIImageView alloc] init];
    _entityImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_entityImageView];
    
    _entityAudioView = [[UIView alloc] init];
    _entityAudioView.backgroundColor = [UIColor lightGrayColor];
    _entityAudioView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_entityAudioView];
}

- (void)setupConstraints
{
    UIView *contentView = self.contentView;
//    contentView.bounds = CGRectMake(0, 0, 999, 999);
    
    /* -------------   title label   ------------ */
    
    NSLayoutConstraint *titleLC1 =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:kJKEntityCellInsetY];
    titleLC1.identifier = @"title_top";
    [contentView addConstraint:titleLC1];
    
    NSLayoutConstraint *titleLC2 =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:kJKEntityCellInsetX];
    titleLC2.identifier = @"title_leading";
    [contentView addConstraint:titleLC2];
    
    NSLayoutConstraint *titleLC3 =
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:-kJKEntityCellInsetX];
    titleLC3.identifier = @"title_trailing";
    [contentView addConstraint:titleLC3];
    
    self.titleTop = titleLC1;
    
    /* -------------   content label   ------------ */
    
    NSLayoutConstraint *contentLC1 =
    [NSLayoutConstraint constraintWithItem:_contentLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_titleLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:kJKEntityCellInsetY];
    contentLC1.identifier = @"title_bottom_to_content_top";
    [contentView addConstraint:contentLC1];
    
    NSLayoutConstraint *contentLC2 =
    [NSLayoutConstraint constraintWithItem:_contentLabel
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:kJKEntityCellInsetX];
    contentLC2.identifier = @"content_leading";
    [contentView addConstraint:contentLC2];
    
    NSLayoutConstraint *contentLC3 =
    [NSLayoutConstraint constraintWithItem:_contentLabel
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:-kJKEntityCellInsetX];
    contentLC3.identifier = @"content_trailing";
    [contentView addConstraint:contentLC3];
    
    self.titleBottomToContentTop = contentLC1;
    
    
    /* -------------   entity image view   ------------ */
    
    NSLayoutConstraint *imageLC1 =
    [NSLayoutConstraint constraintWithItem:_entityImageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_contentLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:kJKEntityCellInsetY];
    imageLC1.identifier = @"content_bottom_to_image_top";
    [contentView addConstraint:imageLC1];
    
    NSLayoutConstraint *imageLC2 =
    [NSLayoutConstraint constraintWithItem:_entityImageView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:kJKEntityCellInsetX];
    imageLC2.identifier = @"image_leading";
    [contentView addConstraint:imageLC2];
    
    NSLayoutConstraint *imageLC3 =
    [NSLayoutConstraint constraintWithItem:contentView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                    toItem:_entityImageView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:kJKEntityCellInsetX];
    imageLC3.identifier = @"image_trailing";
    [contentView addConstraint:imageLC3];
    
    NSLayoutConstraint *imageLC4 =
    [NSLayoutConstraint constraintWithItem:_entityImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1
                                  constant:kJKEntityCellImageWidth];
    imageLC4.identifier = @"image_width";
    [_entityImageView addConstraint:imageLC4];
    
    NSLayoutConstraint *imageLC5 =
    [NSLayoutConstraint constraintWithItem:_entityImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:kJKEntityCellImageHeight];
    imageLC5.identifier = @"image_height";
    [_entityImageView addConstraint:imageLC5];
    
    self.imageHeight = imageLC5;
    self.contentBottomToImageTop = imageLC1;

    
    /* -------------   entity audio view   ------------ */
    
    NSLayoutConstraint *audioLC0 =
    [NSLayoutConstraint constraintWithItem:_entityAudioView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_entityImageView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:kJKEntityCellInsetY];
    audioLC0.identifier = @"image_bottom_to_audio_top";
    [contentView addConstraint:audioLC0];
    
    NSLayoutConstraint *audioLC1 =
    [NSLayoutConstraint constraintWithItem:_entityAudioView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:kJKEntityCellInsetX];
    audioLC1.identifier = @"audio_leading";
    [contentView addConstraint:audioLC1];
    
    NSLayoutConstraint *audioLC2 =
    [NSLayoutConstraint constraintWithItem:contentView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_entityAudioView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:kJKEntityCellInsetY];
    audioLC2.identifier = @"audio_bottom"; // bottomConstraint
    audioLC2.priority = 999;
    [contentView addConstraint:audioLC2];

    
    NSLayoutConstraint *audioLC3 =
    [NSLayoutConstraint constraintWithItem:contentView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                    toItem:_entityAudioView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:kJKEntityCellInsetY];
    audioLC3.identifier = @"audio_trailing";
    [contentView addConstraint:audioLC3];
    
    NSLayoutConstraint *audioLC4 =
    [NSLayoutConstraint constraintWithItem:_entityAudioView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:0.5
                                  constant:0];
    audioLC4.identifier = @"audio_width";
    [contentView addConstraint:audioLC4];
    
    NSLayoutConstraint *audioLC5 =
    [NSLayoutConstraint constraintWithItem:_entityAudioView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:kJKEntityCellAudioHeight];
    audioLC5.identifier = @"audio_height";
    [_entityAudioView addConstraint:audioLC5];
    
    self.imageBottomToAudioTop = audioLC0;
    self.audioHeight = audioLC5;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setContent:(NSString *)content
{
    self.contentLabel.text = content;
    self.titleBottomToContentTop.constant = content ? kJKEntityCellInsetY : 0;
}

- (void)setImage:(UIImage *)image
{
    self.entityImageView.image = image;
    self.imageHeight.constant = image ? kJKEntityCellImageHeight : 0;
    self.contentBottomToImageTop.constant = image ? kJKEntityCellInsetY : 0;
}

- (void)showAudio:(BOOL)show
{
    self.entityAudioView.hidden = !show;
    self.audioHeight.constant = show ? kJKEntityCellAudioHeight : 0;
    self.imageBottomToAudioTop.constant = show ? kJKEntityCellInsetY : 0;
}

@end
