#import "DoomsdayMachine.h"
#import "MyAssimilationInfo.h"

@implementation DoomsdayMachine

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    NSDate *startDate = [formatter dateFromString:dateString];
    NSString *assimilateDateString = @"2208:08:14@37\\13/03";
    
    NSDate *endDate = [formatter dateFromString:assimilateDateString];
    [formatter release];
    
    unsigned int unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    [gregorian release];
    MyAssimilationInfo *assimilation = [[MyAssimilationInfo alloc] init];
    [assimilation setPropertiesWith:comps];
    return [assimilation autorelease];
}

- (NSString *)doomsdayString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    NSDate *endDate = [formatter dateFromString:@"2208:08:14@37\\13/03"];
    [formatter release];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *returnString = [format stringFromDate:endDate];
    [format release];
    
    return returnString;
}

@end
