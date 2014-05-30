//
//  PlayerDataController.m
//  Simple Player
//
//  Created by Wahid Chowdhury on 4/7/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import "PlayerDataController.h"
#import "CocoaLibSpotify.h"
#import <CoreData/NSEntityDescription.h>
#import "Album.h"
#import "Artist.h"
#import "Track.h"

NSString * const ManagedDocumentName = @"SpotifyMusic";

@interface PlayerDataController()

@property (nonatomic, strong) UIManagedDocument *managedDocument;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation PlayerDataController


- (id)init {    
    self = [super init];
    if (self) {
        [self initializeManagedDocument];
    }
    return self;
}


#pragma mark private methods

- (void)initializeManagedDocument {
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:ManagedDocumentName];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              if (success) {
                  self.managedObjectContext = document.managedObjectContext;
              }
          }];
    } else if (document.documentState == UIDocumentStateClosed) {
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = document.managedObjectContext;
            }
        }];
    } else {
        self.managedObjectContext = document.managedObjectContext;
    }
}



#pragma mark MusicDataSource delegate methods

// Note: Completion doesn't imply the structures are fully intiatilized,
// it may take some time before everything reaches a consistent state

/*  Artist: name, spotifyUrl */
- (void)createArtist:(SPArtist *)spArtist completionBlock:(void (^)(Artist *artist))completion {
    SPDispatchAsync(^{
        NSError *err;
        NSString *spotifyUrl = [NSString stringWithContentsOfURL:spArtist.spotifyURL encoding:NSUTF8StringEncoding error:&err];
        NSArray *res = [self fetchEntity:[Artist class]
                               predicate:[NSPredicate predicateWithFormat:@"spotifyUrl = %@", spotifyUrl]
                         sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        if (res.count > 0) {
            Artist *a = res[0];
            completion(a);
            return;
        }
        
        Artist *artist = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Artist class]) inManagedObjectContext:self.managedObjectContext];
        artist.name = spArtist.name;
        artist.spotifyUrl = spotifyUrl;
        
        //TODO: tracks empty now, albums empty now
        completion(artist);
    });
}

/* Album: artist, name, spotifyUrl */
- (void)createAlbum:(SPAlbum *)spAlbum completionBlock:(void (^)(Album *album))completion {
    SPDispatchAsync(^{
        NSError *err;
        NSString *spotifyUrl = [NSString stringWithContentsOfURL:spAlbum.spotifyURL encoding:NSUTF8StringEncoding error:&err];
        NSArray *res = [self fetchEntity:[Album class]
                               predicate:[NSPredicate predicateWithFormat:@"spotifyUrl = %@", spotifyUrl]
                         sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        if (res.count > 0) {
            Album *a = res[0];
            completion(a);
            return;
        }

        //TODO: do check if in already? check out documentation on better ways to do this
        Album *album = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Album class]) inManagedObjectContext:self.managedObjectContext];
        album.name = spAlbum.name;
        album.spotifyUrl = spotifyUrl;

        SPArtist *spArtist = spAlbum.artist;
        [self createArtist:spArtist completionBlock:^(Artist *artist) {
                album.artist = artist;
        }];
        
        //TODO: Leave tracks empty now, need to make API call for em though
        completion(album);
    });
}


/* Track: artists, album, name, spotifyUrl */
- (void)createTrack:(SPTrack *)spTrack completionBlock:(void (^)(Track *track))completion  {
    SPDispatchAsync(^{
        NSError *err;
        NSString *spotifyUrl = [NSString stringWithContentsOfURL:spTrack.spotifyURL encoding:NSUTF8StringEncoding error:&err];
        NSArray *res = [self fetchEntity:[Track class]
                               predicate:[NSPredicate predicateWithFormat:@"spotifyUrl = %@", spotifyUrl]
                         sortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        if (res.count > 0) {
            Track *t = res[0];
            completion(t);
            return;
        }
        
        //TODO: do check if in already? check out documentation on better ways to do thiss
        Track *track = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Track class]) inManagedObjectContext:self.managedObjectContext];
        track.name = spTrack.name;
        track.spotifyUrl = [NSString stringWithContentsOfURL:spTrack.spotifyURL encoding:NSUTF8StringEncoding error:&err];
        
        NSArray *spArtists = spTrack.artists;
        for (SPArtist *spArtist in spArtists) {
            [self createArtist:spArtist completionBlock:^(Artist *artist) {
                [track addArtistsObject:artist];
            }];
        }
    
        //Add the album
        SPAlbum *spAlbum = spTrack.album;
        [self createAlbum:spAlbum completionBlock:^(Album *album) {
            track.album = album;
        }];
        
        completion(track);
    });
}


- (void)storeArtists:(NSArray *)artists {
    for (id item in artists) {
        if ([item isKindOfClass:[SPArtist class]]) {
            // Create em
            [self createArtist:item completionBlock:nil];
        }
    }
}

- (void)storeTracks:(NSArray *)tracks {
    for (id item in tracks) {
        if ([item isKindOfClass:[SPTrack class]]) {
            // Create em
            [self createTrack:item completionBlock:nil];
        }
    }
}


- (void)storeAlbums:(NSArray *)albums {
    for (id item in albums) {
        if ([item isKindOfClass:[SPAlbum class]]) {
            // Create em
            [self createAlbum:item completionBlock:nil];
        }
    }
}

                    
- (NSArray *)fetchEntity:(Class)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)descriptors  {
    //Fetch artists
    NSString *classAsString = NSStringFromClass(entity);

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:classAsString];
    request.sortDescriptors = descriptors;
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *matches = [self.managedObjectContext executeFetchRequest:request error:&error];

    return matches;
}


@end
