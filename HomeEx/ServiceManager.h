//
//  ServiceManager.h
//  HomeEx
//
//  Created by Bharath G M on 2/3/16.
//  Copyright © 2016 -. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ServiceCompletionBlock)(NSArray *cardObject, NSError *error);

@interface ServiceManager : NSObject

+(void)requestCardData:(ServiceCompletionBlock)completionBlock;

@end
