//
//  AuthorizationViewController.m
//  AuthorizationApp
//
//  Created by Таня Василёнок on 4.07.21.
//

#import "AuthorizationViewController.h"
#import "SecureCodeViewController.h"
#import "UIColor+ColorExtensions.h"

@interface AuthorizationViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;

@property (strong, nonatomic) SecureCodeViewController *secureCodeVC;

// MARK: Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

// MARK: Keyboard category
@interface AuthorizationViewController (KeyboardHandling)
- (void)subscribeOnKeyboardEvents;
- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;
@end

// MARK: Spacing between button title and image category
@interface UIButton (ImageTitleCentering)
- (void) centerButtonAndImageWithSpacing:(CGFloat)spacing;
@end

// MARK: Background color for highlighted Authorize button
@interface UIButton (ImageWithColor)
- (void)setColor:(UIColor *)color forState:(UIControlState)state;
@end


@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];
 
    self.usernameTextField.layer.borderWidth = 1.5;
    self.usernameTextField.layer.cornerRadius = 5.0;
    self.usernameTextField.layer.borderColor = UIColor.blackCoral.CGColor;
    
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.layer.borderColor = UIColor.blackCoral.CGColor;
    
    self.authorizeButton.layer.cornerRadius = 10.0;
    self.authorizeButton.layer.borderWidth = 2;
    self.authorizeButton.layer.borderColor = UIColor.littleBoyBlue.CGColor;
    self.authorizeButton.titleEdgeInsets = UIEdgeInsetsMake(10.0, 20.0, 10.0, 20.0);
    [self.authorizeButton setTintColor:UIColor.littleBoyBlue];
    [self.authorizeButton centerButtonAndImageWithSpacing:5];

    UIImage *authorizeImageNormal = [UIImage imageNamed:@"person"];
    [self.authorizeButton setImage:authorizeImageNormal
                          forState:UIControlStateNormal];
    
    UIImage *authorizeImageHighlighted = [UIImage imageNamed:@"personfill"];
    [self.authorizeButton setImage:authorizeImageHighlighted
                          forState:UIControlStateHighlighted];
    
    [self.authorizeButton setColor:UIColor.littleBoyBlue forState:UIControlStateHighlighted];
    
    [self.authorizeButton addTarget:self
                             action:@selector(authorizeButtonTap:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

// MARK: Actions when tapping on Authorize button
- (IBAction)authorizeButtonTap:(id)sender {
    NSString *inputedUsernameText = self.usernameTextField.text;
    if (![inputedUsernameText isEqual: @"username"]) {
        self.usernameTextField.layer.borderColor = UIColor.venetianRed.CGColor;
    }

    NSString *inputedPasswordText = self.passwordTextField.text;
    if (![inputedPasswordText isEqual: @"password"]) {
        self.passwordTextField.layer.borderColor = UIColor.venetianRed.CGColor;
    }
    
    // Disable all interactive elements
    if ([inputedUsernameText isEqual:@"username"] && [inputedPasswordText isEqual:@"password"]) {
        self.usernameTextField.userInteractionEnabled = NO;
        self.usernameTextField.layer.borderColor = UIColor.turquoiseGreen.CGColor;
        self.usernameTextField.alpha = 0.5;
        
        self.passwordTextField.userInteractionEnabled = NO;
        self.passwordTextField.layer.borderColor = UIColor.turquoiseGreen.CGColor;
        self.passwordTextField.alpha = 0.5;
        
        self.authorizeButton.userInteractionEnabled = NO;
        self.authorizeButton.alpha = 0.5;
        
        // Logic to add child view controller
        self.secureCodeVC = [[SecureCodeViewController alloc] init];
        [self addChildViewController:self.secureCodeVC];
        self.secureCodeVC.view.frame = [self frameForSecureCodeVC];
        [self.view addSubview:self.secureCodeVC.view];
        [self.secureCodeVC didMoveToParentViewController:self];
    }
}

// unused
- (IBAction)usernameTextFieldTap:(id)sender {
}

//unused
- (IBAction)passwordTextFieldTap:(id)sender {
}

// MARK: Delegate. When tap on return - go to the next textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [self.passwordTextField becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = UIColor.blackCoral.CGColor;
    textField.text = @"";
}

- (CGRect)frameForSecureCodeVC {
    return CGRectMake(0.0,
                      450.0,
                      self.view.bounds.size.width,
                      self.view.bounds.size.height);
}
@end

// MARK: - Keyboard category
@implementation AuthorizationViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
    // Keyboard will show
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
    CGRect rect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [self updateTopContraintWith:50.0 andBottom:rect.size.height - self.view.safeAreaInsets.bottom + 15.0];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self updateTopContraintWith:80.0 andBottom:0.0];
}

- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
    // Change your constraint constants
    self.topConstraint.constant = constant;
    self.bottomConstraint.constant = bottomConstant;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end

// MARK: Spacing between button title and image category
@implementation UIButton(ImageTitleCentering)
-(void) centerButtonAndImageWithSpacing:(CGFloat)spacing {
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}
@end

// MARK: Background color for highlighted Authorize button
@implementation UIButton (ImageTWithColor)
- (void)setColor:(UIColor *)color forState:(UIControlState)state
{
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    colorView.backgroundColor = color;

    UIGraphicsBeginImageContext(colorView.bounds.size);
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:colorImage forState:state];
}
@end
