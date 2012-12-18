//
//  SPLine.h
//  SuQian
//
//  Created by Suraj on 25/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLine : NSObject
@property (nonatomic) CGPoint fromPoint;
@property (nonatomic) CGPoint toPoint;
@property (nonatomic) BOOL    isFullLength;		// boolean to indicate if the line is a full edge or a partial edge

- (id)initWithFromPoint:(CGPoint)A toPoint:(CGPoint)B AndIsFullLength:(BOOL)isFullLength;

@end
