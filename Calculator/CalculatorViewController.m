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
@property (nonatomic) BOOL decimalPointPressed;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize keyedDisplay = _keyedDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize decimalPointPressed = _decimalPointPressed;


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
    self.decimalPointPressed = NO;
    
    self.keyedDisplay.text = [self.keyedDisplay.text stringByAppendingFormat:[sender currentTitle]];
    self.keyedDisplay.text = [self.keyedDisplay.text stringByAppendingFormat:@" "];
   }

- (IBAction)enterPressed {
    
    self.keyedDisplay.text = [self.keyedDisplay.text stringByAppendingFormat:self.display.text];
    self.keyedDisplay.text = [self.keyedDisplay.text stringByAppendingFormat:@" "];
   
    if([self.display.text isEqualToString:@"π"])
    {
        [self.brain pushOperand:3.1416];
    }
    else {
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
    

}

- (IBAction)decimalPressed:(UIButton *)sender {
    if(self.decimalPointPressed == NO)
    {
        if(self.userIsInTheMiddleOfEnteringANumber == NO)
        {
            [self.display setText:[self.display.text stringByAppendingFormat:@"."]];
        }
        else {
            [self.display setText:[self.display.text stringByAppendingFormat:@"."]];
        }
        self.decimalPointPressed = YES;
    }
    self.userIsInTheMiddleOfEnteringANumber = YES;
    
}

- (IBAction)piPressed {
    if(self.userIsInTheMiddleOfEnteringANumber == NO)
    {
        [self.display setText:@"π"];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed {
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.display setText:@"0"];
    self.decimalPointPressed = NO;
    [self.keyedDisplay setText:@""];
}


- (void)viewDidUnload {
    [self setKeyedDisplay:nil];
    [super viewDidUnload];
}
@end
