//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////


    
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

