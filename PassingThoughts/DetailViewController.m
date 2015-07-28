//
//  DetailViewController.m
//  PassingThoughts
//
//  Created by Zane Swafford on 7/27/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

#import "DetailViewController.h"
#import <CoreData/CoreData.h> 

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UILabel *whereLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatLabel;

@property (weak, nonatomic) IBOutlet UITextField *whenTextField;
@property (weak, nonatomic) IBOutlet UITextField *whereTextField;
@property (weak, nonatomic) IBOutlet UITextView *whatTextView;

- (void)configureView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        NSDate *date = [self.detailItem valueForKey:@"when"];
        self.whenTextField.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
        
        self.whereTextField.text = [self.detailItem valueForKey:@"where"];
        self.whatTextView.text = [self.detailItem valueForKey:@"what"];
        
        [self.whatTextView becomeFirstResponder];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveContext];
}

#pragma mark - Private methods

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self.detailItem managedObjectContext];
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.whereTextField]) {
        [self.detailItem setValue:textField.text forKey:@"where"];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:self.whatTextView]) {
        [self.detailItem setValue:textView.text forKey:@"what"];
    }
}

@end
