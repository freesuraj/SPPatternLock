//
//  SPViewController.m
//  PatternLock
//
//  Created by Suraj on 14/12/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "SPViewController.h"
#import "TestViewController.h"

@interface SPViewController ()

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"set Pattern" style:UIBarButtonSystemItemAction target:self action:@selector(doPattern)];
}

- (void) doPattern
{
		TestViewController *lockVc = [[TestViewController alloc]init];
		lockVc.infoLabelStatus = InfoStatusFirstTimeSetting;
		[self.navigationController presentViewController:lockVc animated:YES completion:^{
			//
		}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
