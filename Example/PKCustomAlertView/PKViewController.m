//
//  PKViewController.m
//  PKCustomAlertView
//
//  Created by pradeep on 10/16/2015.
//  Copyright (c) 2015 pradeep. All rights reserved.
//

#import "PKViewController.h"
#import "PKAlertViewController.h"

@interface PKViewController ()

@end

@implementation PKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self showAlertView];
    [self showTableAlertView];
}

- (void)showAlertView {
    PKAlertModel *alertModel = [[PKAlertModel alloc] init];
    alertModel.alertTitle = @"Title";
    alertModel.alertMessageBody = @"Displaying custom alert!";
    alertModel.kAlertMarginOffSet = 20.0f;
    alertModel.buttonsArray = [NSMutableArray arrayWithObjects:@"Cancel", @"OK", nil];
    //    alertModel.alertType = kPKSuggestion;
    [[PKAlertViewController sharedInstance] displayAlertViewOnView:self.view withModel:alertModel andCallBack:^(id sender) {
        ;
    }];
}

- (void)showTableAlertView {
    PKAlertModel *alertModel = [[PKAlertModel alloc] init];
    alertModel.alertTableEntries = [NSMutableArray arrayWithObjects:@"iOS",@"Android", @"Blackberry", @"Windows", nil];
    alertModel.alertTableImages = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"ios"], [UIImage imageNamed:@"android"], [UIImage imageNamed:@"blackberry"],[UIImage imageNamed:@"windows"], nil];
    alertModel.shouldDisplayPreviousSelectedIndex = YES;
    alertModel.kAlertPreviousSelectedIndex = 0;
    alertModel.alertCellAccesoryImage = [UIImage imageNamed:@"tick"];
    [[PKAlertViewController sharedInstance] showAlertTableViewOn:self.view withModel:alertModel onCompletion:^(id sender) {
        ;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
