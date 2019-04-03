//
//  SearchArtistsViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "SearchArtistsViewController.h"
#import "ArtistCell.h"
#import "DeezerExercice-Swift.h"

@interface SearchArtistsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, SearchArtistsViewModelDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *informationLabel;

@property (nonatomic) UISearchBar *searchBar;

@property (nonatomic) id <SearchArtistsViewModelProtocol> viewModel;

@end

@implementation SearchArtistsViewController

#pragma - Outlets
- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    [_collectionView setBackgroundColor:DZRColors.purple];
    
    CGFloat width = UIScreen.mainScreen.bounds.size.width / 3 - 16;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setMinimumLineSpacing:12];
    [layout setMinimumInteritemSpacing:12];
    [layout setItemSize:CGSizeMake(width, width * 1.6)];
    [layout setSectionInset:UIEdgeInsetsMake(8, 8, 0, 8)];
    
    [_collectionView setCollectionViewLayout:layout];
}

- (void)setSearchBar:(UISearchBar *)searchBar
{
    _searchBar = searchBar;
    [_searchBar setTranslucent:NO];
    [_searchBar setBarTintColor:DZRColors.purple];
    [_searchBar setPlaceholder:@"Enter an artist name"];
    [_searchBar setDelegate:self];
    [_searchBar setShowsCancelButton:YES animated:YES];
    
    UITextField *textfield = [_searchBar valueForKey:@"searchField"];
    [textfield setTextColor:DZRColors.white];
    [textfield setBackgroundColor:DZRColors.purple];
    
}

- (void)setInformationLabel:(UILabel *)informationLabel
{
    _informationLabel = informationLabel;
    
    [_informationLabel setText:@"Search an artist. For example U2, Queen, Muse ..."];
    [_informationLabel setTextColor:DZRColors.white];
    [_informationLabel setNumberOfLines:2];
    [_informationLabel setTextAlignment:NSTextAlignmentCenter];
    [_informationLabel setFont:DZRFonts.smallLight];
}

#pragma - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewModel = [SearchArtistsViewModel new];
    [self.viewModel setDelegate:self];
    
    self.searchBar = [UISearchBar new];
    [self.navigationItem setTitleView:self.searchBar];
    
    [self.navigationController.navigationBar setTintColor:DZRColors.white];
    [self.navigationController.navigationBar setBarTintColor:DZRColors.purple];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DZRColors.white, NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self setTitle:@"Artists"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma - SearchArtistsViewModelDelegate
- (void)searchArtistsViewModel:(SearchArtistsViewModel *)searchArtistsViewModel artistsValueChanged:(NSArray<Artist *> *)artists
{
    // If search has no result
    if(artists.count <= 0 && [self.searchBar.text length] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                [self.informationLabel setText:@"Your search returned no results, try another name"];
                [self.informationLabel setAlpha:1];

                [self.informationLabel layoutIfNeeded];
            }];
        });
        [self.searchBar resignFirstResponder];
    }
    // If there is no text in search bar
    else if (artists.count <= 0 && [self.searchBar.text length] <= 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                [self.informationLabel setText:@"Search an artist. For example U2, Queen, Muse ..."];
                [self.informationLabel setAlpha:1];

                [self.informationLabel layoutIfNeeded];
            }];
        });
        [self.searchBar resignFirstResponder];
    }
    // If search has results
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                [self.informationLabel setAlpha:0];

                [self.informationLabel layoutIfNeeded];
            }];
        });
    }

    [self.collectionView reloadData];
}

- (void)searchArtistsViewModel:(SearchArtistsViewModel *)searchArtistsViewModel selectedArtistValueChanged:(Artist *)selectedArtist
{
    [self performSegueWithIdentifier:@"tappedOnArtistCell" sender:self];
}

- (void)searchArtistsViewModel:(SearchArtistsViewModel *)searchArtistsViewModel errorMessageValueChanged:(NSString *)errorMessage
{
    [self showAlertErrorWithMessage:errorMessage];
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

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
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
    [self.searchBar resignFirstResponder];
    [self.viewModel artistCellDidTappedAt:indexPath];
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
