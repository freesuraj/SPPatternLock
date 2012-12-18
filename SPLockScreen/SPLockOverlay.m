//
//  SPLockOverlay.m
//  SuQian
//
//  Created by Suraj on 25/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "SPLockOverlay.h"

#define kLineColor			[UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:78.0/255.0 alpha:0.9]
#define kLineGridColor  [UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:233.0/255.0 alpha:1.0]

@implementation SPLockOverlay

@synthesize pointsToDraw;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
			self.backgroundColor = [UIColor clearColor];
			self.pointsToDraw = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGFloat lineWidth = 5.0;
	
	CGContextSetLineWidth(context, lineWidth);
	CGContextSetStrokeColorWithColor(context, kLineColor.CGColor);
    for(SPLine *line in self.pointsToDraw)
		{			
			CGContextMoveToPoint(context, line.fromPoint.x, line.fromPoint.y);
			CGContextAddLineToPoint(context, line.toPoint.x, line.toPoint.y);
			CGContextStrokePath(context);
			
			CGFloat nodeRadius = 14.0;
			
			CGRect fromBubbleFrame = CGRectMake(line.fromPoint.x- nodeRadius/2, line.fromPoint.y - nodeRadius/2, nodeRadius, nodeRadius);
			CGContextSetFillColorWithColor(context, kLineGridColor.CGColor);
			CGContextFillEllipseInRect(context, fromBubbleFrame);
			
			if(line.isFullLength){
			CGRect toBubbleFrame = CGRectMake(line.toPoint.x - nodeRadius/2, line.toPoint.y - nodeRadius/2, nodeRadius, nodeRadius);
			CGContextFillEllipseInRect(context, toBubbleFrame);
			}
		}
}
@end
