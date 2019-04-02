//
//  Artist.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *pictureUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
