//
//  Track.h
//  Simple Player
//
//  Created by Wahid Chowdhury on 5/15/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album, Artist;

@interface Track : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spotifyUrl;
@property (nonatomic, retain) Album *album;
@property (nonatomic, retain) NSSet *artists;
@end

@interface Track (CoreDataGeneratedAccessors)

- (void)addArtistsObject:(Artist *)value;
- (void)removeArtistsObject:(Artist *)value;
- (void)addArtists:(NSSet *)values;
- (void)removeArtists:(NSSet *)values;

@end
