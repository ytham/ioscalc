//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Yu Jiang Tham on 8/1/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@property (nonatomic, strong) NSMutableArray *equationQueue;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize equationQueue = _equationQueue;

- (NSMutableArray *)programStack {
    if(!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (NSMutableArray *)equationQueue {
    if(!_equationQueue) {
        _equationQueue = [[NSMutableArray alloc] init];
    }
    return _equationQueue;
}

- (id)program {
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program {
    return @"This is a calculator";
}

- (void)pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.programStack lastObject];
    if(operandObject) [self.programStack removeLastObject];
    return [operandObject doubleValue];
}

- (void)addValueToQueue:(NSString *)value {
    [self.equationQueue addObject:value];
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

- (NSString *)getEquationQueue:(bool)operatorPressed {
    NSMutableString *equationString = [[NSMutableString alloc] init];
    for(NSString *value in self.equationQueue) {
        [equationString appendString:value];
        [equationString appendString:@" "];
    }
    if(operatorPressed) {
        [equationString appendString:@"="];
    }
    return equationString;
}

- (void)clearProgramStack {
    [self.programStack removeAllObjects];
}

- (void)clearEquationQueue {
    [self.equationQueue removeAllObjects];
}

+ (void)pushToEquationQueue:(NSMutableArray *)queue {
    
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if([operation isEqualToString:@"+"]) {
            //[self.equationQueue addObject:@"+"];
            
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double secondValue = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - secondValue;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    //NSMutableArray *queue;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    //    queue = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

@end
