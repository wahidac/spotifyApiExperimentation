//
//  PlayerViewController.h
//  Simple Player
//
//  Created by Wahid Chowdhury on 3/13/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
#import "CocoaLibSpotify.h"
#import "PlayerDataController.h"
#import "MusicDataSource.h"


@interface PlayerViewController : UIViewController <UISearchBarDelegate, SPPlaybackManagerDelegate>

@property (nonatomic,strong) PlayerView *playerView;
@property (nonatomic, strong) SPTrack *currentTrack;
@property (nonatomic, strong) SPPlaybackManager *playbackManager;
@property (nonatomic, strong) PlayerDataController *playerDataController;
@property (nonatomic, strong) id<MusicDataSource> musicDataSource;

 - (IBAction)playTrack:(id)sender;
 - (IBAction)setTrackPosition:(id)sender;
 - (IBAction)setVolume:(id)sender;

@end
