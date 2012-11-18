//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Antony Hell on 17.11.12.
//  Copyright (c) 2012 Antony Hell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (double)performFunction:(NSString *)function;
- (double)pushPi;

@end
