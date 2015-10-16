//
//  ViewController.h
//  PKAlert
//
//  Created by Pradeep Narendra on 10/16/15.
//  Copyright © 2015 Pradeep Narendra. All rights reserved.
//

/*!
 @discussion Custom Alert model class. Using this class we can set Alert properties like
 Alert background color, Title, Message, Buttons color, text etc.,
 
 ## Version information
 
 __Version__: 1.0
 
 __Found__: 10/06/15
 
 __Last update__: 10/06/15
 
 __Developer__: Pradeep, Tarento Technologies Pvt Ltd.
 
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Enum to identify or selection of Different Alert types
typedef NS_ENUM(NSInteger, VKAlertType) {
    kPKSuggestion = 0,
    kPKInfoType,
    kPKConfirmationType
};

// Enum to identify button action type
typedef NS_ENUM(NSInteger, VKAlertButtonType) {
    kPKPrimaryButton = 0,
    kPKSecondaryButton
};

@interface PKAlertModel : NSObject

@property (nonatomic, assign) VKAlertType alertType;

// Alert button array. Based on it user can draw multiple number of buttons. Now limited to 2.
@property (nonatomic, strong) NSMutableArray *buttonsArray;

// NSString alertTitle
@property (nonatomic, strong) NSString *alertTitle;
// NSString alertMessageBody
@property (nonatomic, strong) NSString *alertMessageBody;

@property (nonatomic, strong) UIColor *overLayColor;

// Alert view subvies color properties
@property (nonatomic, strong) UIColor *primaryButtonColor;
@property (nonatomic, strong) UIColor *secondaryButtonColor;
@property (nonatomic, strong) UIColor *backGroundColor;
@property (nonatomic, strong) UIColor *alertTitleColor;
@property (nonatomic, strong) UIColor *alertMessageColor;
@property (nonatomic, strong) UIColor *primaryButtonTitleColor;
@property (nonatomic, strong) UIColor *secondaryButtonTitleColor;

// Alert view button, text font properties
@property (nonatomic, strong) UIFont *alertTitleFont;
@property (nonatomic, strong) UIFont *alertMessageFont;
@property (nonatomic, strong) UIFont *alertPrimaryButtonFont;
@property (nonatomic, strong) UIFont *alertSecondaryButtonFont;
@property (nonatomic, strong) NSString *genericFontName;
// Alert view with table view as subview.

// Alertview model object
@property (nonatomic, strong) UITableView *alertTableView;

@property (nonatomic, strong) NSMutableArray *alertTableEntries;
@property (nonatomic, strong) NSMutableArray *alertTableImages;

@property (nonatomic, strong) UIColor *alertTableBackGroundColor;
@property (nonatomic, strong) UIColor *alertHeaderViewColor;
@property (nonatomic, strong) UIColor *alertCellBackGroundColor;
@property (nonatomic, strong) UIColor *alertCellTitleColor;
@property (nonatomic, strong) UIColor *alertTableSeparatorColor;
@property (nonatomic, strong) UIColor *alertTableCellSelectedColor;
@property (nonatomic, strong) UIColor *alertCellHighlightedTitleColor;
@property (nonatomic, strong) UIColor *alertTitleMessageLineColor;

@property (nonatomic, strong) UIFont *alertCellTitleLabelFont;

@property (nonatomic, strong) UIImage *alertCellImage;
@property (nonatomic, strong) UIImage *alertCellBackgroundImage;
@property (nonatomic, strong) UIImage *alertCellAccesoryImage;

@property (nonatomic, assign) BOOL isTableViewScrollEnabled;
@property (nonatomic, assign) BOOL isLinePresentBwTitleMessage;

@property (nonatomic, assign) NSInteger kAlertViewWidthOffSet;

@property (nonatomic, assign) NSInteger kAlertMarginOffSet;
@property (nonatomic, assign) NSInteger kAlertTitleToMessageGapOffSet;
@property (nonatomic, assign) NSInteger kAlertYOffSet;
@property (nonatomic, assign) NSInteger kAlertXOffSet;
@property (nonatomic, assign) NSInteger kAlertTitleHeightOffSet;
@property (nonatomic, assign) NSInteger kAlertBottomButtonContainerOffSet;
@property (nonatomic, assign) NSInteger kAlertWidthOffSet;
@property (nonatomic, assign) NSInteger kAlertTableCellHeight;
@property (nonatomic, assign) NSInteger kAlertCenterXOffSet;
@property (nonatomic, assign) NSInteger kAlertCenterYOffSet;

@property (nonatomic, assign) NSInteger kAlertPreviousSelectedIndex;
@property (nonatomic, assign) BOOL shouldDisplayPreviousSelectedIndex;

@end
