//
//  MenuViewViewController.m
//  MenuView
//


#import "MenuViewViewController.h"

@interface MenuViewViewController ()

@end

@implementation MenuViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) MenuViewDelegateMethod: (MenuView *) sender {
     Menu = nil;
    NSLog(@"%@", _btnMenu.titleLabel.text);
}

- (IBAction)BtnMenu:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@" Menu 0", @" Menu 1", @" Menu 2", @" Menu 3", @" Menu 4", @" Menu 5", @" Menu 6", @" Menu 7",nil];
    if( Menu == nil) {
        CGFloat h = 200;
         Menu = [[MenuView alloc]showMenu:sender :&h :arr ];
         Menu.delegate = self;
         Menu.title = @"Select your option";
         Menu.titleFont = [UIFont systemFontOfSize:13.0];
         Menu.menuFont = [UIFont systemFontOfSize:12.0];
    }
    else {
        [Menu hideMenu];
         Menu = nil;
    }
    
}
@end
