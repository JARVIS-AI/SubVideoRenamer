//
//  ViewController.m
//  SubVideoRenamer
//
//  Created by Jarvis on 1/27/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#import "ViewController.h"
#import "PathManager.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}







- (IBAction)AlwaysOnTopCheck:(NSButton *)sender {
    if (sender.state == NSControlStateValueOn) {
        // Set the window to always stay on top
        [self.view.window setLevel:NSFloatingWindowLevel];
    } else {
        // Reset the window to the default level
        [self.view.window setLevel:NSNormalWindowLevel];
    }
}










- (IBAction)InfoBTN:(NSButton *)sender {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSViewController *infoVC = [storyboard instantiateControllerWithIdentifier:@"InfoViewController"];
    [self presentViewControllerAsModalWindow:infoVC];
}










- (IBAction)OpenFolder:(NSButton *)sender {
    // Create an Open Panel for selecting a folder
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:NO];        // Only allow selecting folders
    [openPanel setCanChooseDirectories:YES];
    [openPanel setAllowsMultipleSelection:NO]; // Single folder selection
    
    // Display the panel and handle the result
    if ([openPanel runModal] == NSModalResponseOK) {
        NSURL *selectedFolderURL = [[openPanel URLs] firstObject];
        if (selectedFolderURL) {
            // Do something with the selected folder path
//            NSLog(@"Selected folder: %@", selectedFolderURL.path);
            [self PathFolderViewWithPath:selectedFolderURL.path];
        }
    }
}








// Custom method to update the NSTextField with the selected folder path
- (void)PathFolderViewWithPath:(NSString *)folderPath {
    // Assuming you have an IBOutlet for your NSTextField named `pathTextField`
    self.pathTextField.stringValue = folderPath;
}








- (IBAction)PathFolderView:(NSTextField *)sender {
    // This can stay empty if the path is updated via the method above
}








- (IBAction)CleanBTN:(NSButton *)sender {
    // Clear the text field
    self.pathTextField.stringValue = @"";
    
    // Show a popup dialog
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Folder Path Cleared";
    alert.informativeText = @"Please choose a folder again.";
    [alert addButtonWithTitle:@"OK"];
    [alert setAlertStyle:NSAlertStyleWarning];
    
    // Display the alert and wait for user response
    [alert runModal];
    
    // Call OpenFolder to prompt user to choose a folder again
    [self OpenFolder:nil];
}










- (IBAction)clipBoardPath:(NSButton *)sender {
    // Get the clipboard contents
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString *clipboardContent = [pasteboard stringForType:NSPasteboardTypeString];
    
    if (clipboardContent) {
        // Validate if the clipboard content is a valid path
        BOOL isDir = NO;
        BOOL pathExists = [[NSFileManager defaultManager] fileExistsAtPath:clipboardContent isDirectory:&isDir];
        
        if (pathExists && isDir) {
            // Set the valid path to the text field
            self.pathTextField.stringValue = clipboardContent;
            NSAlert *alert = [[NSAlert alloc] init];
            alert.messageText = @"Path Got set";
            alert.informativeText = @"Your path from Clipboard got set!";
            [alert addButtonWithTitle:@"OK"];
            [alert setAlertStyle:NSAlertStyleInformational];
            [alert runModal];
        } else {
            // Show an alert if the clipboard content is not a valid path
            NSAlert *alert = [[NSAlert alloc] init];
            alert.messageText = @"Invalid Path";
            alert.informativeText = @"The clipboard does not contain a valid folder path.";
            [alert addButtonWithTitle:@"OK"];
            [alert setAlertStyle:NSAlertStyleCritical];
            [alert runModal];
        }
    } else {
        // Show an alert if the clipboard is empty or doesn't contain a string
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"Clipboard Empty";
        alert.informativeText = @"The clipboard does not contain any text.";
        [alert addButtonWithTitle:@"OK"];
        [alert setAlertStyle:NSAlertStyleCritical];
        [alert runModal];
    }
}




- (IBAction)ResetStateBTN:(NSButton *)sender {
}







- (IBAction)mp4Box:(NSButton *)sender {
    [self resetCheckboxesExcept:sender];
}

- (IBAction)mkvBox:(NSButton *)sender {
    [self resetCheckboxesExcept:sender];
}

- (IBAction)srtBox:(NSButton *)sender {
    [self resetCheckboxesExcept:sender];
}

- (IBAction)assBox:(NSButton *)sender {
    [self resetCheckboxesExcept:sender];
}

- (IBAction)srtAssBox:(NSButton *)sender {
    [self resetCheckboxesExcept:sender];
}

// Helper method to reset other checkboxes
- (void)resetCheckboxesExcept:(NSButton *)selectedCheckbox {
    NSArray *checkboxes = @[self.mp4CheckBox, self.mkvCheckBox, self.srtCheckBox, self.assCheckBox, self.srtAssCheckBox];
    
    for (NSButton *checkbox in checkboxes) {
        if (checkbox != selectedCheckbox) {
            [checkbox setState:NSControlStateValueOff]; // Uncheck all except the selected one
        }
    }
}






//- (IBAction)OpenPathBTN:(NSButton *)sender {
//    NSString *chosenPath = self.pathTextField.stringValue;
//
//    // Check if the path is valid and exists
//    BOOL isDir;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:chosenPath isDirectory:&isDir] && isDir) {
//        // Open the directory in Finder
//        [[NSWorkspace sharedWorkspace] openFile:chosenPath];
//    } else {
//        // Show an alert if the path is invalid
//        NSAlert *alert = [[NSAlert alloc] init];
//        alert.messageText = @"Invalid Path";
//        alert.informativeText = @"The chosen path does not exist or is not a directory.";
//        [alert addButtonWithTitle:@"OK"];
//        [alert setAlertStyle:NSAlertStyleCritical];
//        [alert runModal];
//    }
//}










- (IBAction)OpenPathBTN:(NSButton *)sender {
    NSString *chosenPath = self.pathTextField.stringValue;
    
    if ([PathManager openPath:chosenPath]) {
        // Successfully opened the path
        [PathManager showAlertWithMessage:@"Path Opened"
                                     info:@"The chosen path has been opened in Finder."
                                    style:NSAlertStyleInformational];
    } else {
        // Invalid path
        [PathManager showAlertWithMessage:@"Invalid Path"
                                     info:@"The chosen path does not exist or is not a directory."
                                    style:NSAlertStyleCritical];
    }
}












- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
