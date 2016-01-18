//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Yemi Ajibola on 1/18/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *tasks;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tasks = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddButtonPressed:(UIButton *)sender {
    [self.tasks addObject:self.textField.text];
   // NSLog(@"Added object to tasks array: %@", self.tasks );
    self.textField.text = @"";
    [self.view endEditing:YES];
    [self.tableView reloadData];
    
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (self.editing)
    {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }
    else
    {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }

}










-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textField = textField;
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.textField.text 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    //NSLog(@"Object at index %li, : %@", indexPath.row, [self.tasks objectAtIndex:indexPath.row]);
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor greenColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setTextColor:[UIColor greenColor]];
    
    [tableView reloadData];
    
    
    
}

@end
