//
//  Player.h
//  PropBet
//
//  Created by Kagan Riedel on 2/1/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PropBet;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSSet *nays;
@property (nonatomic, retain) NSSet *yays;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addNaysObject:(PropBet *)value;
- (void)removeNaysObject:(PropBet *)value;
- (void)addNays:(NSSet *)values;
- (void)removeNays:(NSSet *)values;

- (void)addYaysObject:(PropBet *)value;
- (void)removeYaysObject:(PropBet *)value;
- (void)addYays:(NSSet *)values;
- (void)removeYays:(NSSet *)values;

@end
