//
//  Artist.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "Artist.h"

@implementation Artist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.identifier = [[dictionary objectForKey:@"id"] integerValue];
        self.name = [dictionary objectForKey:@"name"];
        self.pictureUrl = [dictionary objectForKey:@"picture"];
    }
    return self;
}
@end
