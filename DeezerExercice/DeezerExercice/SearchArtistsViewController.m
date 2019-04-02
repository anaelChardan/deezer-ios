//
//  SearchArtistsViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "SearchArtistsViewController.h"
#import "ArtistCell.h"
#import "Artist.h"
#import "DeezerExercice-Swift.h"

@interface SearchArtistsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSMutableArray *artists;
@property (nonatomic) Artist *artistSelected;

@end

@implementation SearchArtistsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.artists = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Search

- (void)searchArtistsWithName:(NSString *)name {
    NSString *urlRequest = [NSString stringWithFormat:@"http://api.deezer.com/search/artist?q=%@&limit=150", name];
    urlRequest = [urlRequest stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlRequest]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                   message:error.localizedDescription
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                          handler:nil];
                    [alert addAction:defaultAction];
                    
                    dispatch_sync(dispatch_get_main_queue(),^{
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
                else {
                    NSDictionary *retData = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:kNilOptions
                                                                              error:&error];
                    dispatch_sync(dispatch_get_main_queue(),^{
                        [self.artists removeAllObjects];
                        [self.collectionView reloadData];
                        
                        for (NSDictionary* artistDictionary in [retData objectForKey:@"data"]) {
                            Artist *artist = [[Artist alloc] initWithDictionary:artistDictionary];
                            
                            [self.artists addObject:artist];
                        }
                        
                        [self.collectionView reloadData];
                    });
                }
            }] resume];
}

#pragma - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchArtistsWithName:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.artists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArtistCollectionViewCellIdentifier";
    ArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Artist *artist = [self.artists objectAtIndex:indexPath.row];
    
    cell.artistImage.image = nil;
    cell.artistImage.alpha = 0;
    
    cell.artistName.alpha = 0;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: artist.pictureUrl]];
        if (data == nil) {
            [UIView animateWithDuration:0.2 animations:^{
                cell.artistImage.alpha = 1;
                
                [cell layoutIfNeeded];
            }];
            
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                cell.artistImage.image = [UIImage imageWithData: data];
                cell.artistImage.alpha = 1;
                
                [cell layoutIfNeeded];
            }];
            
        });
    });
    
    
    [UIView animateWithDuration:0.2 animations:^{
        cell.artistName.text = artist.name;
        cell.artistName.alpha = 1;
        
        [cell layoutIfNeeded];
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Artist *artist = [self.artists objectAtIndex:indexPath.row];
    _artistSelected = artist;
    
    [self performSegueWithIdentifier:@"tappedOnArtistCell" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"tappedOnArtistCell"]) {
        AlbumDetailsViewController *vc = segue.destinationViewController;
        
        [vc setArtistId: self.artistSelected.identifier];
    }
}

@end
