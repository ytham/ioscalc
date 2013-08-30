//
//  GraphViewController.m
//  Calculator
//
//  Created by Yu Jiang Tham on 8/22/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import "GraphViewController.h"
#import "Graph.h"
#import "CalculatorBrain.h"

@interface GraphViewController () <GraphDataSource>
@property (strong, nonatomic) IBOutlet Graph *graph;

@end

@implementation GraphViewController

@synthesize programStack = _programStack;
@synthesize graph = _graph;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    NSNumber *programStackCount = [[NSNumber alloc] initWithInt:self.programStack.count];
	NSString *printToConsole = [[NSString alloc] initWithString:[programStackCount stringValue]];
    NSLog([@"ViewDidLoad StackCount: " stringByAppendingString:printToConsole]);
    */
}

- (void)setGraph:(Graph *)graph {
    _graph = graph;
    self.graph.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)readProgramStack:(NSMutableArray *)inputStack {
    NSString *stack;
    for (int i = inputStack.count - 1; i > 0; i--) {
        NSString *str = [[NSString alloc] initWithString:[inputStack[i] stringValue]];
    }
    return stack;
}

- (NSArray *)programStackForGraph {
    NSLog(@"programStackForGraph ran.");
    return [self.programStack copy];
}

+ (NSMutableArray *)reverseProgramStack:(NSArray *)stack {
    //NSArray *arrayValue = [self.programStack copy];
    NSArray *reverseStack = [[stack reverseObjectEnumerator] allObjects];
    NSMutableArray *reverseMutableArray = [[NSMutableArray alloc] initWithArray:reverseStack];
    return reverseMutableArray;
}


+ (double)calculateProgramStack:(double)atXValue withStack:(NSMutableArray *)stack {
    NSMutableArray *replacedStack = [self replaceXInMutableArray:atXValue withStack:stack];
    double returnValue = [CalculatorBrain popOperandOffProgramStack:replacedStack];
    //double returnValue = [self calculateStackRecursively:replacedStack];
    return returnValue;
}

+ (double)calculateStackRecursively:(NSMutableArray *)stack {
    
    return 100;
}

+ (NSMutableArray *)replaceXInMutableArray:(double)withXValue withStack:(NSMutableArray *)stack {
    //NSMutableArray *stack = [self.programStack copy];
    for (int i = 0; i < stack.count; i++) {
        if ([stack[i] isKindOfClass:[NSString class]] && [stack[i] isEqualToString:@"x"]) {
            stack[i] = [[NSNumber alloc] initWithDouble:withXValue];
        }
    }
    return stack;
}

@end
