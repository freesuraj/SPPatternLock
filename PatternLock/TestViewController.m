//
//  TestViewController.m
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "TestViewController.h"
#import "NormalCircle.h"


@interface TestViewController ()<LockScreenDelegate>

@property (nonatomic) NSInteger wrongGuessCount;
@end

@implementation TestViewController
@synthesize infoLabelStatus,wrongGuessCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}


- (void)viewDidAppear:(BOOL)animated
{	
	[super viewDidAppear:animated];
	
	self.lockScreenView = [[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
	self.lockScreenView.center = self.view.center;
	self.lockScreenView.delegate = self;
	self.lockScreenView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.lockScreenView];
	
	self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
	self.infoLabel.backgroundColor = [UIColor clearColor];
	self.infoLabel.font = [UIFont systemFontOfSize:16];
	self.infoLabel.textColor = [UIColor whiteColor];
	self.infoLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.infoLabel];
	
	[self updateOutlook];
	 
	
	// Test with Circular Progress
}


- (void)updateOutlook
{
	switch (self.infoLabelStatus) {
		case InfoStatusFirstTimeSetting:
			self.infoLabel.text = @"Set a Pattern !";
			break;
		case InfoStatusConfirmSetting:
			self.infoLabel.text = @"Confirm the Pattern !";
			break;
		case InfoStatusFailedConfirm:
			self.infoLabel.text = @"Failed to confirm, please retry";
			break;
		case InfoStatusNormal:
			self.infoLabel.text = @"Draw previously set pattern to go in";
			break;
		case InfoStatusFailedMatch:
			self.infoLabel.text = [NSString stringWithFormat:@"Wrong Guess # %d, try again !",self.wrongGuessCount];
			break;
		case InfoStatusSuccessMatch:
			self.infoLabel.text = @"Welcome !";
			break;
			
		default:
			break;
	}
	
}


#pragma -LockScreenDelegate

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
	NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
	NSLog(@"self status: %d",self.infoLabelStatus);
	switch (self.infoLabelStatus) {
		case InfoStatusFirstTimeSetting:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusFailedConfirm:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusConfirmSetting:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPatternTemp]]) {
				[stdDefault setValue:patternNumber forKey:kCurrentPattern];
				[self dismissViewControllerAnimated:YES completion:nil];
			}
			else {
				self.infoLabelStatus = InfoStatusFailedConfirm;
				[self updateOutlook];
			}
			break;
		case  InfoStatusNormal:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]]) [self dismissViewControllerAnimated:YES completion:nil];
			else {
				self.infoLabelStatus = InfoStatusFailedMatch;
				self.wrongGuessCount ++;
				[self updateOutlook];
			}
			break;
		case InfoStatusFailedMatch:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]]) [self dismissViewControllerAnimated:YES completion:nil];
			else {
				self.wrongGuessCount ++;
				self.infoLabelStatus = InfoStatusFailedMatch;
				[self updateOutlook];
			}
			break;
		case InfoStatusSuccessMatch:
			[self dismissViewControllerAnimated:YES completion:nil];
			break;
			
		default:
			break;
	}
}

- (void)viewDidUnload {
	[self setInfoLabel:nil];
	[self setLockScreenView:nil];
	[super viewDidUnload];
}
@end
