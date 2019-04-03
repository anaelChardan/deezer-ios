//
//  ArtistCell.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "ArtistCell.h"
#import "DeezerExercice-Swift.h"

@interface ArtistCell ()

@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (weak, nonatomic) IBOutlet UIView *gradientBackgroundView;

@end

@implementation ArtistCell

#pragma - Outlets -
-(void)setArtistName:(UILabel *)artistName
{
    _artistName = artistName;
    
    [_artistName setTextColor:DZRColors.white];
    [_artistName setFont:DZRFonts.smallMedium];
    [_artistName setTextAlignment:NSTextAlignmentCenter];
}

- (void)setArtistImage:(UIImageView *)artistImage
{
    _artistImage = artistImage;
    
    [_artistImage setContentMode:UIViewContentModeScaleAspectFill];
    [_artistImage setClipsToBounds:YES];
    [_artistImage.layer setCornerRadius:2];
}

- (void)setGradientBackgroundView:(UIView *)gradientBackgroundView
{
    _gradientBackgroundView = gradientBackgroundView;    
    
    [_gradientBackgroundView setBackgroundColor:UIColor.clearColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _gradientBackgroundView.bounds;
    
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[DZRColors.purple colorWithAlphaComponent:0.7].CGColor];
    
    [_gradientBackgroundView.layer insertSublayer:gradient atIndex:0];
}

#pragma - Methods -
- (void)display:(NSString *)name withPictureUrl:(NSString *)pictureUrl
{
    self.artistImage.image = nil;
    self.artistImage.alpha = 0;
    
    self.artistName.alpha = 0;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: pictureUrl]];
        if (data == nil) {
            [UIView animateWithDuration:0.2 animations:^{
                self.artistImage.alpha = 1;
                
                [self layoutIfNeeded];
            }];
            
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                self.artistImage.image = [UIImage imageWithData: data];
                self.artistImage.alpha = 1;
                
                [self layoutIfNeeded];
            }];
            
        });
    });
    
    [UIView animateWithDuration:0.2 animations:^{
        self.artistName.text = name;
        self.artistName.alpha = 1;
        
        [self layoutIfNeeded];
    }];

}

@end
