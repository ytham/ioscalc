//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Yu Jiang Tham on 8/1/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize userIsInTheMiddleOfEnteringNumber = _userIsInTheMiddleOfEnteringNumber;
@synthesize display = _display;
@synthesize equation = _equation;
@synthesize brain = _brain;

-(CalculatorBrain *)brain {
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
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
    [self.brain pushOperand:[self.display.text doubleValue]];
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
    self.equation.text = [self.brain getEquationQueue:YES];
    [self.brain clearEquationQueue];
}

- (IBAction)clearPressed:(UIButton *)sender {
    [self.brain clearProgramStack];
    [self.brain clearEquationQueue];
    self.display.text = @"0";
    self.equation.text = @"";
    self.userIsInTheMiddleOfEnteringNumber = NO;
}

@end
