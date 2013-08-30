//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Yu Jiang Tham on 8/1/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "Graph.h"
#import "GraphViewController.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize userIsInTheMiddleOfEnteringNumber = _userIsInTheMiddleOfEnteringNumber;
@synthesize display = _display;
@synthesize equation = _equation;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showGraphSegue"]) {
        NSArray *brainProgram = self.brain.program;
        GraphViewController *graphView = (GraphViewController *)segue.destinationViewController;
        graphView.programStack = [brainProgram copy];
    }
}

- (NSString *)showEquation {
    NSArray *programStack = [self.brain.programStack copy];
    NSString *equationStack = [programStack componentsJoinedByString:@" "];
    /*
    NSMutableString *equationStack;
    NSString *addString;
    for (int i = 0; i < programStack.count; i++) {
        if ([programStack[i] isKindOfClass:[NSString class]]) {
            addString = [NSString stringWithString:programStack[i]];
        } else {
            addString = [NSString stringWithFormat:@"%@", programStack[i]];
        }
        [equationStack appendString:addString];
    }*/
    return equationStack;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if(self.userIsInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.equation.text = [self.equation.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.equation.text = [self.equation.text stringByAppendingString:digit];
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)enterPressed {
    NSObject *pushValue;
    if ([self.display.text isEqualToString:@"x"]) {
        pushValue = @"x";
    } else {
        pushValue = [[NSNumber alloc] initWithDouble:[self.display.text doubleValue]];
    }
    [self.brain pushOperand:pushValue];
    [self.brain addValueToQueue:self.display.text];
    self.equation.text = [self.brain getEquationQueue:NO];
    self.userIsInTheMiddleOfEnteringNumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operation = sender.currentTitle;
    [self.brain addValueToQueue:operation];
    if(self.userIsInTheMiddleOfEnteringNumber) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.equation.text = [self showEquation];//[self.brain getEquationQueue:YES];
    [self.brain clearEquationQueue];
}

- (IBAction)xPressed:(UIButton *)sender {
//    [self.brain addValueToQueue:@"x"];
    self.display.text = @"x";
    [self enterPressed];
    self.equation.text = [self.brain getEquationQueue:YES];
}

- (IBAction)clearPressed:(UIButton *)sender {
    [self.brain clearProgramStack];
    [self.brain clearEquationQueue];
    self.display.text = @"0";
    self.equation.text = @"";
    self.userIsInTheMiddleOfEnteringNumber = NO;
}

@end
