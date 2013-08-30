//
//  Graph.h
//  Calculator
//
//  Created by Yu Jiang Tham on 8/22/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Graph;

@protocol GraphDataSource
- (NSArray *)programStackForGraph;
@end

@interface Graph : UIView 

@property (nonatomic, strong) NSMutableArray *programStack;
@property (nonatomic, weak) IBOutlet id <GraphDataSource> dataSource;

+ (void)drawGraphInRect:(CGRect)bounds
          originAtPoint:(CGPoint)axisOrigin
                  scale:(CGFloat)pointsPerUnit
              withStack:(NSMutableArray *)stack;

@end
