#import "KidnapperNote.h"

@implementation KidnapperNote

- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note {
    NSMutableString *magaineText = [magaine mutableCopy];
    //array of words for finding
    NSArray *lineArray = [note componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [lineArray retain];
    for (NSString *str in lineArray) {
        NSString *pattern = [[NSString alloc] initWithFormat: @"\\b%@\\b", str];
        NSRange range = [magaineText rangeOfString:pattern options:NSRegularExpressionSearch|NSCaseInsensitiveSearch];
        if (range.location == NSNotFound) {
            [lineArray release];
            [pattern release];
            [magaineText release];
            return NO;
        } else {
            [magaineText replaceOccurrencesOfString:str withString:@"" options:NSCaseInsensitiveSearch range:range];
            [pattern release];
        }
    }

    [lineArray release];
    [magaineText release];
    return YES;
}

@end
