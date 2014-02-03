//
//  PropBet.h
//  PropBet
//
//  Created by Kagan Riedel on 2/1/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

@interface PropBet : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * hasBeenCalculated;
@property (nonatomic, retain) NSSet *nays;
@property (nonatomic, retain) NSSet *yays;
@end

@interface PropBet (CoreDataGeneratedAccessors)

- (void)addNaysObject:(Player *)value;
- (void)removeNaysObject:(Player *)value;
- (void)addNays:(NSSet *)values;
- (void)removeNays:(NSSet *)values;

- (void)addYaysObject:(Player *)value;
- (void)removeYaysObject:(Player *)value;
- (void)addYays:(NSSet *)values;
- (void)removeYays:(NSSet *)values;

@end
