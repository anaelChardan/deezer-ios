//
//  ArtistCollectionViewCell.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *artistName;

@end
