//
//  SPLine.m
//  SuQian
//
//  Created by Suraj on 25/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "SPLine.h"

@implementation SPLine

- (id)initWithFromPoint:(CGPoint)A toPoint:(CGPoint)B AndIsFullLength:(BOOL)isFullLength;
{
	self.fromPoint = A;
	self.toPoint = B;
	self.isFullLength = isFullLength;
	return self;
}

@end
