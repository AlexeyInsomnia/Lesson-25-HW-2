//
//  ViewController.h
//  Lesson 25 HW 2
//
//  Created by Alex on 11.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

- (IBAction)actionNumber:(id)sender;

- (IBAction)actionClear:(id)sender;

- (IBAction)actionEqual:(UIButton *)sender;

- (IBAction)actionOperations:(id)sender;

- (IBAction)actionPoint:(id)sender;

- (IBAction)actionPlusMinus:(id)sender;

@end

