//
//  PreferencesController.m
//  iPhreak
//
//  Created by Joseph Mattiello on 10/5/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//

#import "PreferencesController.h"

#define VERSION "1.0"

@implementation PreferencesController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	self.view = [self createPrefPane];
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
//    }
//    // Configure the cell
//    return cell;
//}


/*** <Preferences> ****/
- (int)numberOfGroupsInPreferencesTable:(UIPreferencesTable *)aTable {
	return 2;//3;
}

- (int)preferencesTable:(UIPreferencesTable *)aTable 
    numberOfRowsInGroup:(int)group 
{
    switch (group) { 
        case(0):
            return 3;
            break;
        case(1):
            return 5;
            break;
			/*     case(2):
			 return 5;
			 break;
			 */}
}
@class UIPreferencesTextTableCell;

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)aTable 
								cellForGroup:(int)group 
{
	if (groupcell[group] != NULL)
		return groupcell[group];
	
	groupcell[group] =  [[ UIPreferencesTextTableCell alloc ] 
						 initWithFrame: CGRectMake(0, 0, 320, 20)];
	if (group == 0) {
		[ groupcell[group] setTitle: @"General Options" ];
    }
	else if (group == 1)
		[ groupcell[group] setTitle: @"Box Enable" ];
	/*	else if (group == 2)
	 [ groupcell[group] setTitle: @"Stuff" ];
	 */	
	return groupcell[group];
} 

- (float)preferencesTable:(UIPreferencesTable *)aTable 
			 heightForRow:(int)row 
				  inGroup:(int)group 
	   withProposedHeight:(float)proposed 
{
    if (row == -1) {
        return 40;
    }
	
	if (group == 0 && row == 2)
		return 55;
	
    return proposed;
}

- (BOOL)preferencesTable:(UIPreferencesTable *)aTable 
			isLabelGroup:(int)group 
{
    return NO; 
}

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)aTable 
								  cellForRow:(int)row 
									 inGroup:(int)group 
{
    if (cells[row][group] != NULL)
        return cells[row][group];
	
    UIPreferencesTableCell *cell;
	
    cell = [ [ UIPreferencesTableCell alloc ] init ];
	
    switch (group) {
        case (0):
			switch (row) {
				case (0):
					[ cell setTitle:@"Startup Warning" ];
					startupWarningControl =  [[ UISwitchControl alloc ] 
											  initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ startupWarningControl setValue: preferences.autoSave ];
					[ cell  addSubview:startupWarningControl ]; 
					break;
				case (1):
					[ cell setTitle:@"Tone Queueing" ];
					toneQueueingControl =  [[ UISwitchControl alloc ] 
											initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ toneQueueingControl setValue: preferences.autoSave ];
					[ cell  addSubview:toneQueueingControl ]; 
					break;
				case (2):
					[ cell setTitle:@"Red Box locale" ];
					//	[ langControl selectSegment: preferences.frameSkip ];
					[ cell addSubview:langControl ];
					break;	
					
			}
			break;
			
		case (1):
			switch (row) {
				case (0):
					[ cell setTitle:@"Blue Box" ];
					blueBoxControl =  [[ UISwitchControl alloc ] 
									   initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ blueBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:blueBoxControl ]; 
					break;
				case (1):
					[ cell setTitle:@"Silver Box" ];
					silverBoxControl =  [[ UISwitchControl alloc ] 
										 initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ :silverBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:silverBoxControl ]; 
					break;
				case (2):
					[ cell setTitle:@"Red Box" ];
					redBoxControl =  [[ UISwitchControl alloc ] 
									  initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ redBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:redBoxControl ]; 
					break;
				case (3):
					[ cell setTitle:@"Green Box" ];
					greenBoxControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ greenBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:greenBoxControl ]; 
					break;
				case (4):
					//	[ cell setText:versionString ];
					break;
			}
			break;
    }
	
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cells[row][group] = cell;
    return cells[row][group];
}

- (UIPreferencesTable *)createPrefPane {
	
	UIPreferencesTable *pref = [[UIPreferencesTable alloc] initWithFrame:
								CGRectMake(0, 0, 360, 420)];
	
    [ pref setDataSource: self ];
    [ pref setDelegate: self ];
	
    int i, j;
    for(i=0;i<10;i++)
        for(j=0;j<10;j++) 
            cells[i][j] = NULL;
	
    langControl = [[UISegmentedControl alloc]
				   initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 55.0f) ];
    [ langControl insertSegmentWithTitle:@"US" atIndex:0 animated: NO ];
    [ langControl insertSegmentWithTitle:@"CAN" atIndex:1 animated: NO ];
    [ langControl insertSegmentWithTitle:@"GB" atIndex:2 animated: NO ];
	// [ langControl selectSegment: preferences.frameSkip ];
	
    NSString *verString = [ [NSString alloc] initWithCString: VERSION ]; 
    versionString = [ [ NSString alloc ] initWithFormat: @"Version %@", verString ];
    [ verString release ];
	
    int row;
    for(row=0;row<6;row++) {
        UIPreferencesTableCell *cell;
        if (row > 0) {
            cell = [[UIPreferencesTextTableCell alloc] init];
        } else {
            cell = [[UIPreferencesTableCell alloc] init];
            [ cell setEnabled: YES ];
        }
		
		cells[row][2] = cell;
		
	}
    
	
    [ pref reloadData ];
    return pref;
}

- (BOOL)savePreferences
{ 
	//TODO
	return YES;
}


/*** </Preferences> ****/

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
*/

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
    if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
*/

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
}
*/
/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
*/

- (void)dealloc {
    [super dealloc];
}


@end

