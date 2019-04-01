#import "RomanTranslator.h"

@implementation RomanTranslator

- (NSString *)romanFromArabic:(NSString *)arabicString {
    int integerValue = [arabicString intValue];
    
    NSArray *romanM = [[NSArray alloc] initWithObjects:@"MMM", @"MM", @"M", nil];//1
    NSArray *romanC = [[NSArray alloc] initWithObjects:@"CM", @"DCCC", @"DCC", @"DC", @"D", @"CD", @"CCC", @"CC", @"C", nil];//2
    NSArray *romanX = [[NSArray alloc] initWithObjects:@"XC", @"LXXX", @"LXX", @"LX", @"L", @"XL", @"XXX", @"XX", @"X", nil];//3
    NSArray *romanI = [[NSArray alloc] initWithObjects:@"IX", @"VIII", @"VII", @"VI", @"V", @"IV", @"III", @"II", @"I", nil];//4
    
    int thousands = integerValue / 1000;
    integerValue = integerValue % 1000;
    int hundreds = integerValue / 100;
    integerValue = integerValue % 100;
    int tens = integerValue / 10;
    int units = integerValue % 10;
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    if (thousands > 0) {
        [resultStr appendString:romanM[3 - thousands]];
    }
    if (hundreds > 0) {
        [resultStr appendString:romanC[9 - hundreds]];
    }
    if (tens > 0) {
        [resultStr appendString:romanX[9 - tens]];
    }
    if (units > 0) {
        [resultStr appendString:romanI[9 - units]];
    }
    
    [romanM release];
    [romanC release];
    [romanI release];
    [romanX release];
    [resultStr autorelease];
    return resultStr;
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    [romanString retain];
    
    NSArray *romanM = [[NSArray alloc] initWithObjects:@"MMM", @"MM", @"M", nil];//1
    NSArray *romanC = [[NSArray alloc] initWithObjects:@"CM", @"DCCC", @"DCC", @"DC", @"D", @"CD", @"CCC", @"CC", @"C", nil];//2
    NSArray *romanX = [[NSArray alloc] initWithObjects:@"XC", @"LXXX", @"LXX", @"LX", @"L", @"XL", @"XXX", @"XX", @"X", nil];//3
    NSArray *romanI = [[NSArray alloc] initWithObjects:@"IX", @"VIII", @"VII", @"VI", @"V", @"IV", @"III", @"II", @"I", nil];//4
    
    int resultIntegerValue = 0;
    NSUInteger len = 0;
    for (int i = 0; i < 3; i++) {
        if ([romanString hasPrefix:romanM[i]]) {
            resultIntegerValue += 1000 * (3 - i);
            len = [romanM[i] length];
            break;
        }
    }
    
    if (len > 0) {
        romanString = [romanString substringFromIndex:len];
        len = 0;
    }
    
    for (int i = 0; i < 9; i++)
    {
        if ([romanString hasPrefix:romanC[i]]) {
            resultIntegerValue += 100 * (9 - i);
            len = [romanC[i] length];
            break;
        }
    }
    
    if (len > 0)
    {
        romanString = [romanString substringFromIndex:len];
        len = 0;
    }
    
    for (int i = 0; i < 9; i++)
    {
        if ([romanString hasPrefix:romanX[i]])
        {
            resultIntegerValue += 10 * (9 - i);
            len = [romanX[i] length];
            break;
        }
    }
    
    if (len > 0)
    {
        romanString = [romanString substringFromIndex:len];
        len = 0;
    }
    
    for (int i = 0; i < 9; i++)
    {
        if ([romanString hasPrefix:romanI[i]])
        {
            resultIntegerValue += 9 - i;
            len = [romanI[i] length];
            break;
        }
    }
    
    if ([romanString length] > len)
    {
        resultIntegerValue = 0;
    }
    
    [romanString release];
    [romanM release];
    [romanC release];
    [romanI release];
    [romanX release];
    return [[NSString stringWithFormat:@"%i", resultIntegerValue] autorelease];
}

@end
