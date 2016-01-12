//
//  ViewController.m
//  Lesson 25 HW 2
//
//  Created by Alex on 11.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    
    APOperatorsMinus,
    APOperatorsPlus,
    APOperatorsMultiplication,
    APOperatorsDivide,
    APOperatorsReset
    
} APOperators;

@interface ViewController ()

@property (strong, nonatomic) NSMutableString* tempNumberOne;
@property (assign, nonatomic) double firstNumber;
@property (assign, nonatomic) double secondNumber;
@property (assign, nonatomic) BOOL equalingDone;
@property (assign, nonatomic) APOperators operatorsEnum;
@property (assign, nonatomic) NSInteger twoActionsIsEqual;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tempNumberOne = [[NSMutableString alloc] init];
    self.operatorsEnum = APOperatorsReset;
    self.twoActionsIsEqual = 0;

    
        
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions


- (IBAction)actionNumber:(UIButton*) sender {
    
  
    

    if (self.operatorsEnum == APOperatorsReset) {
        self.secondNumber = 0;
        NSLog(@"button number - %ld pressed", sender.tag);
        [self.tempNumberOne appendString:[NSString stringWithFormat:@"%ld", sender.tag]];
        self.indicatorLabel.text = self.tempNumberOne;
        self.firstNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        
        NSLog(@"firstNumber - %.2f", self.firstNumber);
    } else {
        NSLog(@"button number - %ld pressed", sender.tag);
        [self.tempNumberOne appendString:[NSString stringWithFormat:@"%ld", sender.tag]];
        self.indicatorLabel.text = self.tempNumberOne;
        self.secondNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        
        NSLog(@"secondNumber - %.2f", self.secondNumber);
    }
    

}

- (IBAction)actionClear:(id)sender {
    
    NSLog(@"clear button pressed");
    
    [self.tempNumberOne setString:@""];
    self.operatorsEnum  = APOperatorsReset;
    self.firstNumber = 0;
    self.secondNumber = 0;
    self.indicatorLabel.text = @"0";
    self.twoActionsIsEqual = 0;

    
}

- (IBAction)actionEqual:(UIButton *)sender {
    
    
    [self equaling];
    
    self.twoActionsIsEqual = 0;
    
    
}

- (IBAction)actionOperations:(UIButton*)sender {
    
    self.twoActionsIsEqual = self.twoActionsIsEqual +1;
    
    if (self.twoActionsIsEqual > 1) {
        
        
        [self equaling];
        
    }
    
    [self showEnum:sender];
    [self.tempNumberOne setString:@""];
    
}

- (IBAction)actionPoint:(id)sender {
    
    
    
    if ([self.tempNumberOne length] == 0) {
        [self.tempNumberOne insertString:@"0." atIndex:[self.tempNumberOne length]];
    } else if (![self.tempNumberOne containsString:@"."]){
         [self.tempNumberOne insertString:@"." atIndex:[self.tempNumberOne length]];
    }
    
    self.indicatorLabel.text = self.tempNumberOne;
}

- (IBAction)actionPlusMinus:(id)sender {
    
    if (self.equalingDone == 1) {
        
        self.secondNumber =0;
        [self.tempNumberOne setString:[NSString stringWithFormat:@"%.f", self.firstNumber]];
    }
    
    self.equalingDone = 0;
    
    if (self.secondNumber == 0) { //if first number or second number we are typing
        if (self.firstNumber < 0) {
            
          
            [self.tempNumberOne deleteCharactersInRange:NSMakeRange(0, 1)]; //delete on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.firstNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
            
        } else if (self.firstNumber !=0) {
            
            [self.tempNumberOne insertString:@"-" atIndex:0];//add "-" on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.firstNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        }
    } else {
        if (self.secondNumber < 0) {
      
            [self.tempNumberOne deleteCharactersInRange:NSMakeRange(0, 1)];//delete on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.secondNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
            
        } else if (self.firstNumber !=0) {
            
            [self.tempNumberOne insertString:@"-" atIndex:0];//add "-" on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.secondNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        }
    }
    
    
}





#pragma mark - methods

- (void) equaling {
    
    NSLog(@"action = starts");
    [self.tempNumberOne setString:@""]; // dont forget to cancel label
    
    CGFloat result = 0;
    
    if (self.operatorsEnum == APOperatorsDivide) {
        result = self.firstNumber / self.secondNumber;
    } else if (self.operatorsEnum == APOperatorsMinus) {
        result = self.firstNumber - self.secondNumber;
    } else if (self.operatorsEnum == APOperatorsMultiplication) {
        result = self.firstNumber * self.secondNumber;
    } else if (self.operatorsEnum == APOperatorsPlus) {
        result = self.firstNumber + self.secondNumber;
    }
    
    [self.tempNumberOne setString:@""]; // dont forget to cancel label
    [self.tempNumberOne setString:[self floatToString:result]];
    
    self.firstNumber =result;
    
    self.indicatorLabel.text = self.tempNumberOne;
    //[self.tempNumberOne setString:@""]; // dont forget to cancel label again
    self.operatorsEnum = APOperatorsReset;
    self.equalingDone = 1; // for plusMinus
    
    NSLog(@"equal = %.2f first number - %.2f, second - %.2f",result, self.firstNumber, self.secondNumber);
}

- (void) showEnum:(UIButton*) sender {
    
    switch (sender.tag) {
        case 0:
            self.operatorsEnum = APOperatorsMinus;
            break;
            
        case 1:
            self.operatorsEnum = APOperatorsPlus;
            break;
        case 2:
            self.operatorsEnum = APOperatorsMultiplication;
            break;
        case 3:
            self.operatorsEnum = APOperatorsDivide;
            break;
        case 4:
            self.operatorsEnum = APOperatorsReset;
            break;
    }
}

//convert and elaborate CGFLoat to Nsstring
- (NSString*) floatToString:(CGFloat) floatNumber {
    
    NSInteger integerNumber = floatNumber;
    
    CGFloat difference = floatNumber - integerNumber;
    
    NSString *string;
    
    if (difference > 0) {
        
        if (integerNumber >999999999999999999) {
            
            string = @"big number";
            
        } else {
            
            string = [NSString stringWithFormat:@"%.8f",floatNumber];
        }
        
        
        if ([string length] > 10) {
            
            string = [string substringWithRange:NSMakeRange(0, 10)];
            
        }
        
        
        NSInteger indexOfRange = 10;
        
        
        while ([[string substringWithRange:NSMakeRange(indexOfRange-1, 1)] isEqualToString:@"0"]) {
            
            indexOfRange--;
        }
        string = [string substringWithRange:NSMakeRange(0, indexOfRange)];
        
        
        
    } else {
        
        if (integerNumber >999999999999999999) {
            string = @"big number";
        } else {
            string = [NSString stringWithFormat:@"%ld",integerNumber];
        }
        
    }
    
    return string;
    
}


@end
