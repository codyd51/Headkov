//
//  main.m
//  Markov
//
//  Created by Phillip Tennen on 6/14/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString* input = @"This is a test of a Markov Chain. It is very cool! I like cats and I also like a nice hot cup of coffee. I am on vacation and I have a strong dislike of animals.";
        //NSLog(@"%@", input);
        
        //tokenize input string
        NSArray* tokens = [input componentsSeparatedByString:@" "];
        //NSLog(@"%@", tokens);
        
        //for every token in the input string, add an entry if one doesn't exist and add the following token to the possibilities for that state
        NSMutableDictionary* states = [[NSMutableDictionary alloc] initWithCapacity:tokens.count];
        for (int i = 0; i < tokens.count; i++) {
            NSString* str = [tokens objectAtIndex:i];
            
            //key didn't exist yet, add it
            if (!states[str]) {
                [states setObject:[NSMutableArray new] forKey:str];
            }
            
            //add next token to possible states for this key
            //the last key does not have a next state so skip that one
            if (i != tokens.count - 1) {
                NSMutableArray* possibilities = states[str];
                NSString* next = [tokens objectAtIndex:i+1];
                [possibilities addObject:next];
                //NSLog(@"%@ %@", str, next);
            }
        }
        
        //NSLog(@"states %@", states);
        
        NSUInteger previousIdx = 0;
        NSMutableString* result = [NSMutableString new];
        for (NSUInteger i = 0; i < 60; i++) {
            //start with token at the last index
            NSString* str = tokens[previousIdx];
            //NSLog(@"%@", str);
            [result appendString:[NSString stringWithFormat:@"%@ ", str]];
            
            //now, find the next token to use
            //to do so, randomly chose one of the possible tokens from this state
            NSMutableArray* possibilities = states[str];
            //NSString* next = [possibilities objectAtIndex:arc4random_uniform() % [possibilities count]];
            NSString* next = possibilities.count == 0 ? nil : possibilities[arc4random_uniform(possibilities.count)];
            
            //set the next index to this one
            previousIdx = [tokens indexOfObject:next];
        }
        
        NSLog(@"%@", result);
    }
    return 0;
}
