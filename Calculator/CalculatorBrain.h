//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Yu Jiang Tham on 8/1/13.
//  Copyright (c) 2013 Yu Jiang Tham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)addValueToQueue:(NSString *)value;
- (NSString *)getEquationQueue:(bool)operatorPressed;
- (void)clearProgramStack;
- (void)clearEquationQueue;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;

@end
