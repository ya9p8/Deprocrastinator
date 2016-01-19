//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Yemi Ajibola on 1/18/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *tasks;
@property NSMutableArray *taskColors;
//@property NSMutableArray *tasksWithAttributes;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tasks = [[NSMutableArray alloc] init];
    self.taskColors = [NSMutableArray new];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAddButtonPressed:(UIButton *)sender {

    [self.tasks addObject:self.textField.text];
    [self.taskColors addObject:self.textField.textColor];
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


- (IBAction)onSwipeRight:(UISwipeGestureRecognizer *)sender {
    //NSLog(@"Hey I can swipe: %ld", (long)sender.state);
    
    CGPoint location = [sender locationInView:self.tableView];
    //NSLog(@"I swiped right! Here is my location: %@", NSStringFromCGPoint(location));
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:location];
    
    
    
    if([self.tableView cellForRowAtIndexPath:index].backgroundColor == [UIColor greenColor])
    {
        [self.tableView cellForRowAtIndexPath:index].backgroundColor = [UIColor yellowColor];
    }
    else if([self.tableView cellForRowAtIndexPath:index].backgroundColor == [UIColor yellowColor])
    {
        [self.tableView cellForRowAtIndexPath:index].backgroundColor = [UIColor redColor];
    }
    else
    {
        [self.tableView cellForRowAtIndexPath:index].backgroundColor = [UIColor greenColor];
    }

}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *deleteConfirmation = [UIAlertController alertControllerWithTitle:@"Delete Task" message:@"Are you sure you want to delete?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteButton = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskColors removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [deleteConfirmation addAction:deleteButton];
    [deleteConfirmation addAction:cancelButton];
    [self presentViewController:deleteConfirmation animated:YES completion:nil];
    
    
    
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
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
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.taskColors objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor =[UIColor greenColor];
    [self.taskColors replaceObjectAtIndex:indexPath.row withObject:[UIColor greenColor]];
    [tableView reloadData];

}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *task = [self.tasks objectAtIndex:sourceIndexPath.row];
    [self.tasks removeObject:task];
    [self.tasks insertObject:task atIndex:destinationIndexPath.row];
    
    [self.tableView reloadData];
}

@end
