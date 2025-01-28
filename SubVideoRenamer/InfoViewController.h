//
//  InfoViewController.h
//  SubVideoRenamer
//
//  Created by Jarvis on 1/28/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#ifndef InfoViewController_h
#define InfoViewController_h

// InfoViewController.h
#import <Cocoa/Cocoa.h>

@interface InfoViewController : NSViewController

@property (weak) IBOutlet NSImageView *appIconImageView;
@property (weak) IBOutlet NSTextField *appNameLabel;
@property (weak) IBOutlet NSTextField *rightsLabel;
@property (weak) IBOutlet NSTextField *copyrightLabel;
@property (weak) IBOutlet NSTextField *thanksLabel;
@property (weak) IBOutlet NSTextField *hyperlinkLabel;
@property (weak) IBOutlet NSTextField *appVersionLabel;

@end

#endif /* InfoViewController_h */
