//
//  Graph.m
//  Calculator
//
//  Created by Yu Jiang Tham on 8/22/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import "Graph.h"
#import "GraphViewController.h"
#import "AxesDrawer.h"

@implementation Graph

@synthesize programStack = _programStack;
@synthesize dataSource = _dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"InitWithCoder");
    }
    return self;
}

- (void)plotGraph:(NSArray *)programStack {
    // pop each element in the program stack that was passed from the prevous MVC
    // solve for each x along the graph line
    
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midpoint;
    midpoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midpoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGRect box;
    box.origin = midpoint;
    box.size.width = self.bounds.size.width;
    box.size.height = self.bounds.size.height;
    
    NSMutableArray *stackValue = [[NSMutableArray alloc] initWithArray:[self.dataSource programStackForGraph]];
    //NSNumber *stackCount = [[NSNumber alloc] initWithInt:stackValue.count];
    
    //NSLog([@"Graph Init: " stringByAppendingString:[[NSString alloc] initWithString:[stackCount stringValue]]]);
    
    [AxesDrawer drawAxesInRect:rect originAtPoint:midpoint scale:40.0];
    
    [[self class] drawGraphInRect:box originAtPoint:midpoint scale:40.0 withStack:stackValue];
    
    //[self plotGraph:programStack];
}

+ (void)drawGraphInRect:(CGRect)bounds originAtPoint:(CGPoint)axisOrigin scale:(CGFloat)pointsPerUnit withStack:(NSMutableArray *)stack {
    NSLog(@"drawGraphinRect ran");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, bounds.origin.x - bounds.size.width/2 - 2, axisOrigin.y);
    
    double increment = bounds.size.width/640;

    for (double x = bounds.origin.x - bounds.size.width/2 - 2; x < bounds.origin.x+bounds.size.width; x += increment) {
        NSMutableArray *stackCopy = [[NSMutableArray alloc] initWithArray:stack];
        double yValue = [GraphViewController calculateProgramStack:(-pointsPerUnit/10+x/pointsPerUnit) withStack:stackCopy];
        CGContextAddLineToPoint(context, x, -1 * pointsPerUnit * yValue +axisOrigin.y);
    }
    
    CGContextSetLineWidth(context, 3.0);
    [[UIColor blueColor] setStroke];
    CGContextStrokePath(context);
}


@end
