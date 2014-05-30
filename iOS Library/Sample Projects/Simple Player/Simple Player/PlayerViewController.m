//
//  PlayerViewController.m
//  Simple Player
//
//  Created by Wahid Chowdhury on 3/13/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView {
    self.playerView = [[PlayerView alloc] init];
    self.view = self.playerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.playerView.searchBar.delegate = self;
    
    self.playbackManager = [[SPPlaybackManager alloc] initWithPlaybackSession:[SPSession sharedSession]];
    self.playbackManager.delegate = self;
    
    [self addObserver:self forKeyPath:@"currentTrack.name" options:0 context:nil];
	[self addObserver:self forKeyPath:@"currentTrack.artists" options:0 context:nil];
	[self addObserver:self forKeyPath:@"currentTrack.duration" options:0 context:nil];
	[self addObserver:self forKeyPath:@"currentTrack.album.cover.image" options:0 context:nil];
	[self addObserver:self forKeyPath:@"playbackManager.trackPosition" options:0 context:nil];
    
    self.musicDataSource = [[PlayerDataController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Dismiss keyboard on touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}



- (void)dealloc {
    //Remove observers
    [self removeObserver:self forKeyPath:@"currentTrack.name"];
    [self removeObserver:self forKeyPath:@"currentTrack.artists"];
    [self removeObserver:self forKeyPath:@"currentTrack.album.cover.image"];
    [self removeObserver:self forKeyPath:@"playbackManager.trackPosition"];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentTrack.name"]) {
    } else if ([keyPath isEqualToString:@"currentTrack.artists"]) {
    } else if ([keyPath isEqualToString:@"currentTrack.album.cover.image"]) {
    } else if ([keyPath isEqualToString:@"currentTrack.duration"]) {
    } else if ([keyPath isEqualToString:@"playbackManager.trackPosition"]) {
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
 }


#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchString = searchBar.text;
    SPSearch *searchStruct =  [SPSearch searchWithSearchQuery:searchString inSession:[SPSession sharedSession]];
    
    [SPAsyncLoading waitUntilLoaded:searchStruct timeout:10.0 then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        if (loadedItems.count > 0) {
            //Search structure is loaded. Store em in the database.
            //TODO: rather than wait for everything, as things are downloaded,
            //store them in database and update UI (don't refetch the entire DB)
            NSLog(@"The following tracks are loaded: %@", searchStruct);
            [self.musicDataSource storeAlbums:searchStruct.albums];
            [self.musicDataSource storeArtists:searchStruct.artists];
            [self.musicDataSource storeTracks:searchStruct.tracks];
            
            //for now maybe just dump the database, need DB to notify when time to reload things
        }
    }];
}

#pragma mark SPPlaybackManagerDelegate

-(void)playbackManagerWillStartPlayingAudio:(SPPlaybackManager *)aPlaybackManager {
}

//TODO: make core data database
//TODO: make collection view that pulls from the core data database


@end
