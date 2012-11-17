//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Antony Hell on 07.11.12.
//  Copyright (c) 2012 Antony Hell. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@end

@implementation CalculatorViewController

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    self.display.text = [self.display.text stringByAppendingString:digit];
}

@end
