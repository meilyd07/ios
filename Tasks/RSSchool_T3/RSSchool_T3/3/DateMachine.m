#import "DateMachine.h"

@interface DateMachine() <UITextFieldDelegate>
@property (nonatomic, retain) UITextField *startDateTextField;
@property (nonatomic, retain) UITextField *stepTextField;
@property (nonatomic, retain) UITextField *dateUnitTextField;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UIButton *subButton;
@end

@implementation DateMachine

@synthesize dateLabel, startDateTextField, stepTextField, dateUnitTextField;
@synthesize addButton, subButton;

- (void)dealloc
{
    self.startDateTextField = nil;
    self.stepTextField = nil;
    self.dateUnitTextField = nil;
    self.dateLabel = nil;
    self.addButton = nil;
    self.subButton = nil;
    [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // have fun
    
    CGRect labelFrame = CGRectMake(10,10,200,44);
    self.dateLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.dateLabel.tag = 4;
    [self setCurrentDateString];
    [self.view addSubview:dateLabel];
    //[self.dateLabel release];

    self.startDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 50, 200, 40)];
    startDateTextField.placeholder=@"Start date";
    self.startDateTextField.delegate = self;
    self.startDateTextField.tag = 1;
    [self.startDateTextField addTarget:self action:@selector(startDateTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:startDateTextField];
    //[startDateTextField release];
    
    self.stepTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, startDateTextField.frame.origin.y+75, 200, 40)];
    stepTextField.placeholder = @"Step";
    self.stepTextField.delegate = self;
    self.stepTextField.tag = 2;
    [self.view addSubview:stepTextField];
    //[stepTextField release];
    
    self.dateUnitTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, stepTextField.frame.origin.y+75, 200, 40)];
    dateUnitTextField.placeholder=@"Date unit";
    self.dateUnitTextField.delegate = self;
    self.dateUnitTextField.tag = 3;
    [self.view addSubview:dateUnitTextField];
    //[dateUnitTextField release];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton sizeToFit];
    addButton.center = CGPointMake(320/2, dateUnitTextField.frame.origin.y + 50);
    [addButton addTarget:self action:@selector(buttonAddPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    //[addButton release];
    
    self.subButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [subButton setTitle:@"Sub" forState:UIControlStateNormal];
    [subButton sizeToFit];
    subButton.center = CGPointMake(320/2, addButton.frame.origin.y + 50);
    [subButton addTarget:self action:@selector(buttonSubPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    //[subButton release];
}

- (void)setCurrentDateString {
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *currentDate = [format stringFromDate:[NSDate date]];
    self.dateLabel.text = currentDate;
}

- (NSDate *)getDateFromLabel {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //[format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [format setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *resultDate = [format dateFromString:self.dateLabel.text];
    [format release];
    if (resultDate == nil) {
        return [NSDate date];
    }
    return [resultDate autorelease];
}

- (void)startDateTextChange:(UITextField *)textField {
    UILabel *dateLabel = [self.view viewWithTag: 4];
    
    if( textField.tag == 1) {
        dateLabel.text = textField.text;
    }
}

- (void)buttonAddPressed:(UIButton *)button {
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *labelDate = [[self getDateFromLabel] retain];
    NSDate *nextDate = [NSDate date];
    int result = [self getType: self.dateUnitTextField.text];
    switch (result) {
        case 1:
            dayComponent.year = [stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 2:
            dayComponent.month = [stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 3:
            dayComponent.weekOfYear = [stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 4:
            dayComponent.day = [stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 5:
            dayComponent.hour = [stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 6:
            dayComponent.minute = [stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        default:
            break;
    }
    [self.dateLabel setText:[self getDateString: nextDate]];
    //[self.view setNeedsDisplay];
    [dayComponent release];
    [labelDate release];
}

- (void)buttonSubPressed:(UIButton *)button {
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *labelDate = [[self getDateFromLabel] retain];
    NSDate *nextDate = [NSDate date];
    int result = [self getType: self.dateUnitTextField.text];
    switch (result) {
        case 1:
            dayComponent.year = -[stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 2:
            dayComponent.month = -[stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 3:
            dayComponent.weekOfYear = -[stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 4:
            dayComponent.day = -[stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 5:
            dayComponent.hour = -[stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        case 6:
            dayComponent.minute = -[stepTextField.text integerValue];
            nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:labelDate options:0];
            break;
        default:
            break;
    }
    [self.dateLabel setText:[self getDateString: nextDate]];
    [dayComponent release];
    [labelDate release];
}

- (int)getType:(NSString *)unit {
    NSDictionary *options = @{ @"year": @1, @"month": @2, @"week": @3, @"day": @4, @"hour": @5, @"minute": @6};
    if ([options valueForKey:unit]) {
        return [[options valueForKey:unit] intValue];
    } else {
        return 0;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger i = textField.tag;
    if (i == 2)
    {
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([string rangeOfCharacterFromSet:set].location != NSNotFound) {
            return NO;
        }
    }
    
    if (i == 3) {
        
            NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"yearmonthwkdiu"] invertedSet];
            if ([string rangeOfCharacterFromSet:set].location != NSNotFound) {
                return NO;
            }
            if ([textField.text length] > 6) {
                if (![self validateString:string withPattern:@"\b(year|month|week|day|hour|minute)\b"]) {
                    return NO;
                }
            }
        }
    return YES;
}

- (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error              = nil;
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange   = NSMakeRange(0, string.length);
    NSRange matchRange  = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate    = NO;
    if (matchRange.location != NSNotFound)  didValidate = YES;
    
    return didValidate;
}

/// The dates should be in format 20/04/2004 04:20
- (NSString *)getDateString:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [format setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *returnString = [format stringFromDate:date];
    [format release];
    
    return returnString;
}

@end
