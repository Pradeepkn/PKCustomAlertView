//
//  ViewController.h
//  PKAlert
//
//  Created by Pradeep Narendra on 10/16/15.
//  Copyright © 2015 Pradeep Narendra. All rights reserved.
//

#import "PKAlertModel.h"

@implementation PKAlertModel

- (id)init {
    self = [super init];
    if (self) {
        self.alertTitle = @"";
        self.alertMessageBody = @"";
        self.alertType = kPKConfirmationType;
        
        self.alertTableEntries = [[NSMutableArray alloc] init];
        self.alertTableImages = [[NSMutableArray alloc] init];
        
        self.alertCellImage = nil;
        self.alertCellBackgroundImage = nil;
        self.alertCellAccesoryImage = nil;
        self.isTableViewScrollEnabled = NO;
        self.isLinePresentBwTitleMessage = NO;
        
        self.kAlertViewWidthOffSet = 280.0f;
        self.kAlertMarginOffSet   = 5.0f;
        self.kAlertYOffSet        = 10.0f;
        self.kAlertXOffSet        = 20.0f;
        self.kAlertTitleHeightOffSet = 30.0f;
        self.kAlertBottomButtonContainerOffSet = 40.0f;
        self.kAlertWidthOffSet    = 0.0f;
        self.kAlertTableCellHeight = 45.0f;
        self.kAlertTitleToMessageGapOffSet = 10.0f;
        self.kAlertCenterXOffSet = 0.0f;
        self.kAlertCenterYOffSet = 0.0f;
        self.kAlertPreviousSelectedIndex = -1.0f;
        self.shouldDisplayPreviousSelectedIndex = NO;
        
        self.primaryButtonColor = [UIColor lightGrayColor];
        self.secondaryButtonColor = [UIColor redColor];
        self.primaryButtonTitleColor = [UIColor whiteColor];
        self.secondaryButtonTitleColor = [UIColor whiteColor];
        self.backGroundColor = [UIColor whiteColor];
        self.alertTitleColor = [UIColor blackColor];
        self.alertMessageColor = [UIColor blackColor];
        self.alertTableBackGroundColor = [UIColor whiteColor];
        self.alertCellBackGroundColor = [UIColor whiteColor];
        self.alertCellTitleColor = [UIColor blackColor];
        self.alertTableSeparatorColor = [UIColor grayColor];
        self.alertTableCellSelectedColor = [UIColor lightGrayColor];
        self.alertCellHighlightedTitleColor = [UIColor lightGrayColor];
        self.alertHeaderViewColor = [UIColor grayColor];
        self.alertTitleMessageLineColor = [UIColor lightGrayColor];
        self.overLayColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        
        self.buttonsArray = [[NSMutableArray alloc] initWithObjects:@"Cancel", @"OK", nil];
        self.genericFontName = @"Avenir-Light";
        self.alertTitleFont = [UIFont fontWithName:@"Avenir-Medium" size:16.0f];
        self.alertMessageFont = [UIFont fontWithName:self.genericFontName size:14.0f];
        self.alertPrimaryButtonFont = [UIFont fontWithName:self.genericFontName size:14.0f];
        self.alertSecondaryButtonFont = [UIFont fontWithName:self.genericFontName size:14.0f];
        self.alertCellTitleLabelFont = [UIFont fontWithName:self.genericFontName size:14.0f];
    }
    return self;
}

@end
