# PKCustomAlertView

[![CI Status](http://img.shields.io/travis/pradeep/PKCustomAlertView.svg?style=flat)](https://travis-ci.org/pradeep/PKCustomAlertView)
[![Version](https://img.shields.io/cocoapods/v/PKCustomAlertView.svg?style=flat)](http://cocoapods.org/pods/PKCustomAlertView)
[![License](https://img.shields.io/cocoapods/l/PKCustomAlertView.svg?style=flat)](http://cocoapods.org/pods/PKCustomAlertView)
[![Platform](https://img.shields.io/cocoapods/p/PKCustomAlertView.svg?style=flat)](http://cocoapods.org/pods/PKCustomAlertView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PKCustomAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PKCustomAlertView"
```
```ruby
#import <PKCustomAlertView/PKAlertViewController.h>
```
## Custom Alert sample code
```ruby
    PKAlertModel *alertModel = [[PKAlertModel alloc] init];
    alertModel.alertTitle = @"Title";
    alertModel.alertMessageBody = @"Displaying custom alert!";
    alertModel.kAlertMarginOffSet = 20.0f;
    alertModel.buttonsArray = [NSMutableArray arrayWithObjects:@"Cancel", @"OK", nil];
    //    alertModel.alertType = kPKSuggestion;
    [[PKAlertViewController sharedInstance] displayAlertViewOnView:self.view withModel:alertModel andCallBack:^(id sender) {
        ;
    }];
```
## Custom Table Alert sample code
```ruby
    PKAlertModel *alertModel = [[PKAlertModel alloc] init];
    alertModel.alertTableEntries = [NSMutableArray arrayWithObjects:@"iOS",@"Android", @"Blackberry", @"Windows", nil];
    alertModel.alertTableImages = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"ios"], [UIImage imageNamed:@"android"],     [UIImage imageNamed:@"blackberry"],[UIImage imageNamed:@"windows"], nil];
    alertModel.shouldDisplayPreviousSelectedIndex = YES;
    alertModel.kAlertPreviousSelectedIndex = 0;
    alertModel.alertCellAccesoryImage = [UIImage imageNamed:@"tick"];
    [[PKAlertViewController sharedInstance] showAlertTableViewOn:self.view withModel:alertModel onCompletion:^(id sender) {
        ;
    }];
```
![alt tag](http://s28.postimg.org/xyf6sev7h/Simulator_Screen_Shot_Oct_16_2015_2_51_45_PM.png)
![alt tag](http://s17.postimg.org/6kb17s65b/Simulator_Screen_Shot_Oct_16_2015_3_12_19_PM.png)
![alt tag](http://s17.postimg.org/aj88qlusf/Simulator_Screen_Shot_Oct_16_2015_3_13_40_PM.png)
![alt tag](http://s17.postimg.org/du1748a3j/Simulator_Screen_Shot_Oct_16_2015_3_40_32_PM.png)

## Author

pradeep, pradeep.nagendra@tarento.com

## License

PKCustomAlertView is available under the MIT license. See the LICENSE file for more info.
