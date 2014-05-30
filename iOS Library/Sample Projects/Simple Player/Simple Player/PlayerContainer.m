//
//  PlayerContainer.m
//  Simple Player
//
//  Created by Wahid Chowdhury on 3/14/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import "PlayerContainer.h"
#import "PlayerViewController.h"

@interface PlayerContainer ()

@end

#define STATUS_BAR_HEIGHT 20.0

@implementation PlayerContainer

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    //Add the Player Viewer Controller
    UIViewController *player = [[PlayerViewController alloc] init];
    [self addChildViewController:player];
    [self.view addSubview:player.view];
    
    UIView *subview = player.view;
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[subview]|",STATUS_BAR_HEIGHT]
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(subview)];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subview)];
    [self.view addConstraints:constraints];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
