#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)
/*
 Following element types should be supported:
 NSNumber
 NSNull
 NSArray
 NSString
 For all the others, it should print `unsupported`
 */

- (NSString *)print {
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:@"["];
    for (int i=0; i<self.count; i++) {
        if (i != 0) {
            [str appendString:@","];
        }
    
        if ([self[i] isKindOfClass:[NSArray class]]) {
            [str appendString:[self[i] print]];
        } else if ([self[i] isKindOfClass:[NSString class]]) {
            [str appendString:@"\""];
            [str appendString:self[i]];
            [str appendString:@"\""];
        } else if ([self[i] isKindOfClass:[NSNumber class]]) {
            [str appendFormat:@"%@", self[i]];
        } else if ([self[i] isKindOfClass:[NSNull class]]) {
            [str appendString:@"null"];
        } else {
            [str appendString:@"unsupported"];
        }
    }
    [str appendString:@"]"];
    return [str autorelease];
}

@end
