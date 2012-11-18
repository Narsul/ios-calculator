//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Antony Hell on 17.11.12.
//  Copyright (c) 2012 Antony Hell. All rights reserved.
//

#import "CalculatorBrain.h"
#include <math.h>

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

- (NSMutableArray *)operandStack {
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand {
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    
    [self pushOperand:result];
    
    return result;
}

- (double)performFunction:(NSString *)function {
    double result = 0;
    
    if ([function isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    } else if ([function isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    } else if ([function isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    } else if ([function isEqualToString:@"log"]) {
        result = log([self popOperand]);
    }

    [self pushOperand:result];
    
    return result;
}

- (double)pushPi {
    double result = 3.14;
    [self pushOperand:result];
    
    return result;
}



@end
