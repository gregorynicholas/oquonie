//
//  Draw.h
//  Oquonie
//
//  Created by Devine Lu Linvega on 2015-01-30.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Draw : NSObject

-(void)map :(NSString*)name;
-(void)dialog  :(NSString*)dialog :(NSString*)characterId;
-(void)animateRoom;
-(void)animateWalk;
-(void)animateSpellbook;
-(void)animateTransform;
-(void)animateRoomPan;
-(void)animateBlock;
-(void)events;
-(void)notifications;
@end