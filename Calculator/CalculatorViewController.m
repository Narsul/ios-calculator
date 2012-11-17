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
@property (nonatomic) BOOL dotAlreadyExistsInANumber;
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
    self.dotAlreadyExistsInANumber =  NO;
}

- (IBAction)dotPressed {
    if (self.dotAlreadyExistsInANumber) return;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
    } else {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    self.dotAlreadyExistsInANumber = YES;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)backspacePressed {
    if (!self.userIsInTheMiddleOfEnteringANumber) return;
    
    NSUInteger displayLength = [self.display.text length];
    NSString *charToBeDeleted = [self.display.text substringFromIndex:(displayLength-1)];
    NSString *charBeforeCharToBeDeleted = [[self.display.text substringFromIndex:(displayLength-2)] substringToIndex:(displayLength-1)];
    if (displayLength == 1) {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } else {
        if ([charToBeDeleted isEqualToString:@"."]) {
            self.dotAlreadyExistsInANumber = NO;
            if ([charBeforeCharToBeDeleted isEqualToString:@"0"]) {
                self.userIsInTheMiddleOfEnteringANumber = NO;
            }
        }
        self.display.text = [self.display.text substringToIndex:(displayLength-1)];
    }
}

@end
