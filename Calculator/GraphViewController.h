//
//  GraphViewController.h
//  Calculator
//
//  Created by Yu Jiang Tham on 8/22/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"

@interface GraphViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *programStack;

+ (double)calculateProgramStack:(double)atXValue withStack:(NSMutableArray *)stack;

@end
