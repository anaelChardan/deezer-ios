//
//  PopularArtistCell.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "PopularArtistCell.h"
#import "DeezerExercice-Swift.h"

@interface PopularArtistCell ()

@property (weak, nonatomic) IBOutlet DZRImageView *artistDZRImageView;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UIView *gradientBackgroundView;

@end

@implementation PopularArtistCell

#pragma mark - Outlets
- (void)setArtistDZRImageView:(DZRImageView *)artistDZRImageView
{
    _artistDZRImageView = artistDZRImageView;
    
    [_artistDZRImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_artistDZRImageView setClipsToBounds:YES];
    [_artistDZRImageView.layer setCornerRadius:2];
    [_artistDZRImageView setAlpha:0];
}

- (void)setArtistNameLabel:(UILabel *)artistNameLabel
{
    _artistNameLabel = artistNameLabel;
    
    [_artistNameLabel setTextColor:DZRColors.white];
    [_artistNameLabel setFont:DZRFonts.normalMedium];
    [_artistNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_artistNameLabel setAlpha:0];
}

- (void)setGradientBackgroundView:(UIView *)gradientBackgroundView
{
    _gradientBackgroundView = gradientBackgroundView;    
    
    [_gradientBackgroundView setBackgroundColor:UIColor.clearColor];
    [_gradientBackgroundView gradientWithColors:@[(id)[UIColor clearColor], (id)[DZRColors.purple colorWithAlphaComponent:0.7]]];
}

#pragma mark - Methods
- (void)display:(NSString *)name withPictureUrl:(NSString *)pictureUrl
{
    [self.artistNameLabel setText:name];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.artistNameLabel setAlpha:1];
        
        [self layoutIfNeeded];
    }];
        
    [self.artistDZRImageView loadAsyncWithStringUrl:pictureUrl completionSuccess:^{
        [UIView animateWithDuration:0.2 animations:^{
            [self->_artistDZRImageView setAlpha:1];
            
            [self layoutIfNeeded];
        }];
    }];
}

@end
