//
//  ViewController.m
//  Tip Calculator
//
//  Created by Alice Park on 6/26/18.
//  Copyright © 2018 Alice Park. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mealBillField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIView *bottomView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mealBillField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)onEdit:(id)sender {
    
    
    if(self.mealBillField.text == nil) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mealBillField.frame = CGRectMake(self.mealBillField.frame.origin.x, self.mealBillField.frame.origin.y + 150, self.mealBillField.frame.size.width, self.mealBillField.frame.size.height);
            
        }];
        self.bottomView.alpha = 0;
        self.tipControl.alpha = 0;

    } else {

        if(self.mealBillField.frame.origin.y == 277) {
            [UIView animateWithDuration:0.5 animations:^{
                self.mealBillField.frame = CGRectMake(self.mealBillField.frame.origin.x, self.mealBillField.frame.origin.y - 150, self.mealBillField.frame.size.width, self.mealBillField.frame.size.height);
            }];
        }
        self.bottomView.alpha = 1;
        self.tipControl.alpha = 1;
        
        double bill = [self.mealBillField.text doubleValue];
        
        NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
        
        double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
        
        double tip = tipPercentage * bill;
        double total = bill + tip;
        
        self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
        self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];


    }


}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    double newVal = [defaults doubleForKey:@"default_tip_percentage"];
    
    self.tipControl.selectedSegmentIndex= newVal;
    
    double bill = [self.mealBillField.text doubleValue];
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}


@end
