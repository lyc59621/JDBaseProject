//
//  NSString+URLParameters.h
//  JDMovie
//
//  Created by JDragon on 2018/9/28.
//  Copyright © 2018 JDragon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URLParameters)

- (NSMutableDictionary *)getURLParameters;

@end

NS_ASSUME_NONNULL_END
