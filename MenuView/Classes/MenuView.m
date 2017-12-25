//
//  MenuView.m
//  MenuView
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "MenuView.h"
#import "QuartzCore/QuartzCore.h"

@interface MenuView ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation MenuView
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize delegate;

- (id)showMenu:(UIButton *)b :(CGFloat *)height :(NSArray *)arr {
    btnSender = b;
    self.table = (UITableView *)[super init];
    if (self) {
        CGRect btn = b.frame;
        self.list = [NSArray arrayWithArray:arr];
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
       
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
        tapRecognizer.delegate = self;
        [self addGestureRecognizer:tapRecognizer];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 0;
        table.backgroundColor = [UIColor lightGrayColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorInset = UIEdgeInsetsZero;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        table.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width*3/4, *height);
        table.center = self.center;
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideMenu {
    CGRect btn = btnSender.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
    
    for (UIView *subview in btnSender.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    
    [self.delegate MenuViewDelegateMethod:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = _menuFont;
    }
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width, 30)];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width, 30)];
    header.backgroundColor = [UIColor blackColor];
    title.text=self.title;
    title.textColor = [UIColor whiteColor];
    title.font = _titleFont;
    title.textAlignment = NSTextAlignmentCenter;
    [header addSubview:title];
    return  header;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideMenu];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:cell.textLabel.text forState:UIControlStateNormal];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:     (UITouch *)touch {
    if (touch.view == self)
    {
        return YES;
    }
    return NO;
}
@end

