//
//  PlayerView.m
//  Simple Player
//
//  Created by Wahid Chowdhury on 3/18/14.
//  Copyright (c) 2014 Spotify. All rights reserved.
//

#import "PlayerView.h"

#define TOOLBAR_HEIGHT 44.0

NSString *const placeholderText = @"Search";

@implementation PlayerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Add search bar
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.searchBar];
        UISearchBar *searchBar = self.searchBar;
        searchBar.placeholder = placeholderText;
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[searchBar]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(searchBar)];
        [self addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[searchBar(%f)]",TOOLBAR_HEIGHT]
                                                              options:0
                                                              metrics:nil
                                                                views:NSDictionaryOfVariableBindings(searchBar)];
        [self addConstraints:constraints];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
