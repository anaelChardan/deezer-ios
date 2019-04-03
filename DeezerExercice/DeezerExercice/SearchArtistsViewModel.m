//
//  SearchArtistsViewModel.m
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

#import "SearchArtistsViewModel.h"
#import "Artist.h"
#import "DeezerExercice-Swift.h"

@implementation SearchArtistsViewModel

-(void)setArtists:(NSMutableArray *)artists
{
    _artists = artists;
    [self.delegate artistsValueChanged:self.artists];
}

-(void)setError:(NSString *)error
{
    _error = error;
    [self.delegate errorValueChanged:error];
}

-(void)setSelectedArtist:(Artist * )selectedArtist
{
    _selectedArtist = selectedArtist;
    [self.delegate selectedArtistValueChanged:selectedArtist];
}

-(void)searchArtistsWithQuery:(NSString *)query
{
    
    NSString *urlRequest = [NSString stringWithFormat:@"http://api.deezer.com/search/artist?q=%@&limit=150", query];
    urlRequest = [urlRequest stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlRequest]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                if (error) {
                    dispatch_sync(dispatch_get_main_queue(),^{
                        self.error = error.localizedDescription;
                    });
                }
                else {
                    NSDictionary *retData = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:kNilOptions
                                                                              error:&error];
                    
                    NSMutableArray *artists = [NSMutableArray new];
                    for (NSDictionary* artistDictionary in [retData objectForKey:@"data"]) {
                        Artist *artist = [[Artist alloc] initWithDictionary:artistDictionary];
                        
                        [artists addObject:artist];
                    }
                    
                    dispatch_sync(dispatch_get_main_queue(),^{
                        self.artists = artists;
                    });
                }
            }] resume];
}

- (void)artistCellDidTapped:(NSInteger)row
{
    self.selectedArtist = [self.artists objectAtIndex:row];
}

@end
