//
//  ArtistSearchViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "ArtistSearchViewController.h"
#import "ArtistCollectionViewCell.h"

@interface ArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSArray *artists;

@end

@implementation ArtistSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Search

- (void)searchArtistsWithName:(NSString *)name {
    NSString *urlRequest = [NSString stringWithFormat:@"http://api.deezer.com/search/artist?q=%@", name];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlRequest]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error) {
                    // TODO
                }
                else {
                    NSDictionary *retData = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:kNilOptions
                                                                              error:&error];
                    NSLog(@"%@", [retData objectForKey:@"data"]);
                    self.artists = [retData objectForKey:@"data"];
                    
                    dispatch_sync(dispatch_get_main_queue(),^{
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

    ArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *artistDictionary = [self.artists objectAtIndex:indexPath.row];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[artistDictionary objectForKey:@"picture"]]];
    cell.artistImage.image = [UIImage imageWithData:imageData];
    cell.artistName.text = [artistDictionary objectForKey:@"name"];
    return cell;
}

@end
