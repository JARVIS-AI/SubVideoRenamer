//
//  InfoViewController.m
//  SubVideoRenamer
//
//  Created by Jarvis on 1/28/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InfoViewController.h"

@interface InfoViewController ()
@end






@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the app icon
    self.appIconImageView.image = [NSImage imageNamed:@"AppIcon"]; // Replace with your app icon asset name
    
    // Set labels
    self.appNameLabel.stringValue = @"Sub Video Renamer";
    self.appNameLabel.alignment = NSTextAlignmentCenter;
    
    self.appVersionLabel.stringValue = @"1.1.2";
    self.appVersionLabel.alignment = NSTextAlignmentCenter;
    
    self.rightsLabel.stringValue = @"All rights reserved by JARVIS-AI\nDesigned and coded by JARVIS-AI";
    self.rightsLabel.alignment = NSTextAlignmentCenter;
    
    self.copyrightLabel.stringValue = @"Copyright MIT © 2024";
    self.copyrightLabel.alignment = NSTextAlignmentCenter;
    
    self.thanksLabel.stringValue = @"Thanks for using!";
    self.thanksLabel.alignment = NSTextAlignmentCenter;
    
    // Set hyperlink
    NSMutableAttributedString *hyperlink = [[NSMutableAttributedString alloc] initWithString:@"Home Page"];
    [hyperlink beginEditing];
    [hyperlink addAttribute:NSLinkAttributeName
                      value:@"https://github.com/JARVIS-AI/SubVideoRenamer"
                      range:NSMakeRange(0, hyperlink.length)];
    [hyperlink addAttribute:NSForegroundColorAttributeName
                      value:[NSColor systemBlueColor]
                      range:NSMakeRange(0, hyperlink.length)];
    [hyperlink addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:NSMakeRange(0, hyperlink.length)];
    [hyperlink endEditing];
    
    self.hyperlinkLabel.attributedStringValue = hyperlink;
    self.hyperlinkLabel.alignment = NSTextAlignmentCenter;
}

@end
