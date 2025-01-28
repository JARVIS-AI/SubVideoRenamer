//
//  ViewController.m
//  SubVideoRenamer
//
//  Created by Jarvis on 1/27/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#import "ViewController.h"
#import "PathManager.h"
#import "FileListViewController.h"

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
    openPanel.message = @"Open a folder containing video and SRT files.";
    
    // Display the panel and handle the result
    if ([openPanel runModal] == NSModalResponseOK) {
        NSURL *selectedFolderURL = [[openPanel URLs] firstObject];
        if (selectedFolderURL) {
            // Handle the selected folder path
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
    // Deselect all checkboxes
    [self.mp4CheckBox setState:NSControlStateValueOff];
    [self.mkvCheckBox setState:NSControlStateValueOff];
    [self.srtCheckBox setState:NSControlStateValueOff];
    [self.assCheckBox setState:NSControlStateValueOff];
    [self.srtAssCheckBox setState:NSControlStateValueOff];
    [self.mkvMp4CheckBox setState:NSControlStateValueOff];
    
    // Optionally, show a confirmation alert
//    NSAlert *alert = [[NSAlert alloc] init];
//    alert.messageText = @"Reset Successful";
//    alert.informativeText = @"All checkboxes have been deselected.";
//    [alert addButtonWithTitle:@"OK"];
//    [alert setAlertStyle:NSAlertStyleInformational];
//    [alert runModal];
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

- (IBAction)mkvMp4Box:(NSButton *)sender {
    [self resetCheckboxesExcept:sender];
}


// Helper method to reset other checkboxes
- (void)resetCheckboxesExcept:(NSButton *)selectedCheckbox {
    NSArray *checkboxes = @[self.mp4CheckBox, self.mkvCheckBox, self.srtCheckBox, self.assCheckBox, self.srtAssCheckBox, self.mkvMp4CheckBox];
    
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













- (NSComparisonResult)naturalSortComparer:(NSString *)x with:(NSString *)y {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)|(\\D+)" options:0 error:nil];
    NSArray<NSTextCheckingResult *> *xMatches = [regex matchesInString:x options:0 range:NSMakeRange(0, x.length)];
    NSArray<NSTextCheckingResult *> *yMatches = [regex matchesInString:y options:0 range:NSMakeRange(0, y.length)];
    
    NSUInteger i = 0;
    while (i < xMatches.count && i < yMatches.count) {
        NSString *xPart = [x substringWithRange:[xMatches[i] range]];
        NSString *yPart = [y substringWithRange:[yMatches[i] range]];
        
        NSInteger xNumber, yNumber;
        BOOL xIsNumber = [[NSScanner scannerWithString:xPart] scanInteger:&xNumber];
        BOOL yIsNumber = [[NSScanner scannerWithString:yPart] scanInteger:&yNumber];
        
        NSComparisonResult result;
        if (xIsNumber && yIsNumber) {
            result = (xNumber < yNumber) ? NSOrderedAscending : (xNumber > yNumber) ? NSOrderedDescending : NSOrderedSame;
        } else {
            result = [xPart caseInsensitiveCompare:yPart];
        }
        
        if (result != NSOrderedSame) {
            return result;
        }
        i++;
    }
    
    return (xMatches.count < yMatches.count) ? NSOrderedAscending : (xMatches.count > yMatches.count) ? NSOrderedDescending : NSOrderedSame;
}





//- (NSArray<NSString *> *)listFilesInDirectory:(NSString *)directoryPath withExtensions:(NSArray<NSString *> *)extensions {
//    NSMutableArray<NSString *> *filteredFiles = [NSMutableArray array];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray<NSString *> *files = [fileManager contentsOfDirectoryAtPath:directoryPath error:nil];
//
//    for (NSString *file in files) {
//        NSString *fileExtension = [[file pathExtension] lowercaseString];
//        if ([extensions containsObject:fileExtension]) {
//            [filteredFiles addObject:file];
//        }
//    }
//    return [filteredFiles copy];
//}

- (NSArray<NSString *> *)listFilesInDirectory:(NSString *)directoryPath withExtensions:(NSArray<NSString *> *)extensions {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray<NSString *> *allFiles = [fileManager contentsOfDirectoryAtPath:directoryPath error:nil];
    if (!extensions || extensions.count == 0) {
        return allFiles; // Return all files if no extensions are provided
    }
    NSMutableArray<NSString *> *filteredFiles = [NSMutableArray array];
    for (NSString *file in allFiles) {
        NSString *fileExtension = [file pathExtension].lowercaseString;
        if ([extensions containsObject:fileExtension]) {
            [filteredFiles addObject:file];
        }
    }
    return filteredFiles;
}








- (void)pathState:(BOOL)state {
    if (state) {
        NSLog(@"Path is valid and files are found.");
        // Add your logic to update the UI or state accordingly.
    } else {
        NSLog(@"Path is invalid or no files found.");
    }
}


//- (IBAction)SubmitPath:(NSButton *)sender {
//    NSString *folderPath = self.pathTextField.stringValue; // Assuming pathTextField is your text field for the folder path.
//
//    if (folderPath.length > 0) {
//        NSMutableArray<NSString *> *extensions = [NSMutableArray array];
//
//        if (self.assCheckBox.state == NSControlStateValueOn) {
//            [extensions addObject:@"ass"];
//        } else if (self.srtCheckBox.state == NSControlStateValueOn) {
//            [extensions addObject:@"srt"];
//        } else if (self.srtAssCheckBox.state == NSControlStateValueOn) {
//            [extensions addObject:@"srt"];
//            [extensions addObject:@"ass"];
//        } else if (self.mkvCheckBox.state == NSControlStateValueOn) {
//            [extensions addObject:@"mkv"];
//        } else if (self.mp4CheckBox.state == NSControlStateValueOn) {
//            [extensions addObject:@"mp4"];
//        } else if (self.mkvMp4CheckBox.state == NSControlStateValueOn) {
//            [extensions addObject:@"mkv"];
//            [extensions addObject:@"mp4"];
//        }
//
//        NSArray<NSString *> *files = [self listFilesInDirectory:folderPath withExtensions:extensions];
//        if (files.count > 0) {
//            [self pathState:YES]; // Implement pathState: as per your logic to update the UI.
//        } else {
//            NSAlert *alert = [[NSAlert alloc] init];
//            alert.messageText = @"Warning";
//            alert.informativeText = @"No files with the selected extensions were found in the folder.";
//            [alert addButtonWithTitle:@"OK"];
//            [alert setAlertStyle:NSAlertStyleWarning];
//            [alert runModal];
//        }
//    } else {
//        NSAlert *alert = [[NSAlert alloc] init];
//        alert.messageText = @"Warning";
//        alert.informativeText = @"Please select a folder path first.";
//        [alert addButtonWithTitle:@"OK"];
//        [alert setAlertStyle:NSAlertStyleWarning];
//        [alert runModal];
//    }
//}






- (IBAction)SubmitPath:(NSButton *)sender {
    NSString *folderPath = self.pathTextField.stringValue; // Assuming pathTextField is your text field for the folder path.
    
    if (folderPath.length > 0) {
        NSMutableArray<NSString *> *extensions = [NSMutableArray array];
        
        if (self.assCheckBox.state == NSControlStateValueOn) {
            [extensions addObject:@"ass"];
        } else if (self.srtCheckBox.state == NSControlStateValueOn) {
            [extensions addObject:@"srt"];
        } else if (self.srtAssCheckBox.state == NSControlStateValueOn) {
            [extensions addObject:@"srt"];
            [extensions addObject:@"ass"];
        } else if (self.mkvCheckBox.state == NSControlStateValueOn) {
            [extensions addObject:@"mkv"];
        } else if (self.mp4CheckBox.state == NSControlStateValueOn) {
            [extensions addObject:@"mp4"];
        } else if (self.mkvMp4CheckBox.state == NSControlStateValueOn) {
            [extensions addObject:@"mkv"];
            [extensions addObject:@"mp4"];
        }
        
        // Fetch files based on selected extensions or fetch all files if no extensions are selected
        NSArray<NSString *> *files;
        if (extensions.count > 0) {
            files = [self listFilesInDirectory:folderPath withExtensions:extensions];
        } else {
            files = [self listFilesInDirectory:folderPath withExtensions:nil]; // Passing nil will fetch all files
        }
        
        if (files.count > 0) {
            [self pathState:YES]; // Implement pathState: as per your logic to update the UI.
            // Store the files to be displayed in the grid view later
            self.filesToList = files;
        } else {
            NSAlert *alert = [[NSAlert alloc] init];
            alert.messageText = @"Warning";
            alert.informativeText = @"No files were found in the folder.";
            [alert addButtonWithTitle:@"OK"];
            [alert setAlertStyle:NSAlertStyleWarning];
            [alert runModal];
        }
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"Warning";
        alert.informativeText = @"Please select a folder path first.";
        [alert addButtonWithTitle:@"OK"];
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert runModal];
    }
}









// ViewController.m
- (IBAction)dataGridListFile:(NSButton *)sender {
    // Create and instantiate FileListViewController
    FileListViewController *fileListViewController = [[FileListViewController alloc] initWithNibName:@"FileListViewController" bundle:nil];
    
    // Pass the file list to the new view controller's fileList property
    fileListViewController.fileList = self.filesToList;  // filesToList in ViewController
    
    // Show the view controller (you need to show this inside a container or window)
    [self presentViewControllerAsModalWindow:fileListViewController];  // For modal presentation, or use other method depending on how you want to present
}







- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
