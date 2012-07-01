//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Rhoderick Bocobo on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack{
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
        
}

- (void)pushOperand:(double)operand
{
    [[self operandStack] addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    
    if(operandObject)[self.operandStack removeLastObject];
    
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation{
    double result = 0;
    //calculate result
    if([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }else if([operation isEqualToString:@"-"]){
        result = [self popOperand] - [self popOperand];
    }else if([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    }else if([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    }else if([operation isEqualToString:@"π"]){
        result = 3.14159265;
    }else if([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
        
    }else if([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
        
    }else if([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
        
    }
    
    
    [self pushOperand:result];
    return result;
}



@end
