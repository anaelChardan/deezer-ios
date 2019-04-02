//
//  SearchArtistsViewModel.h
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

#import "Artist.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SearchArtistsViewModelDelegate

- (void) artistsValueChanged:(NSArray *)artists;
- (void) errorValueChanged:(NSString *)error;
- (void) selectedArtistValueChanged:(Artist *)artist;

@end

@interface SearchArtistsViewModel : NSObject

@property (nonatomic, weak) id <SearchArtistsViewModelDelegate> delegate;

@property (nonatomic, readonly) NSMutableArray *artists;
@property (nonatomic, readonly) NSString *error;
@property (nonatomic, readonly) Artist *selectedArtist;

- (void)searchArtistsWithQuery:(NSString *)query;
- (void)artistCellDidTapped:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
