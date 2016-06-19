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
        MKVNewsParser* parser = [[MKVNewsParser alloc] initWithFeedURL:[NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"]];
        [parser refreshWithCompletion:^void(NSArray* headlines){
            //convert all headlines into one string
            NSString* titles = [[headlines valueForKey:@"description"] componentsJoinedByString:@" "];
            
            //create string generator with this text
            MKVStringGenerator* stringGen = [[MKVStringGenerator alloc] initWithBaseString:titles];
            
            //create some random headlines
            for (int i = 0; i < 20; i++) {
                //create headline of random length
                int minLength = 5;
                int maxLength = 20;
                int length = minLength + arc4random() % (maxLength - minLength);
                NSString* headline = [stringGen generateStringOfLength:length];
                
                NSLog(@"%@", headline);
            }
        }];
    }
    return 0;
}
