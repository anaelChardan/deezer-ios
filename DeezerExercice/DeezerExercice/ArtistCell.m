//
//  ArtistCell.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "ArtistCell.h"

@interface ArtistCell ()

@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *artistName;

@end

@implementation ArtistCell

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
