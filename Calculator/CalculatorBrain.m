//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Rhoderick Bocobo on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

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
    }
    
    [self pushOperand:result];
    return result;
}

@end
