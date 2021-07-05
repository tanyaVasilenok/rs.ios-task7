//
//  SecureCodeViewController.m
//  AuthorizationApp
//
//  Created by Таня Василёнок on 5.07.21.
//

#import "SecureCodeViewController.h"
#import "UIColor+ColorExtensions.h"
#import "AuthorizationViewController.h"

@interface SecureCodeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *secureButton1;
@property (weak, nonatomic) IBOutlet UIButton *secureButton2;
@property (weak, nonatomic) IBOutlet UIButton *secureButton3;
@property (weak, nonatomic) IBOutlet UITextField *secureCodeBorder;
@end

@implementation SecureCodeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.secureButton1.layer.cornerRadius = 25.0;
    self.secureButton1.layer.borderWidth = 1.5;
    self.secureButton1.layer.borderColor = UIColor.littleBoyBlue.CGColor;
    
    self.secureButton2.layer.cornerRadius = 25.0;
    self.secureButton2.layer.borderWidth = 1.5;
    self.secureButton2.layer.borderColor = UIColor.littleBoyBlue.CGColor;
    
    self.secureButton3.layer.cornerRadius = 25.0;
    self.secureButton3.layer.borderWidth = 1.5;
    self.secureButton3.layer.borderColor = UIColor.littleBoyBlue.CGColor;
    
    self.secureCodeBorder.backgroundColor = UIColor.clearColor;
    self.secureCodeBorder.layer.borderWidth = 2.0;
    self.secureCodeBorder.layer.borderColor = UIColor.whiteColor.CGColor;
    self.secureCodeBorder.layer.cornerRadius = 10.0;
}


- (IBAction)secureButton1Tap:(id)sender {
    if ([self.resultLabel.text isEqualToString:@" _"]) {
        self.resultLabel.text = @"";
    }
    NSString *string = [self.resultLabel.text stringByAppendingString:@"1"];
    if ([string length] > 3) {
        string = [string substringToIndex:3];
    }
    self.resultLabel.text = string;
    
    if (self.resultLabel.text.length == 3 && ![self.resultLabel.text isEqual: @"132"]) {
        self.secureCodeBorder.layer.borderColor = UIColor.venetianRed.CGColor;
        self.resultLabel.text = @" _";
    }
    
    if (self.resultLabel.text.length == 1) {
        self.secureCodeBorder.layer.borderColor = UIColor.whiteColor.CGColor;
    }
}

- (IBAction)secureButton2Tap:(id)sender {
    
    if ([self.resultLabel.text isEqualToString:@" _"]) {
        self.resultLabel.text = @"";
    }
    NSString *string = [self.resultLabel.text stringByAppendingString:@"2"];
    if ([string length] > 3) {
        string = [string substringToIndex:3];
    }
    self.resultLabel.text = string;
    
    if ([self.resultLabel.text isEqual: @"132"]) {
        self.secureCodeBorder.layer.borderColor = UIColor.turquoiseGreen.CGColor;
        
// MARK: Success alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"You are successfully authorized!" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *refresh = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

            AuthorizationViewController *authorizationVC = [[AuthorizationViewController alloc] init];
            [window setRootViewController:authorizationVC];
            
            self.window = window;
            [self.window makeKeyAndVisible];
                            
        }];
        
        [alert addAction:refresh];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (self.resultLabel.text.length == 3 && ![self.resultLabel.text isEqual: @"132"]) {
        self.secureCodeBorder.layer.borderColor = UIColor.venetianRed.CGColor;
        self.resultLabel.text = @" _";
    }
    
    if (self.resultLabel.text.length == 1) {
        self.secureCodeBorder.layer.borderColor = UIColor.whiteColor.CGColor;
    }
}

- (IBAction)secureButton3Tap:(id)sender {
    if ([self.resultLabel.text isEqualToString:@" _"]) {
        self.resultLabel.text = @"";
    }
    NSString *string = [self.resultLabel.text stringByAppendingString:@"3"];
    if ([string length] > 3) {
        string = [string substringToIndex:3];
    }
    self.resultLabel.text = string;
    
    if (self.resultLabel.text.length == 3) {
        self.secureCodeBorder.layer.borderColor = UIColor.venetianRed.CGColor;
        self.resultLabel.text = @" _";
    }
    
    if (self.resultLabel.text.length == 1) {
        self.secureCodeBorder.layer.borderColor = UIColor.whiteColor.CGColor;
    }
}
@end
