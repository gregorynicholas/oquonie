//
//  Room.m
//  Oquonie
//
//  Created by Devine Lu Linvega on 2015-01-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

#import "Room.h"
#import "Tile.h"

@implementation Room

-(Room*)initWithArray :(NSArray*)roomArray
{
    NSLog(@"!  ROOM | Data         | Loading..");
    roomNode = [[NSArray alloc] initWithArray:roomArray];
    NSLog(@"!  ROOM | Data         | Ready");
    return self;
}

-(NSString*)tileAtLocation :(int)x :(int)y
{
    int index = [self flattenPosition:x:y];
    
    return roomNode[index];
}

-(NSString*)tileAtId :(int)locationId
{
    return roomNode[locationId];
}

-(UIImage*)tileImageAtId :(int)x :(int)y
{
    Tile* tile = [[Tile alloc] initWithString:[self tileAtLocation:x :y]];
    
    if( x == 2 ){ return [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.r.png", [tile value] ]]; }
    if( y == 2 ){ return [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.l.png", [tile value] ]]; }
    if( y == -2 ){ return [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.l.png", [tile value] ]]; }
    if( x == -2 ){ return [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.r.png", [tile value] ]]; }
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png", [tile value] ]];
}

-(int)flattenPosition :(int)x :(int)y
{
    if(x==1 && y==-1){ return 0; }
    if(x==1 && y== 0){ return 1; }
    if(x==1 && y== 1){ return 2; }
    if(x==0 && y==-1){ return 3; }
    if(x==0 && y== 0){ return 4; }
    if(x==0 && y== 1){ return 5; }
    if(x==-1&& y==-1){ return 6; }
    if(x==-1&& y== 0){ return 7; }
    if(x==-1&& y== 1){ return 8; }
    
    if(x== 2&& y==-1){ return 9; }
    if(x== 2&& y== 0){ return 10; }
    if(x== 2&& y== 1){ return 11; }
    if(x== 1&& y== 2){ return 12; }
    if(x== 0&& y== 2){ return 13; }
    if(x==-1&& y== 2){ return 14; }
    
    if(x== 1&& y== 2){ return 12; }
    if(x== 0&& y== 2){ return 13; }
    if(x==-1&& y== 2){ return 14; }
    if(x== 1&& y==-2){ return 15; }
    if(x== 0&& y==-2){ return 16; }
    if(x==-1&& y==-2){ return 17; }
    
    if(x==-2&& y==-1){ return 18; }
    if(x==-2&& y== 0){ return 19; }
    if(x==-2&& y== 1){ return 20; }
    
    return 1;
}

@end