//
//  SearchArtistsViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "SearchArtistsViewController.h"
#import "ArtistCell.h"
#import "Artist.h"
#import "DeezerExercice-Swift.h"
#import "SearchArtistsViewModel.h"

@interface SearchArtistsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, SearchArtistsViewModelDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (nonatomic) SearchArtistsViewModel *viewModel;

@end

@implementation SearchArtistsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewModel = [SearchArtistsViewModel new];
    [self.viewModel setDelegate:self];
}

#pragma - SearchArtistsViewModelDelegate

- (void)artistsValueChanged:(NSArray *)artists
{
    [self.collectionView reloadData];
}

- (void)errorValueChanged:(NSString *)error
{
    [self showAlertErrorWithMessage:error];
}

- (void)selectedArtistValueChanged:(Artist *)artist
{
    [self performSegueWithIdentifier:@"tappedOnArtistCell" sender:self];
}

#pragma - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.viewModel searchArtistsWithQuery:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.artists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ArtistCell class]) forIndexPath:indexPath];
    Artist *artist = [self.viewModel.artists objectAtIndex:indexPath.row];
    
    [cell display:artist.name withPictureUrl:artist.pictureUrl];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel artistCellDidTapped:indexPath.row];
}

#pragma - PrepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"tappedOnArtistCell"]) {
        AlbumDetailsViewController *vc = segue.destinationViewController;
        
        [vc setArtistId: self.viewModel.selectedArtist.identifier];
    }
}

@end
