//
//  NLCropViewLayer.m
//  NLImageCropper
//
// Copyright © 2012, Mirza Bilal (bilal@mirzabilal.com)
// All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1.	Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
// 2.	Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution.
// 3.	Neither the name of Mirza Bilal nor the names of its contributors may be used
//       to endorse or promote products derived from this software without specific
//       prior written permission.
// THIS SOFTWARE IS PROVIDED BY MIRZA BILAL "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MIRZA BILAL BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NLCropViewLayer.h"
#import <QuartzCore/QuartzCore.h>


@implementation NLCropViewLayer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cropRect = CGRectMake(0, 0, 0, 0);
    }
    leftTopCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner.png"]];
    leftTopCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    leftTopCorner.layer.shadowOffset = CGSizeMake(1, 1);
    leftTopCorner.layer.shadowOpacity = 0.6;
    leftTopCorner.layer.shadowRadius = 1.0;
    
    leftBottomCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner.png"]];
    leftBottomCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    leftBottomCorner.layer.shadowOffset = CGSizeMake(1, 1);
    leftBottomCorner.layer.shadowOpacity = 0.6;
    leftBottomCorner.layer.shadowRadius = 1.0;
    
    rightTopCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner.png"]];
    rightTopCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    rightTopCorner.layer.shadowOffset = CGSizeMake(1, 1);
    rightTopCorner.layer.shadowOpacity = 0.6;
    rightTopCorner.layer.shadowRadius = 1.0;
    
    rightBottomCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corner.png"]];
    rightBottomCorner.layer.shadowColor = [UIColor blackColor].CGColor;
    rightBottomCorner.layer.shadowOffset = CGSizeMake(1, 1);
    rightBottomCorner.layer.shadowOpacity = 0.6;
    rightBottomCorner.layer.shadowRadius = 1.0;
    
    [self addSubview:leftTopCorner];
    [self addSubview:leftBottomCorner];
    [self addSubview:rightTopCorner];
    [self addSubview:rightBottomCorner];
    
    return self;
}

- (void)setCropRegionRect:(CGRect)cropRect
{
    _cropRect = cropRect;
    
    leftTopCorner.center = _cropRect.origin;
    leftBottomCorner.center = CGPointMake(_cropRect.origin.x , _cropRect.origin.y + _cropRect.size.height);
    rightTopCorner.center = CGPointMake(_cropRect.origin.x + _cropRect.size.width , _cropRect.origin.y);
    rightBottomCorner.center = CGPointMake(_cropRect.origin.x + _cropRect.size.width , _cropRect.origin.y + _cropRect.size.height);
}

-(void) drawRect:(CGRect)rect2
{
    [super drawRect:rect2];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = _cropRect;
    
    
    
    CGContextSetRGBFillColor(context,   0.0, 0.0, 0.0, 0.7);
    CGContextSetRGBStrokeColor(context, 0.6, 0.6, 0.6, 1.0);
    
    
    CGFloat lengths[2];
    lengths[0] = 0.0;
    lengths[1] = 3.0 * 2;
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3.0);
    CGContextSetLineDash(context, 0.0f, lengths, 2);
    
    
    float w = self.bounds.size.width;
    float h = self.bounds.size.height;
    
    CGRect clips2[] =
	{
        CGRectMake(0, 0, w, rect.origin.y),
        CGRectMake(0, rect.origin.y,rect.origin.x, rect.size.height),
        CGRectMake(0, rect.origin.y + rect.size.height, w, h-(rect.origin.y+rect.size.height)),
        CGRectMake(rect.origin.x + rect.size.width, rect.origin.y, w-(rect.origin.x + rect.size.width), rect.size.height),
	};
    CGContextClipToRects(context, clips2, sizeof(clips2) / sizeof(clips2[0]));
    
    CGContextFillRect(context, self.bounds);
    CGContextStrokeRect(context, rect);
    UIGraphicsEndImageContext();
}

@end
