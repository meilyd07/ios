#import "TinyURL.h"

@interface TinyURL()

@property (nonatomic, readwrite, retain) NSMutableDictionary *shortUrlTable;

@end

@implementation TinyURL

- (instancetype)init {
    self = [super init];
    if (self) {
        _shortUrlTable = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSString *)encodeStr:(NSString *)originalStr {
    [originalStr retain];
    NSString *characters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSUInteger BASE = [characters length];
    
    __block NSUInteger no = 0;
    
    [characters enumerateSubstringsInRange:NSMakeRange(0, characters.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        no = no * BASE + [originalStr rangeOfString:substring].location;
    }];
    //write to dictionary
    NSString *resultNo = [NSString stringWithFormat:@"%lu", no ];
    [resultNo retain];
    [self.shortUrlTable setValue:originalStr forKey:resultNo];
    return [resultNo autorelease];
}

- (NSString *)decodeStr:(NSString *)shortenedStr {
    [shortenedStr retain];
    //find in dictionary
    NSString *resultStr = [self.shortUrlTable valueForKey:shortenedStr];
    return [resultStr autorelease];
}

- (NSURL *)encode:(NSURL *)originalURL {
    NSString *resultNo = [self encodeStr: [originalURL absoluteString]];
    [resultNo retain];
    
    NSString *newUrlString = [NSString stringWithFormat:@"https://vk.cc/%@", resultNo];
    NSURL *url = [NSURL URLWithString:newUrlString];
    return url;
}


- (NSURL *)decode:(NSURL *)shortenedURL {
    [shortenedURL retain];
    NSString *absoluteStr = [shortenedURL absoluteString];
    [absoluteStr retain];
    NSString *toDecode = [absoluteStr stringByReplacingOccurrencesOfString:@"https://vk.cc/" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, absoluteStr.length)];
    [toDecode retain];
    NSString *resultStrUrl = [self decodeStr:toDecode];
    [resultStrUrl retain];
    NSURL *url = [NSURL URLWithString:resultStrUrl];
    
    return url;
}
@end
