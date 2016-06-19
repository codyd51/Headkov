//
//  main.m
//  Markov
//
//  Created by Phillip Tennen on 6/14/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKVStringGenerator.h"
#import "MKVNewsParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //get input from stdin
        /*
        input = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        input = [input stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];
        
        //generate text from input
        MKVStringGenerator* gen = [[MKVStringGenerator alloc] initWithBaseString:input];
        NSString* res = [gengenerateString:500];
        NSLog(@"%@", res);
         */
        MKVNewsParser* parser = [[MKVNewsParser alloc] initWithFeedURL:[NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"]];
        [parser refreshWithCompletion:^void(NSArray* headlines){
            //convert all headlines into one string
            NSString* titles = [[headlines valueForKey:@"description"] componentsJoinedByString:@" "];
            
            //create string generator with this text
            MKVStringGenerator* stringGen = [[MKVStringGenerator alloc] initWithBaseString:titles];
            
            //create some random headlines
            for (int i = 0; i < 20; i++) {
                //create headline of random length
                int minLength = 6;
                int maxLength = 30;
                int length = minLength + arc4random() % (maxLength - minLength);
                NSString* headline = [stringGen generateStringOfLength:length];
                
                NSLog(@"%@", headline);
            }
        }];
    }
    return 0;
}
