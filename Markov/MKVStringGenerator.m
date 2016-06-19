//
//  MKVStringGenerator.m
//  Markov
//
//  Created by Phillip Tennen on 6/16/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import "MKVStringGenerator.h"

@implementation MKVStringGenerator
-(instancetype)initWithBaseString:(NSString*)input {
    if ((self = [super init])) {
        //tokenize input string
        self.tokens = [input componentsSeparatedByString:@" "];
        
        //for every token in the input string, add an entry if one doesn't exist and add the following token to the possibilities for that state
        _states = [[NSMutableDictionary alloc] initWithCapacity:self.tokens.count];
        for (int i = 0; i < self.tokens.count; i++) {
            NSString* str = [self.tokens objectAtIndex:i];
            
            //key didn't exist yet, add it
            if (!_states[str]) {
                [_states setObject:[NSMutableArray new] forKey:str];
            }
            
            //add next token to possible states for this key
            NSMutableArray<NSString*>* possibilities = _states[str];
            //the last key does not have a next state so add empty possibility for that case
            if (i != self.tokens.count - 1) {
                NSString* next = [self.tokens objectAtIndex:i+1];
                [possibilities addObject:next];
            } else [possibilities addObject:@""];
        }
    }
    return self;
}
-(NSUInteger)randomValidBaseIndex {
    //TODO improve this
    
    //try a random index and see if it starts with a capital
    //if so, it's a valid base
    //if not, recurse and try another
    NSUInteger guessIndex = arc4random_uniform((u_int32_t)self.tokens.count);
    NSString* guess = self.tokens[guessIndex];
    if (!guess || guess.length == 0) {
        return [self randomValidBaseIndex];
    }
    
    BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[guess characterAtIndex:0]];
    if (isUppercase) {
        return guessIndex;
    }
    
    //didn't find a string starting with a capital, recurse and try again
    return [self randomValidBaseIndex];
}
-(NSString*)generateStringOfLength:(int)wordCount {
    //start with a random index
    NSUInteger previousIdx = [self randomValidBaseIndex];
    
    NSMutableString* result = [NSMutableString new];
    for (NSUInteger i = 0; i < wordCount; i++) {
        //start with token at the previous index
        NSString* str = self.tokens[previousIdx];
        [result appendString:[NSString stringWithFormat:@"%@ ", str]];
        
        //now, find the next token to use
        //to do so, randomly chose one of the possible tokens from this state
        NSMutableArray* possibilities = _states[str];
        NSString* next = ([possibilities count] == 0) ? @"" : [possibilities objectAtIndex:arc4random_uniform((u_int32_t)[possibilities count])];
        
        //set the next index to this one
        if ([self.tokens indexOfObject:next] != NSNotFound) {
            previousIdx = [self.tokens indexOfObject:next];
        } else break;
    }
    
    return [NSString stringWithString:result];
}
@end
