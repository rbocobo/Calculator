//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Rhoderick Bocobo on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if(_brain == nil) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}
- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    if([self userIsInTheMiddleOfEnteringANumber])
    {
    [[self display] setText:[self.display.text stringByAppendingString:digit]];
    } else {
        self.display.text = digit;
        [self setUserIsInTheMiddleOfEnteringANumber:YES];
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:[sender currentTitle]];
    NSString *resultString = [NSString stringWithFormat:@"%g",result];
    self.display.text =resultString;
   }
- (IBAction)enterPressed {
   
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
                     

}

@end
