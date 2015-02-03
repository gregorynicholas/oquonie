//
//  Encounter.m
//  Oquonie
//
//  Created by Devine Lu Linvega on 2015-01-30.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

#import "Encounter.h"
#import "xxiivvVariables.h"
#import "xxiivvSettings.h"

@implementation Encounter

-(Encounter*)init
{
    NSLog(@"* ENCNT | Init");
    newDraw = [[Draw alloc] init];
    newSound = [[Audio alloc] init];
    return self;
}

-(Encounter*)initWithName :(NSString*)name
{
    encounterName = name;
    return self;
}

-(void)touch
{
    NSLog(@"- ENCNT + Touch        + %@", encounterName);
    SEL targetSelector = NSSelectorFromString([NSString stringWithFormat:@"%@:",encounterName]);
    [self performSelector:targetSelector withObject:@"touch"];
}

-(void)see
{
    NSLog(@"- ENCNT + See          + %@", encounterName);
    SEL targetSelector = NSSelectorFromString([NSString stringWithFormat:@"%@:",encounterName]);
    [self performSelector:targetSelector withObject:@"see"];
}

# pragma mark Lobby -

-(NSString*)map :(NSString*)option
{
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }

    Draw * newDraw = [[Draw alloc] init];
    
    // Dialogs
    if([user location] == 32){ [newDraw map:@"necomedre"]; }
    if([user location] == 2 ){ [newDraw map:@"lobby"]; }
    if([user location] == 60){ [newDraw map:@"neomine"]; }
    if([user location] == 50){ [newDraw map:@"nephtaline"]; }
    if([user location] == 85){ [newDraw map:@"nestorine"]; }
    
    // Default
    return @"";
}

-(NSString*)owlSave :(NSString*)option
{
    if([option isEqualToString:@"postNotification"]){ return @""; }		// Broadcast Notification
    if([option isEqualToString:@"postUpdate"])		{ return @""; }		// Broadcast Event Sprite Change
    
    // Dialog
    [newDraw dialog:dialogOwlSave:eventOwl];
    [newSound play:@"owl"];
    [user save];
    
    // Return storage Id
    return @"";
}


-(NSString*)gateDocument :(NSString*)option
{
    NSString* eventDialogLocked = dialogHaveCharacterNot(letterDocument);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( [user character] == characterDocument && [user location] == 29 ){
            return letterDocument;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        if([user character]==characterDocument){
            return @"gateDocument.open";
        }
        else{
            return @"gateDocument.shut";
        }
    }
    
    // Warp
    if([user character] == characterDocument){
        if([user location] == 29){
            [render router:[[Event alloc] initWarp:30:0:-1]];
        }
        else if([user location] == 30){
            [render router:[[Event alloc] initWarp:29:0:1]];
        }
    }
    else{
        [newDraw dialog:eventDialogLocked:eventTutorial];
    }
    
    return @"";
}

-(NSString*)gateNephtaline :(NSString*)option
{
    NSString* eventDialogLocked = dialogHaveCharacterNot(letterNephtaline);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if([user character]==2 && [user eventExists:storageQuestPillarNemedique] && [user location] == 1 ){
            return letterUnlocked; // letterUnlocked
        }
        // Nestorine Pillar Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNestorine] && [user location] == 93 ){
            return letterPillar; // letterUnlocked
        }
        // Lobby Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNephtaline] && [user location] == 1 ){
            return letterPillar; // letterUnlocked
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        // Nemedique pillar
        if([user location] == 93 && [user eventExists:storageQuestPillarNestorine]){
            return @"19";
        }
        if([user character]==characterNephtaline || [user character] == 7){
            return @"gateNephtalineOpen";
        }
        else{
            return @"gateNephtalineClosed";
        }
    }
    
    // Nemedique pillar
    if([user location] == 93 && [user eventExists:storageQuestPillarNestorine]){
        return @"";
    }
    
    // Warp
    if([user character] == characterNephtaline || [user character] == 7){
        if([user location] == 38){
            [render router:[[Event alloc] initWarp:39:0:-1]];
        }
        else if([user location] == 39){
            [render router:[[Event alloc] initWarp:38:0:1]];
        }
        else if([user location] == 1){
            [render router:[[Event alloc] initWarp:40:-1:-1]];
        }
        else if([user location] == 40){
            [render router:[[Event alloc] initWarp:1:1:0]];
        }
        else if([user location] == 93){
            [render router:[[Event alloc] initWarp:90:-1:0]];
        }
        else if([user location] == 90){
            [render router:[[Event alloc] initWarp:93:1:0]];
        }
        // Nastalize
        else if([user location] ==	141){
            [render router:[[Event alloc] initWarp:144:-1:0]];
        }
        else if([user location] == 144){
            [render router:[[Event alloc] initWarp:141:1:0]];
        }
    }
    else{
        [newDraw dialog:eventDialogLocked:@"1"];
    }
    return @"";
}

-(NSString*)gateNeomine :(NSString*)option
{
    NSString* eventDialogLocked = dialogHaveCharacterNot(letterNeomine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if([user character]==3 && ![user eventExists:storageQuestPillarNemedique] && [user location] == 3 ){
            return letterUnlocked; // letterUnlocked
        }
        // Lobby Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNeomine] && [user location] == 3 ){
            return letterPillar; // letterUnlocked
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        if([user character]==characterNeomine || [user character] == 7 || [user character] == 8 ){
            return @"gateNeomineOpen";
        }
        else{
            return @"gateNeomineClosed";
        }
    }
    // Warp
    if([user character] == characterNeomine || [user character] == 7 || [user character] == 8){
        if([user location] == 60){
            [render router:[[Event alloc] initWarp:3:-1:0]];
        }
        else if([user location] == 3){
            [render router:[[Event alloc] initWarp:60:-1:0]];
        }
        else if([user location] == 34){
            [render router:[[Event alloc] initWarp:71:-1:1]];
        }
        else if([user location] == 71){
            [render router:[[Event alloc] initWarp:34:1:1]];
        }
        else if([user location] == 58){
            [render router:[[Event alloc] initWarp:59:-1:0]];
        }
        else if([user location] == 59){
            [render router:[[Event alloc] initWarp:59:1:0]];
        }
        // Nastalize
        else if([user location] ==	142){
            [render router:[[Event alloc] initWarp:145:-1:0]];
        }
        else if([user location] == 145){
            [render router:[[Event alloc] initWarp:142:1:0]];
        }
    }
    else{
        [newDraw dialog:eventDialogLocked:@"1"];
    }
    return @"";
}

-(NSString*)gateNestorine :(NSString*)option
{
    NSString* eventDialogLocked = dialogHaveCharacterNot(letterNestorine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if([user character]==4 && ![user eventExists:storageQuestPillarNemedique] && [user location] == 7 ){
            return letterUnlocked; // letterUnlocked
        }
        // Necomedre Pillar Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNecomedre] && [user location] == 34 ){
            return letterPillar; // letterUnlocked
        }
        // Lobby Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNestorine] && [user location] == 7 ){
            return letterPillar; // letterUnlocked
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        // Condemned pillar doors: Neomine
        if([user location] == 34 && [user eventExists:storageQuestPillarNecomedre]){
            return @"25";
        }
        if([user character]==characterNestorine || [user character] == 7){
            return @"gateNestorineOpen";
        }
        else{
            return @"gateNestorineClosed";
        }
    }
    
    // Condemned pillar doors: Neomine
    if([user location] == 34 && [user eventExists:storageQuestPillarNecomedre]){
        return @"";
    }
    
    // Warp
    if([user character] == characterNestorine || [user character] == 7){
        if([user location] == 7){
            [render router:[[Event alloc] initWarp:96:0:-1]];
        }
        else if([user location] == [locationNestorineEnter intValue]){
            [render router:[[Event alloc] initWarp:7:0:1]];
        }
        else if([user location] == 34){
            [render router:[[Event alloc] initWarp:120:-1:0]];
        }
        else if([user location] == 120){
            [render router:[[Event alloc] initWarp:34:1:0]];
        }
        else if([user location] == 69){
            [render router:[[Event alloc] initWarp:70:0:-1]];
        }
        else if([user location] == 70){
            [render router:[[Event alloc] initWarp:69:0:1]];
        }
    }
    else{
        [newDraw dialog:eventDialogLocked:@"1"];
    }
    
    return @"";
}

-(NSString*)gateNecomedre :(NSString*)option
{
    NSString* eventDialogLocked = dialogHaveCharacterNot(letterNecomedre);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if([user character]==1 && ![user eventExists:storageQuestPillarNemedique] && [user location] == 5 ){
            return letterUnlocked; // letterUnlocked
        }
        // Neomine Pillar Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNeomine] && [user location] == 62 ){
            return letterPillar;
        }
        // Nemedique Pillar Door
        if( ![user eventExists: storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNecomedre] && [user location] == 101 ){
            return letterPillar; // letterUnlocked
        }
        // Lobby Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNecomedre] && [user location] == 5 ){
            return letterPillar; // letterUnlocked
        }
        
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        
        // Nemedique pillar
        if([user location] == 101 && [user eventExists:storageQuestPillarNemedique]){
            return @"13";
        }
        // Neomine pillar
        if([user location] == 62 && [user eventExists:storageQuestPillarNeomine]){
            return @"36";
        }
        
        if([user character]==characterNecomedre || [user character] == 7){
            return @"gateNecomedreOpen";
        }
        else{
            return @"gateNecomedreClosed";
        }
    }
    
    // Condemned pillar doors: Nemedique
    if([user location] == 101 && [user eventExists:storageQuestPillarNemedique]){
        [render router:[[Event alloc] initWarp:105:0:-1]];
        return @"";
    }
    // Condemned pillar doors: Neomine
    if([user location] == 62 && [user eventExists:storageQuestPillarNeomine]){
        return @"";
    }
    
    // Warp
    if([user character] == characterNecomedre || [user character] == 7){
        if([user location] == 62){
            [render router:[[Event alloc] initWarp:71:0:-1]];
        }
        else if([user location] == 71){
            [render router:[[Event alloc] initWarp:62:0:1]];
        }
        else if([user location] == 5){
            [render router:[[Event alloc] initWarp:32:0:-1]];
        }
        else if([user location] == 32){
            [render router:[[Event alloc] initWarp:5:0:1]];
        }
        // Nemedique Pillar
        else if([user location] == 101){
            [render router:[[Event alloc] initWarp:103:0:-1]];
        }
        else if([user location] == 103){
            [render router:[[Event alloc] initWarp:101:0:1]];
        }
    }
    else{
        [newDraw dialog:eventDialogLocked:@"1"];
    }
    return @"";
}

-(NSString*)gateNemedique :(NSString*)option
{
    NSString* eventDialogLocked = dialogHaveCharacterNot(letterNemedique);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if([user character]==5 && ![user eventExists:storageQuestPillarNemedique] && [user location] == 9 ){
            return letterUnlocked;
        }
        // Nephtaline Pillar Door
        if( [user eventExists:storageQuestPillarNemedique] && ![user eventExists:storageQuestPillarNephtaline] && [user location] == 50 ){
            return letterPillar;
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        // Nemedique pillar
        if([user character]==5 || [user character] == 7){
            return @"gateNemediqueOpen";
        }
        else{
            return @"gateNemediqueClosed";
        }
    }
    
    // Condemned pillar doors
    if([user location] == 50 && [user eventExists:storageQuestPillarNephtaline] && [user character] == characterNemedique){
        [render router:[[Event alloc] initWarp:117:-1:0]];
        return @"";
    }
    
    // Warp
    if([user character] == characterNemedique || [user character] == 7){
        if([user location] == 50){
            [render router:[[Event alloc] initWarp:121:-1:0]];
            [newDraw dialog:dialogInfoPillar:eventOwl];
        }
        else if([user location] == 121){
            [render router:[[Event alloc] initWarp:50:1:0]];
        }
        else if([user location] == 9){
            [render router:[[Event alloc] initWarp:100:-1:0]];
        }
        else if([user location] == 100){
            [render router:[[Event alloc] initWarp:9:1:0]];
        }
        // Nestorine
        else if([user location] == 94){
            [render router:[[Event alloc] initWarp:92:0:-1]];
        }
        else if([user location] == 92){
            [render router:[[Event alloc] initWarp:94:1:0]];
        }
        // Nastalize
        else if([user location] ==	143){
            [render router:[[Event alloc] initWarp:146:-1:0]];
        }
        else if([user location] == 146){
            [render router:[[Event alloc] initWarp:143:1:0]];
        }
    }
    else{
        [newDraw dialog:eventDialogLocked:@"1"];
    }
    return @"";
}

-(NSString*)event_gateHiversaires :(NSString*)option
{
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        if( [user eventExists:storageQuestPillarHiversaires]){
            return @"41";
        }
        return @"";
    }
    
    if( [user eventExists:storageQuestPillarHiversaires]){
        [render router:[[Event alloc] initWarp:148:-1:0]];
    }
    else{
        [newDraw dialog:@"123":eventOwl];
    }
    
    return @"";
}

-(NSString*)event_gateCatfish:(NSString*)option
{
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        if([user character] == 7){
            return @"gateCatOpen";
        }
        else{
            return @"gateCatClosed";
        }
    }
    
    // Warp todo: warp to 113(random door warp is missing)
    if([user character] == 7){
        if([user location] == 130){
            [render router:[[Event alloc] initWarp:131:-1:-1]];
        }
        else if([user location] == 131){
            [render router:[[Event alloc] initWarp:130:-1:1]];
        }
        else if([user location] == 112){
            [render router:[[Event alloc] initWarp:113:0:-1]];
        }
    }
    else{
        NSString* eventDialogLocked = dialogHaveCharacterNot(letterCat);
        [newDraw dialog:eventDialogLocked:eventOwl];
    }
    
    return @"";
}

-(NSString*)event_gateNastazie :(NSString*)option
{
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        if([user character] == 8){
            return @"gateNastazieOpen";
        }
        else{
            return @"gateNastazieClosed";
        }
    }
    
    if([user character] == 8){
        if([user location] == 130){
            [render router:[[Event alloc] initWarp:147:0:-1]];
        }
        else if([user location] == 147){
            [render router:[[Event alloc] initWarp:130:0:1]];
        }
    }
    
    [newDraw dialog:@"123":eventOwl];
    
    return @"";
}

# pragma mark Nephtaline -

-(NSString*)nephtalineNeomine1 :(NSString*)option
{
    // Event Identifier
    NSString *eventSpellId = @"nephtalineNeomine1";
    NSString *eventSpriteId = @"4";
    int		  eventSpell = 3;
    NSString *eventDialogSpell = dialogGainSpell(letterNeomine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return @"E";
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])			{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else										{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"neomine"];
    
    return @"";
}
-(NSString*)nephtalineNeomine2 :(NSString*)option
{
    // Event Identifier
    NSString *eventSpellId = @"nephtalineNeomine2";
    NSString*	eventSpriteId = @"4";
    int			eventSpell = 3;
    NSString* eventDialogSpell = dialogGainSpell(letterNeomine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return @"E";
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"neomine"];
    
    return @"";
}

-(NSString*)nephtalineNeomine3 :(NSString*)option
{
    // Event Identifier
    NSString *eventSpellId = @"nephtalineNeomine3";
    NSString*	eventSpriteId = @"4";
    int			eventSpell = 3;
    NSString* eventDialogSpell = dialogGainSpell(letterNeomine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return @"E";
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character] )				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"neomine"];
    
    return @"";
}

-(NSString*)nephtalineNemedique1 :(NSString*)option
{
    // Special Event Identifier
    NSString*	eventSpellId		= @"nephtalineNemedique1";
    NSString*	eventDialogSpell	= dialogGainSpell(letterNemedique);
    NSString*	eventLetter			= letterNemedique;
    NSString*	eventSpriteId		= eventNemedique;
    int			eventSpell			= spellNemedique;
    
    NSString*	eventWrongCharacter	= dialogHaveCharacterNot(letterNephtaline);
    int			eventRequirement	= characterNephtaline;
    int eventRamenRequirement		= storageQuestRamenNephtaline;
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        // Must be Nephtaline
        if([user character] != eventRequirement){ return @""; }
        // Must have ramen guy
        if(![user eventExists: eventRamenRequirement]){ return @""; }
        // If doesn't have spell already
        if([user spellExists:eventSpellId]){ return @""; }
        // Have the first pillar
        if(![user eventExists: storageQuestPillarNemedique]){ return @""; }
        // Else
        return eventLetter;
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){	return @""; }
    
    [newSound play:@"nemedique"];
    // If doesn't have the first pillar
    if(![user eventExists: storageQuestPillarNemedique]){ [newDraw dialog:dialogHavePillarsNot:eventSpriteId]; return @""; }
    // If the wrong character
    if([user character] != eventRequirement){ [newDraw dialog:eventWrongCharacter:eventSpriteId]; return @""; }
    // If without the ramen guy
    if(![user eventExists: eventRamenRequirement]){ [newDraw dialog:dialogHaveRamenNot:eventSpriteId]; return @""; }
    
    [render spellCollect:eventSpellId:eventSpell];
    [newDraw dialog:eventDialogSpell:eventSpriteId];
    
    return @"";
}

-(NSString*)nephtalineNecomedre1 :(NSString*)option
{
    // Special Event Identifier
    NSString*	eventSpellId		= @"necomedreNecomedre1";
    NSString*	eventDialogSpell	= dialogGainSpell(letterNecomedre);
    NSString*	eventLetter			= letterNecomedre;
    NSString*	eventSpriteId		= eventNecomedre;
    int			eventSpell			= spellNecomedre;
    
    NSString*	eventWrongCharacter	= dialogHaveCharacterNot(letterNeomine);
    int			eventRequirement	= characterNeomine;
    int eventRamenRequirement		= storageQuestRamenNeomine;
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        // Must be Nephtaline
        if([user character] != eventRequirement){ return @""; }
        // Must have ramen guy
        if(![user eventExists: eventRamenRequirement]){ return @""; }
        // If doesn't have spell already
        if([user spellExists:eventSpellId]){ return @""; }
        // Have the first pillar
        if(![user eventExists: storageQuestPillarNemedique]){ return @""; }
        // Else
        return eventLetter;
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){	return @""; }
    
    [newSound play:@"necomedre"];
    // If doesn't have the first pillar
    if(![user eventExists: storageQuestPillarNemedique]){ [newDraw dialog:dialogHavePillarsNot:eventSpriteId]; return @""; }
    // If the wrong character
    if([user character] != eventRequirement){ [newDraw dialog:eventWrongCharacter:eventSpriteId]; return @""; }
    // If without the ramen guy
    if(![user eventExists: eventRamenRequirement]){ [newDraw dialog:dialogHaveRamenNot:eventSpriteId]; return @""; }
    
    [render spellCollect:eventSpellId:eventSpell];
    [newDraw dialog:eventDialogSpell:eventSpriteId];
    
    return @"";
}

# pragma mark Neomine -

-(NSString*)neomineNestorine1 :(NSString*)option
{
    // Event Identifier
    NSString *eventSpellId = @"neomineNestorine1";
    NSString*	eventSpriteId = @"5";
    int			eventSpell = 4;
    
    NSString* eventDialogSpell = dialogGainSpell(letterNestorine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return @"B";
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])			{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else										{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:4];
    [newSound play:@"nestorine"];
    
    return @"";
}

-(NSString*)neomineNestorine2 :(NSString*)option
{
    // Event Identifier
    NSString *eventSpellId = @"neomineNestorine2";
    NSString*	eventSpriteId = @"5";
    int			eventSpell = 4;
    NSString* eventDialogSpell = dialogGainSpell(letterNestorine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return @"B";
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])			{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else										{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:4];
    [newSound play:@"nestorine"];
    
    return @"";
}

-(NSString*)neomineNestorine3 :(NSString*)option
{
    // Event Identifier
    NSString *eventSpellId = @"neomineNestorine3";
    NSString*	eventSpriteId = @"5";
    int			eventSpell = 4;
    NSString* eventDialogSpell = dialogGainSpell(letterNestorine);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return @"B";
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])			{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else										{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"nestorine"];
    
    return @"";
}

-(NSString*)neomineNecomedre1 :(NSString*)option
{
    // Special Event Identifier
    NSString*	eventSpellId		= @"neomineNecomedre1";
    NSString*	eventDialogSpell	= dialogGainSpell(letterNecomedre);
    NSString*	eventLetter			= letterNecomedre;
    NSString*	eventSpriteId		= eventNecomedre;
    int			eventSpell			= spellNecomedre;
    
    NSString*	eventWrongCharacter	= dialogHaveCharacterNot(letterNeomine);
    int			eventRequirement	= characterNeomine;
    int eventRamenRequirement		= storageQuestRamenNeomine;
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        // Must be Nephtaline
        if([user character] != eventRequirement){ return @""; }
        // Must have ramen guy
        if(![user eventExists: eventRamenRequirement]){ return @""; }
        // If doesn't have spell already
        if([user spellExists:eventSpellId]){ return @""; }
        // Have the first pillar
        if(![user eventExists: storageQuestPillarNemedique]){ return @""; }
        // Else
        return eventLetter;
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){	return @""; }
    
    [newSound play:@"necomedre"];
    // If doesn't have the first pillar
    if(![user eventExists: storageQuestPillarNemedique]){ [newDraw dialog:dialogHavePillarsNot:eventSpriteId]; return @""; }
    // If the wrong character
    if([user character] != eventRequirement){ [newDraw dialog:eventWrongCharacter:eventSpriteId]; return @""; }
    // If without the ramen guy
    if(![user eventExists: eventRamenRequirement]){ [newDraw dialog:dialogHaveRamenNot:eventSpriteId]; return @""; }
    
    [render spellCollect:eventSpellId:eventSpell];
    [newDraw dialog:eventDialogSpell:eventSpriteId];
    
    return @"";
}

-(NSString*)neomineNephtaline1 :(NSString*)option
{
    // Special Event Identifier
    NSString*	eventSpellId		= @"neomineNephtaline1";
    NSString*	eventDialogSpell	= dialogGainSpell(letterNephtaline);
    NSString*	eventLetter			= letterNephtaline;
    NSString*	eventSpriteId		= eventNephtaline;
    int			eventSpell			= spellNephtaline;
    
    NSString*	eventWrongCharacter	= dialogHaveCharacterNot(letterNestorine);
    int			eventRequirement	= characterNestorine;
    int eventRamenRequirement		= storageQuestRamenNestorine;
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        // Must be Nephtaline
        if([user character] != eventRequirement){ return @""; }
        // Must have ramen guy
        if(![user eventExists: eventRamenRequirement]){ return @""; }
        // If doesn't have spell already
        if([user spellExists:eventSpellId]){ return @""; }
        // Have the first pillar
        if(![user eventExists: storageQuestPillarNemedique]){ return @""; }
        // Else
        return eventLetter;
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){	return @""; }
    
    [newSound play:@"nephtaline"];
    // If doesn't have the first pillar
    if(![user eventExists: storageQuestPillarNemedique]){ [newDraw dialog:dialogHavePillarsNot:eventSpriteId]; return @""; }
    // If the wrong character
    if([user character] != eventRequirement){ [newDraw dialog:eventWrongCharacter:eventSpriteId]; return @""; }
    // If without the ramen guy
    if(![user eventExists: eventRamenRequirement]){ [newDraw dialog:dialogHaveRamenNot:eventSpriteId]; return @""; }
    
    [render spellCollect:eventSpellId:eventSpell];
    [newDraw dialog:eventDialogSpell:eventSpriteId];
    
    return @"";
}

-(NSString*)petuniaFork:(NSString*)option
{
    if([option isEqualToString:@"postNotification"]){ return @""; }
    if([option isEqualToString:@"postUpdate"]){	return @""; }
    
    if([user isFinished]){
        [render router:[[Event alloc] initWarp:110:-1:-1]];
    }
    else{
        [render router:[[Event alloc] initWarp:61:-1:-1]];
    }
    
    return @"";
}

# pragma mark Nestorine -

-(NSString*)warpNestorine:(NSString*)option
{
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @""; // try with 17 ?
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(warpNestorineAnimation) userInfo:nil repeats:NO];
    
    return @"";
}

-(void)warpNestorineAnimation
{
    [user setState:@"warp"];
    [newDraw animateWalk];
    [user setX:0];
    [user setY:0];
    [user setLocation:80];
    [newDraw animateRoomPan];
}

-(NSString*)nestorineNemedique1 :(NSString*)option
{
    // Event Identifier
    NSString*	eventSpellId	= @"nestorineNemedique1";
    NSString*	eventSpriteId	= eventNemedique;
    int			eventSpell		= spellNemedique;
    NSString* eventDialogSpell = dialogGainSpell(letterNemedique);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return letterNemedique;
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"nemedique"];
    
    return @"";
}

-(NSString*)nestorineNemedique2 :(NSString*)option
{
    // Event Identifier
    NSString*	eventSpellId	= @"nestorineNemedique2";
    NSString*	eventSpriteId	= eventNemedique;
    int			eventSpell		= spellNemedique;
    NSString* eventDialogSpell = dialogGainSpell(letterNemedique);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return letterNemedique;
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"nemedique"];
    
    return @"";
}

-(NSString*)nestorineNemedique3 :(NSString*)option
{
    // Event Identifier
    NSString*	eventSpellId	= @"nestorineNemedique3";
    NSString*	eventSpriteId	= eventNemedique;
    int			eventSpell		= spellNemedique;
    NSString* eventDialogSpell = dialogGainSpell(letterNemedique);
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return letterNemedique;
        }
        return @"";
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"nemedique"];
    
    return @"";
}

-(NSString*)nestorineNephtaline1 :(NSString*)option
{
    // Special Event Identifier
    NSString*	eventSpellId		= @"nestorineNephtaline1";
    NSString*	eventDialogSpell	= dialogGainSpell(letterNephtaline);
    NSString*	eventLetter			= letterNephtaline;
    NSString*	eventSpriteId		= eventNephtaline;
    int			eventSpell			= spellNephtaline;
    
    NSString*	eventWrongCharacter	= dialogHaveCharacterNot(letterNestorine);
    int			eventRequirement	= characterNestorine;
    int eventRamenRequirement		= storageQuestRamenNestorine;
    
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        // Must be Nephtaline
        if([user character] != eventRequirement){ return @""; }
        // Must have ramen guy
        if(![user eventExists: eventRamenRequirement]){ return @""; }
        // If doesn't have spell already
        if([user spellExists:eventSpellId]){ return @""; }
        // Have the first pillar
        if(![user eventExists: storageQuestPillarNemedique]){ return @""; }
        // Else
        return eventLetter;
    }
    
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){	return @""; }
    
    [newSound play:@"nephtaline"];
    // If doesn't have the first pillar
    if(![user eventExists: storageQuestPillarNemedique]){ [newDraw dialog:dialogHavePillarsNot:eventSpriteId]; return @""; }
    // If the wrong character
    if([user character] != eventRequirement){ [newDraw dialog:eventWrongCharacter:eventSpriteId]; return @""; }
    // If without the ramen guy
    if(![user eventExists: eventRamenRequirement]){ [newDraw dialog:dialogHaveRamenNot:eventSpriteId]; return @""; }
    
    [render spellCollect:eventSpellId:eventSpell];
    [newDraw dialog:eventDialogSpell:eventSpriteId];
    
    return @"";
}

# pragma mark Nastazie -

-(NSString*)nastazieNastazie1 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNastazie1";
    NSString * eventCharacter	= @"nastazie";
    NSString * eventSpriteId	= eventNastazie;
    int		   eventSpell		= spellNastazie;
    NSString * eventLetter		= letterNastazie;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"noface"];
    
    return @"";
}

-(NSString*)nastazieNastazie2 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNastazie2";
    NSString * eventCharacter	= @"nastazie";
    NSString * eventSpriteId	= eventNastazie;
    int		   eventSpell		= spellNastazie;
    NSString * eventLetter		= letterNastazie;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"noface"];
    
    return @"";
}

-(NSString*)nastazieNastazie3 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNastazie3";
    NSString * eventCharacter	= @"nastazie";
    NSString * eventSpriteId	= eventNastazie;
    int		   eventSpell		= spellNastazie;
    NSString * eventLetter		= letterNastazie;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:@"noface"];
    
    return @"";
}

-(NSString*)nastazieNemedique1 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNemedique1";
    NSString * eventCharacter	= @"nemedique";
    NSString * eventSpriteId	= eventNemedique;
    int		   eventSpell		= spellNemedique;
    NSString * eventLetter		= letterNemedique;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}

-(NSString*)nastazieNemedique2 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNemedique2";
    NSString * eventCharacter	= @"nemedique";
    NSString * eventSpriteId	= eventNemedique;
    int		   eventSpell		= spellNemedique;
    NSString * eventLetter		= letterNemedique;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}

-(NSString*)nastazieNemedique3 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNemedique3";
    NSString * eventCharacter	= @"nemedique";
    NSString * eventSpriteId	= eventNemedique;
    int		   eventSpell		= spellNemedique;
    NSString * eventLetter		= letterNemedique;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}

-(NSString*)nastazieNeomine1 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNeomine1";
    NSString * eventCharacter	= @"neomine";
    NSString * eventSpriteId	= eventNeomine;
    int		   eventSpell		= spellNeomine;
    NSString * eventLetter		= letterNeomine;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}
-(NSString*)nastazieNeomine2 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNeomine2";
    NSString * eventCharacter	= @"neomine";
    NSString * eventSpriteId	= eventNeomine;
    int		   eventSpell		= spellNeomine;
    NSString * eventLetter		= letterNeomine;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}
-(NSString*)nastazieNeomine3 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNeomine3";
    NSString * eventCharacter	= @"neomine";
    NSString * eventSpriteId	= eventNeomine;
    int		   eventSpell		= spellNeomine;
    NSString * eventLetter		= letterNeomine;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}

-(NSString*)nastazieNephtaline1 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNephtaline1";
    NSString * eventCharacter	= @"nephtaline";
    NSString * eventSpriteId	= eventNephtaline;
    int		   eventSpell		= spellNephtaline;
    NSString * eventLetter		= letterNephtaline;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}

-(NSString*)nastazieNephtaline2 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNephtaline2";
    NSString * eventCharacter	= @"nephtaline";
    NSString * eventSpriteId	= eventNephtaline;
    int		   eventSpell		= spellNephtaline;
    NSString * eventLetter		= letterNephtaline;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}

-(NSString*)nastazieNephtaline3 :(NSString*)option
{
    // Event Identifier
    NSString * eventSpellId		= @"nastazieNephtaline3";
    NSString * eventCharacter	= @"nephtaline";
    NSString * eventSpriteId	= eventNephtaline;
    int		   eventSpell		= spellNephtaline;
    NSString * eventLetter		= letterNephtaline;
    
    NSString * eventDialogSpell = dialogGainSpell(eventLetter);
    // Broadcast Notification
    if([option isEqualToString:@"postNotification"]){
        if( ![user spellExists:eventSpellId] && [user character] != eventSpell ){
            return eventLetter;
        }
        return @"";
    }
    // Broadcast Event Sprite Change
    if([option isEqualToString:@"postUpdate"]){
        return @"";
    }
    // Dialogs
    if( eventSpell == [user character])				{ [newDraw dialog:dialogHaveCharacter:eventSpriteId]; }
    else if( [user spellExists:eventSpellId] )	{ [newDraw dialog:dialogHaveSpell:eventSpriteId]; }
    else											{ [newDraw dialog:eventDialogSpell:eventSpriteId]; }
    // Spell
    [render spellCollect:eventSpellId:eventSpell];
    [newSound play:eventCharacter];
    
    return @"";
}



@end
