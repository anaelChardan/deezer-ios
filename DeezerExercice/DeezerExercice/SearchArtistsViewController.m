//
//  SearchArtistsViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "SearchArtistsViewController.h"
#import "PopularArtistCell.h"
#import "DeezerExercice-Swift.h"

@interface SearchArtistsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegate, UISearchBarDelegate, SearchArtistsViewModelDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (nonatomic) UISearchBar *searchBar;

@property (nonatomic) id <SearchArtistsViewModelProtocol> viewModel;

@end

@implementation SearchArtistsViewController

#pragma mark - Outlets
- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    [_collectionView setBackgroundColor:DZRColors.purple];
    [_collectionView setDelegate:self];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setMinimumLineSpacing:12];
    [layout setMinimumInteritemSpacing:12];
    [layout setSectionInset:UIEdgeInsetsMake(8, 8, 0, 8)];
    [layout setHeaderReferenceSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 70)];
    
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
    [_informationLabel setFont:DZRFonts.medium];
}

-(void)setSearchButton:(UIButton *)searchButton
{
    _searchButton = searchButton;
    
    [_searchButton setTitle:@"Search !" forState:UIControlStateNormal];
    [_searchButton setTitleColor:DZRColors.white forState:UIControlStateNormal];
    [_searchButton setBackgroundColor:DZRColors.pink];
    [_searchButton.layer setCornerRadius:4];
    [_searchButton.titleLabel setFont:DZRFonts.medium];
    [_searchButton setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [_searchButton setAccessibilityLabel:@"searchButton"];
}

#pragma mark - Lifecycle
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
    
    //Check every 500ms if the last query sent to the server is different from the text in the search bar.
    //If this is different, do a new request with text in the search bar.
    //If not, do nothing.
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkIfWeNeedToDoARequest) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Methods

/*!
 @brief Check every 500ms if the last query sent to the server is different from the text in the search bar. If this is different, do a new request with text in the search bar. If not, do nothing.
 */
- (void)checkIfWeNeedToDoARequest
{
    if (![self.viewModel.lastQueryString isEqualToString:self.searchBar.text]) {
        [self.viewModel searchArtistsWithQuery:self.searchBar.text];
    }
}

#pragma mark - Actions
/*!
 @brief Search bar become first responder.
 
 @param sender The button that send the event.
 */
- (IBAction)searchButtonDidTap:(UIButton *)sender
{
    [self.searchBar becomeFirstResponder];
}

#pragma mark - SearchArtistsViewModelDelegate
- (void)searchArtistsViewModel:(SearchArtistsViewModel *)searchArtistsViewModel artistsValueChanged:(NSArray<Artist *> *)artists
{
    // If search has no result, show a message to tell that a bad query.
    if(artists.count <= 0 && [self.searchBar.text length] > 0) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.informationLabel setText:@"Your search returned no results, try another name"];
            [self.informationLabel setAlpha:1];

            [self.view layoutIfNeeded];
        }];
        [self.searchBar resignFirstResponder];
    }
    // If there is no text in search bar, show a message to search an artist.
    else if (artists.count <= 0 && [self.searchBar.text length] <= 0) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.informationLabel setText:@"Search an artist. For example U2, Queen, Muse ..."];
            [self.informationLabel setAlpha:1];
            [self.searchButton setAlpha:1];
            
            [self.view layoutIfNeeded];
        }];
        [self.searchBar resignFirstResponder];
    }
    // If search has results, show artists and hide information label and button
    else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.informationLabel setAlpha:0];
            [self.searchButton setAlpha:0];
            
            [self.view layoutIfNeeded];
        }];
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

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.viewModel.artists count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.viewModel.artists objectForKey: [self.viewModel sectionNameWith:section]] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SearchArtistsHeaderView *header = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:@"SearchArtistsHeaderView"
                                                           forIndexPath:indexPath];
        
        [header displayWithTitle: indexPath.section == 0 ? @"Populars" : @"Others"];
    }
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //If cell is in the first section, use the "popular" cell type.
    if (indexPath.section == 0) {
        PopularArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopularArtistCell"
                                                                            forIndexPath:indexPath];
        Artist *artist = [[self.viewModel.artists objectForKey:[self.viewModel sectionNameWith:indexPath.section]] objectAtIndex:indexPath.row];
        
        [cell display:artist.name withPictureUrl:artist.pictureUrlBig];
        
        return cell;
    }
    
    //Else, cell is in the second section, show the "other" cell type.
    OtherArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OtherArtistCell"
                                                                        forIndexPath:indexPath];
    Artist *artist = [[self.viewModel.artists objectForKey:[self.viewModel sectionNameWith:indexPath.section]] objectAtIndex:indexPath.row];
    
    [cell displayWithName:artist.name pictureUrl:artist.pictureUrlBig];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    [self.viewModel artistCellDidTappedAt:indexPath];
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //3 cells in a row for the first (popular) section.
    if (indexPath.section == 0) {
        CGFloat width = UIScreen.mainScreen.bounds.size.width / 3 - 16;
        return CGSizeMake(width, width * 1.6);
    }
    
    //1 cell in a row for the second (others) section
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width - 16, 60);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

#pragma mark - PrepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"tappedOnArtistCell"]) {
        AlbumDetailsViewController *vc = segue.destinationViewController;
        
        [vc setArtistId: self.viewModel.selectedArtist.identifier];
    }
}

@end
