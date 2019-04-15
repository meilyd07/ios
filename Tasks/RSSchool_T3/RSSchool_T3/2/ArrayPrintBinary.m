//
//  ArrayPrintBinary.m
//  RSSchool_T3
//
//  Created by Hanna Rybakova on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "ArrayPrintBinary.h"


@implementation NSArray (RSSchoolnew_Extension_Name)

- (NSString *)printBinary {
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:@"["];
    
    NSInteger countTrees = [self count];
    for(int i=0; i<countTrees; i++) {
        NSArray *part = [[NSArray alloc] initWithArray:self[i]];
        [str appendString:@"["];
        if ([part[0] isKindOfClass:[NSNumber class]]) {//root
            [str appendString:@"0"];
        }
        
        
        if (![part[1] isKindOfClass:[NSNull class]]) {//left
            [str appendString:@",0,0"];//because 2 or null children
            for (int s = 1; s <= 2; s++) {
                for (int j = 1; j <= 2; j++) {
                    if ([part[s][j] isKindOfClass:[NSNull class]]) {
                        [str appendString:@",null"];
                    } else {
                        [str appendString:@",0"];
                    }
                }
                
                for (int m = 1; m <= 2; m++) {
                    if (![part[s][m] isKindOfClass:[NSNull class]]) {
                        for (int k = 1; k <= 2; k++) {
                            if ([part[s][m][k] isKindOfClass:[NSNull class]]) {//left
                                [str appendString:@",null"];
                            } else {
                                [str appendString:@",0"];
                            }
                        }
                    }
                }
                
                for (int n = 1; n <= 2; n++) {
                    if (![part[s][n] isKindOfClass:[NSNull class]]) {
                        for (int d = 1; d <= 2; d++) {
                            if (![part[s][n][d] isKindOfClass:[NSNull class]]) {
                                for (int c = 1; c <= 2; c++) {
                                    if ([part[s][n][d][c] isKindOfClass:[NSNull class]]) {//left
                                        [str appendString:@",null"];
                                    } else {
                                        [str appendString:@",0"];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        NSRange range = [str rangeOfString:@"0" options:NSBackwardsSearch];
        if (range.location < str.length - 1) {
            [str replaceCharactersInRange:NSMakeRange(range.location + 1, [str length] - range.location - 1) withString:@""];
        }
        [str appendString:@"]"];
    }
    
    [str appendString:@"]"];
    return [str autorelease];
}

@end

