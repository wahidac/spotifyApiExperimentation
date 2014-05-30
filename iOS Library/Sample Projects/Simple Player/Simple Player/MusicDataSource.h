//
//  MusicDataSource.h
//  Simple Player
//
//  Created by Wahid Chowdhury on 4/7/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MusicDataSource <NSObject>

//Methods to retrieve data for albums, artists, tracks at given index paths so
//we can use this as delegate to the collection view. Arrays will be Spotify structs,
//up to data controller to set up object graph
- (void)storeAlbums:(NSArray *)albums ;
- (void)storeArtists:(NSArray *)artists;
- (void)storeTracks:(NSArray *)tracks;

@end