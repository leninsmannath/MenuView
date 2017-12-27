//
//  MenuViewViewController.h
//  MenuView
//
 
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
@interface MenuViewViewController : UIViewController<MenuViewDelegate>
{
    MenuView *Menu;
}
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)BtnMenu:(id)sender;

@end
