//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Antony Hell on 07.11.12.
//  Copyright (c) 2012 Antony Hell. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)dotPressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        NSRange rangeOfDotCharInString = [self.display.text rangeOfString:@"."];
        // if there is already dot in the number, do nothing
        if (rangeOfDotCharInString.location != NSNotFound) return;
        self.display.text = [self.display.text stringByAppendingString:@"."];
    } else {
        // if user just clicked enter of operation, then we should start from new number
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)functionPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *function = [sender currentTitle];
    double result = [self.brain performFunction:function];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)piPressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    double result = [self.brain pushPi];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)backspacePressed {
    if (!self.userIsInTheMiddleOfEnteringANumber) return;
    
    NSUInteger displayLength = [self.display.text length];
    NSString *charBeforeCharToBeDeleted = [self.display.text substringWithRange:NSMakeRange(displayLength - 2, 1)];
    // if number is one digit in size, thrn after romoving it we should treat it as a new number
    if (displayLength == 1) {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } else {
        // if there is only one symbol left and it's a "0" then we sgould treat it as a new number
        if (displayLength == 2 && [charBeforeCharToBeDeleted isEqualToString:@"0"]) {
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
        self.display.text = [self.display.text substringToIndex:(displayLength-1)];
    }
}

@end
