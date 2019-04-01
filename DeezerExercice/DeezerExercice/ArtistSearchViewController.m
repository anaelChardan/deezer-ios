//
//  ArtistSearchViewController.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "ArtistSearchViewController.h"
#import "ArtistCollectionViewCell.h"
#import "Artist.h"

@interface ArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSMutableArray *artists;

@end

@implementation ArtistSearchViewController

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
    NSString *urlRequest = [NSString stringWithFormat:@"http://api.deezer.com/search/artist?q=%@", name];
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
    ArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Artist *artist = [self.artists objectAtIndex:indexPath.row];
    

    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: artist.pictureUrl]];
        if (data == nil) { return; }
        dispatch_async(dispatch_get_main_queue(), ^{

            cell.artistImage.image = [UIImage imageWithData: data];
        });
    });
    
    cell.artistName.text = artist.name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Artist *artist = [self.artists objectAtIndex:indexPath.row];

    NSLog(@"%@", artist.name);
}

@end
