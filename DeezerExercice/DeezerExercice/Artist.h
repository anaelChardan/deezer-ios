//
//  Artist.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic) NSString *artistIdentifier;
@property (nonatomic) NSString *artistName;
@property (nonatomic) NSString *artistPictureUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
