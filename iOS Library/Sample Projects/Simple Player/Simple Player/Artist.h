//
//  Artist.h
//  Simple Player
//
//  Created by Wahid Chowdhury on 5/15/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album, Track;

@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spotifyUrl;
@property (nonatomic, retain) NSSet *albums;
@property (nonatomic, retain) NSSet *tracks;
@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addAlbumsObject:(Album *)value;
- (void)removeAlbumsObject:(Album *)value;
- (void)addAlbums:(NSSet *)values;
- (void)removeAlbums:(NSSet *)values;

- (void)addTracksObject:(Track *)value;
- (void)removeTracksObject:(Track *)value;
- (void)addTracks:(NSSet *)values;
- (void)removeTracks:(NSSet *)values;

@end
