//
//  Album.h
//  Simple Player
//
//  Created by Wahid Chowdhury on 5/15/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist, Track;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spotifyUrl;
@property (nonatomic, retain) Artist *artist;
@property (nonatomic, retain) NSSet *tracks;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addTracksObject:(Track *)value;
- (void)removeTracksObject:(Track *)value;
- (void)addTracks:(NSSet *)values;
- (void)removeTracks:(NSSet *)values;

@end
