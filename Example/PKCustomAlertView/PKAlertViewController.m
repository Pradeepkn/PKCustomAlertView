//
//  ViewController.h
//  PKAlert
//
//  Created by Pradeep Narendra on 10/16/15.
//  Copyright © 2015 Pradeep Narendra. All rights reserved.
//

#import "PKAlertViewController.h"

@interface PKAlertViewController ()

@end

@implementation PKAlertViewController

+ (PKAlertViewController *)sharedInstance{
    static PKAlertViewController *sharedInstance = nil;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        sharedInstance = self.new;
    });
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - view Offset
- (CGFloat)getAlertWidth {
    CGFloat alertWidth = (self.alertModel.kAlertViewWidthOffSet - self.alertModel.kAlertWidthOffSet);
    return alertWidth;
}

- (CGFloat)getAlertHeight {
    CGFloat messageLabelWidth = ([self getAlertWidth] - self.alertModel.kAlertYOffSet);
    
    CGFloat titleHeightOffSet = [self findHeightForText:self.alertModel.alertTitle havingWidth:messageLabelWidth andFont:self.alertModel.alertTitleFont].height;
    CGFloat messageBodyHeightOffSet = [self findHeightForText:self.alertModel.alertMessageBody havingWidth:messageLabelWidth andFont:self.alertModel.alertMessageFont].height;
    
    if (self.alertModel.alertTitle.length > 0) {
        titleHeightOffSet += (self.alertModel.kAlertYOffSet * 3);
    }else {
        titleHeightOffSet += self.alertModel.kAlertMarginOffSet;
    }
    CGFloat alertHeight = titleHeightOffSet + messageBodyHeightOffSet;
    return alertHeight;
}

- (CGFloat)getAlertYOffSet {
    CGFloat alertYOffSet = ((self.view.frame.size.height / 2) - ([self getAlertHeight] / 2));
    return alertYOffSet;
}

- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}
#pragma mark -

#pragma mark - Alertdisplay
- (void)displayAlertViewOnView:(UIView *)baseView withModel:(PKAlertModel *)alertModel andCallBack:(AlertButtonAction)onButtonClick {
    self.callBackObject = onButtonClick;
    self.alertModel = alertModel;
    
    self.view.backgroundColor = self.alertModel.overLayColor;

    UIView *alertContainerView = [[UIView alloc] init];
    alertContainerView.backgroundColor = [UIColor whiteColor];
    [self addAlertMessages:alertContainerView];

    CGFloat buttonHeightOffSet = 0.0f;
    switch (self.alertModel.alertType) {
        case kPKSuggestion:
        {
            buttonHeightOffSet = [self getAlertHeight];
            [self addTapGuestureRecogniser];
        }
            break;
        case kPKInfoType:
        case kPKConfirmationType:
        {
            buttonHeightOffSet = [self getAlertHeight] + self.alertModel.kAlertBottomButtonContainerOffSet;
            [self addAlertViewButtons:alertContainerView];
        }
            break;
        default:
            break;
    }
    alertContainerView.frame = CGRectMake(0,0,[self getAlertWidth],buttonHeightOffSet);
    alertContainerView.layer.cornerRadius = 3.0f;
    alertContainerView.clipsToBounds = YES;
    [self.view addSubview:alertContainerView];
    [baseView addSubview:self.view];
    [self reframeToCenterOfView:alertContainerView];
    [self animateDisplayView:alertContainerView];
}
#pragma mark -

- (void)reframeToCenterOfView:(UIView *)alertContainerView {
    alertContainerView.center = [UIApplication sharedApplication].keyWindow.center;
    CGRect alertFrame = alertContainerView.frame;
    alertFrame.origin.x -= self.alertModel.kAlertCenterXOffSet;
    alertFrame.origin.y -= self.alertModel.kAlertCenterYOffSet;
    alertContainerView.frame = alertFrame;
}

#pragma mark - Animation of Display view
- (void)animateDisplayView:(UIView *)view {
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
    }];
}
#pragma mark - 

#pragma mark - Add Tap Guesture
- (void)addTapGuestureRecogniser {
    UITapGestureRecognizer *tapImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(removeAlertView)];
    [self.view addGestureRecognizer:tapImageRecognizer];
    tapImageRecognizer.delegate = self;
    [tapImageRecognizer setCancelsTouchesInView:NO];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    UITableView *tableView = self.alertModel.alertTableView;
    CGPoint touchPoint = [touch locationInView:tableView];
    return ![tableView hitTest:touchPoint withEvent:nil];
}
#pragma mark -

#pragma mark - Add Alert message
- (void)addAlertMessages:(UIView *)containerView {
    CGFloat messageLabelWidth = ([self getAlertWidth] - (self.alertModel.kAlertMarginOffSet * 2));
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.alertModel.kAlertMarginOffSet, 0, messageLabelWidth, self.alertModel.kAlertTitleHeightOffSet)];
    [titleLabel setText:self.alertModel.alertTitle];
    [titleLabel setTextColor:self.alertModel.alertTitleColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:self.alertModel.alertTitleFont];
    [containerView addSubview:titleLabel];
    
    if (self.alertModel.isLinePresentBwTitleMessage) {
        [self drawBottomBorderForView:titleLabel];
    }
    CGFloat messageBodyHeightOffSet = [self findHeightForText:self.alertModel.alertMessageBody havingWidth:messageLabelWidth andFont:self.alertModel.alertMessageFont].height;

    UILabel *alertMessage = [[UILabel alloc] init];
    [alertMessage sizeToFit];

    if (self.alertModel.alertTitle.length > 0) {
        alertMessage.frame = CGRectMake(self.alertModel.kAlertMarginOffSet, titleLabel.frame.size.height - self.alertModel.kAlertTitleToMessageGapOffSet, messageLabelWidth + self.alertModel.kAlertMarginOffSet, messageBodyHeightOffSet + self.alertModel.kAlertTitleHeightOffSet);
    }else{
        alertMessage.frame = CGRectMake(self.alertModel.kAlertMarginOffSet, self.alertModel.kAlertMarginOffSet, messageLabelWidth, messageBodyHeightOffSet );
    }
    
    [alertMessage setText:self.alertModel.alertMessageBody];
    [alertMessage setTextColor:self.alertModel.alertMessageColor];
    alertMessage.textAlignment = NSTextAlignmentCenter;
    alertMessage.lineBreakMode = NSLineBreakByWordWrapping;
    alertMessage.numberOfLines = 0;
    [alertMessage setFont:self.alertModel.alertMessageFont];
    [containerView addSubview:alertMessage];
}
#pragma mark -

#pragma mark - Alert Buttons
- (void)addAlertViewButtons:(UIView *)containerView{
    CGFloat buttonsWidth = [self getAlertWidth];
    CGFloat yOffSet = [self getAlertHeight];
    UIButton *primaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [primaryButton setBackgroundColor:self.alertModel.secondaryButtonColor];
    switch (self.alertModel.buttonsArray.count) {
        case 0:
        case 1:
            break;
        case 2: {
            [primaryButton setBackgroundColor:self.alertModel.primaryButtonColor];
        }
            buttonsWidth /= 2.0f;
            break;
            
        default:
            break;
    }
    primaryButton.frame = CGRectMake(0, yOffSet, buttonsWidth, self.alertModel.kAlertBottomButtonContainerOffSet);
    [primaryButton setTitle:[self.alertModel.buttonsArray firstObject] forState:UIControlStateNormal];
    [primaryButton setTitleColor:self.alertModel.primaryButtonTitleColor forState:UIControlStateNormal];
    [primaryButton.titleLabel setFont:self.alertModel.alertPrimaryButtonFont];
    [primaryButton addTarget:self action:@selector(primaryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    primaryButton.tag = kPKPrimaryButton;
    [containerView addSubview:primaryButton];
    
    if (self.alertModel.buttonsArray.count > 1) {
        UIButton *secondaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        secondaryButton.frame = CGRectMake(buttonsWidth, yOffSet, buttonsWidth, self.alertModel.kAlertBottomButtonContainerOffSet);
        [secondaryButton setTitle:[self.alertModel.buttonsArray objectAtIndex:1] forState:UIControlStateNormal];
        [secondaryButton setBackgroundColor:self.alertModel.secondaryButtonColor];
        [secondaryButton setTitleColor:self.alertModel.secondaryButtonTitleColor forState:UIControlStateNormal];
        [secondaryButton.titleLabel setFont:self.alertModel.alertSecondaryButtonFont];
        [secondaryButton addTarget:self action:@selector(secondaryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        secondaryButton.tag = kPKSecondaryButton;
        [containerView addSubview:secondaryButton];
    }
}
#pragma mark -


#pragma mark - Alert primary button - Action
- (void)primaryButtonClicked:(UIButton *)sender {
    if (self.callBackObject) {
        self.callBackObject(sender);
    }
    [self removeAlertView];
}
#pragma mark -

#pragma mark - Alert secondary button - Action
- (void)secondaryButtonClicked:(UIButton *)sender {
    if (self.callBackObject) {
        self.callBackObject(sender);
    }
    [self removeAlertView];
}
#pragma mark -

#pragma mark - Remove alert view.
- (void)removeAlertView {
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished){
        self.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        for(UIView *viewRef in self.view.subviews)
        {
            [viewRef removeFromSuperview];
        }
        [self.view removeFromSuperview];
    }];
}
#pragma mark -

- (void) showAlertTableViewOn:(UIView *)containerView withModel:(PKAlertModel *)alertModel onCompletion:(AlertTableCellSelectionAction)onCompletion {
    self.cellSelectionCallBack = onCompletion;
    self.alertModel = alertModel;
    self.view.backgroundColor = self.alertModel.overLayColor;
    self.alertModel.alertTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,[self getAlertWidth],self.alertModel.alertTableEntries.count * self.alertModel.kAlertTableCellHeight)];
    self.alertModel.alertTableView.center = [UIApplication sharedApplication].keyWindow.center;
    self.alertModel.alertTableView.delegate = self;
    self.alertModel.alertTableView.dataSource = self;
    self.alertModel.alertTableView.scrollEnabled = self.alertModel.isTableViewScrollEnabled;
    [self.view addSubview:self.alertModel.alertTableView];
    [containerView addSubview:self.view];
    [self reframeToCenterOfView:self.view];
    [self animateDisplayView:self.alertModel.alertTableView];
    [self addTapGuestureRecogniser];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.alertModel.alertTableEntries.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.alertModel.kAlertTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    tableView.separatorColor = self.alertModel.alertTableSeparatorColor;
    cell.textLabel.text = [self.alertModel.alertTableEntries objectAtIndex:indexPath.row];
    
    if ([self.alertModel.alertTableImages count] > indexPath.row) {
        cell.imageView.image = [self.alertModel.alertTableImages objectAtIndex:indexPath.row];
    }
    [self updateCellSelectedColorFor:cell andIndex:indexPath.row];
    return cell;
}

- (void)updateCellSelectedColorFor:(UITableViewCell *)cell andIndex:(NSInteger)index{
    //For iOS 8, we need the following code to set the cell separator line stretching to both left and right edge of the view.
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(preservesSuperviewLayoutMargins)]) {
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    cell.textLabel.font = self.alertModel.alertCellTitleLabelFont;
    cell.textLabel.textColor = self.alertModel.alertCellTitleColor;
    cell.backgroundColor = self.alertModel.alertCellBackGroundColor;
    cell.textLabel.highlightedTextColor = self.alertModel.alertCellHighlightedTitleColor;
    if (self.alertModel.alertCellBackgroundImage) {
        cell.backgroundColor = [UIColor colorWithPatternImage:self.alertModel.alertCellBackgroundImage];
    }
    if (self.alertModel.alertCellAccesoryImage) {
        if (self.alertModel.shouldDisplayPreviousSelectedIndex) {
            if (index == self.alertModel.kAlertPreviousSelectedIndex) {
                cell.accessoryView = [[UIImageView alloc] initWithImage:self.alertModel.alertCellAccesoryImage highlightedImage:self.alertModel.alertCellAccesoryImage];
            }else{
                cell.accessoryView = [[UIImageView alloc] initWithImage:nil highlightedImage:self.alertModel.alertCellAccesoryImage];
            }
        }else{
            cell.accessoryView = [[UIImageView alloc] initWithImage:nil highlightedImage:self.alertModel.alertCellAccesoryImage];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = self.alertModel.alertHeaderViewColor;
    return view;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    //For iOS 8, we need the following code to set the cell separator line stretching to both left and right edge of the view.
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIViewController *)getViewControllerForStoryBoard:(NSString *)storyBoardName andIdentifier:(NSString *)viewIdentifier {
    UIStoryboard *contactsStoryboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *viewController = [contactsStoryboard instantiateViewControllerWithIdentifier:viewIdentifier];
    NSArray *vcs = ((UINavigationController *)viewController).viewControllers;
    return vcs.firstObject;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row = %ld", (long)indexPath.row);
    self.cellSelectionCallBack (indexPath);
    [self removeAlertView];
}


- (void)drawBottomBorderForView:(UIView *)view {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = self.alertModel.alertTitleMessageLineColor.CGColor;
    border.frame = CGRectMake(0, view.frame.size.height - borderWidth, view.frame.size.width, view.frame.size.height);
    border.borderWidth = borderWidth;
    [view.layer addSublayer:border];
    view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
