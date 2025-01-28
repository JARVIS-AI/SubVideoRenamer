//
//  ViewController.h
//  SubVideoRenamer
//
//  Created by Jarvis on 1/27/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *pathTextField;


@property (weak) IBOutlet NSButton *mp4CheckBox;
@property (weak) IBOutlet NSButton *mkvCheckBox;
@property (weak) IBOutlet NSButton *srtCheckBox;
@property (weak) IBOutlet NSButton *assCheckBox;
@property (weak) IBOutlet NSButton *srtAssCheckBox;

@end

