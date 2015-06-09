//===================================================================================================================
// If this script is called a number of groups can be spawned from a predefined unit list.
// How to use: Execute this in an execution/init box of a item, through a trigger or in a script:
//              null = [side,"spawnAreaMarker",groupArray,"anchorMarker",nrOfGroups] execVM "createAIGroup.sqf";
// Variable Explination:
//              side = is the side which must be spawned.EAST,WEST or INDIPENDENT. **Critical Variable**
//              spawnAreaMarker = Marker where the units should be spawned. **Critical Variable**
//              groupArray = array of units to spawned. **Optional**
//              anchorMarker = place where the units must attack. **Optional**
//              nrOfGroups = the amount of units that must be spawned at the spawn marker of the specefic side.** Optional, Default 10**
//
//===================================================================================================================
    
[EAST,"opfSpawn_townGravia",_OpforGroups,"town_Gravia"] call _createSoldiers;
[independent,"indSpawn_townGravia",_IndepGroups,"town_Gravia"] call _createSoldiers;

{_x setMarkerAlpha 0} foreach ["opfSpawn_townGravia","indSpawn_townGravia"];


_side       = _this select 0;                                       // Gets the faction from the call array
_markerName = _this select 1;                                       // Gets the marker where to spawn the units from the call array
_grpArray   = _this select 2;                                       // Selects the group type you want to spawn
_anchorMarker = _this select 3;                                      // Select the town in which to spawn units
_nrOfGroups = [_this,11,[],[[],objNull,""],5] call BIS_fnc_param;   // Nr of groups to spawn for the specific side
_amount     = 0;                                                    // Counter to get the number of groups 

//hint format ["Total groups in side %1: %2",_side ,_amount];
//sleep 0.5;
While {_amount < _nrOfGroups} do
{
    _posMarker = [_markerName] call SHK_pos;                // Get position of the marker
    _rnd = floor (random (count _grpArray));                // Random number to get a random group to spawn from the group array
    _grpType = _grpArray select _rnd;                       // Selects the group type you want to spawn
    
    //hint "While Loop: spawning new group";
    //hint format ["Total groups %3 in side %1: %2",_side ,_amount,_rnd];
    _grp  = [_posMarker, createCenter _side, (_grpType)] call BIS_fnc_spawnGroup; 
    _amount = _amount + 1;
    
    _wp =_grp addWaypoint [getMarkerPos _anchorMarker, 0];
    _wp setWaypointType "DESTROY";
    
    //sleep 1;
    //hint format ["Total groups in side %1: %2",_side ,_amount];
    sleep 1;
};
hint "Groups Spawned";

