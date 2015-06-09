//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

    _OpfInfSq = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad");
    _OpfWeapSq = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons");
    _OpfInfTeam = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam");
    _OpfInfATTeam = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT");
    _OpfMotInfAT = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_AT");
    _OpfMotInfTeam = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInfTeam");
    _OpforGroups = [_OpfInfSq,_OpfWeapSq,_OpfInfTeam,_OpfInfATTeam,_OpfMotInfAT,_OpfMotInfTeam];
    
    _IndepInfSq = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad");
    _IndepWeapSq = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons");
    _IndepInfTeam = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam");
    _IndepInfATTeam = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AT");
    _IndepMotInfAT = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized_MTP" >> "HAF_MotInf_AT");
    _IndepMotInfTeam = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized_MTP" >> "HAF_MotInfTeam");
    _IndepGroups = [_IndepInfSq,_IndepWeapSq,_IndepInfTeam,_IndepInfATTeam,_IndepMotInfAT,_IndepMotInfTeam];
    
[EAST,"opfSpawn_townGravia",_OpforGroups,"town_Gravia"] call _createSoldiers;
[independent,"indSpawn_townGravia",_IndepGroups,"town_Gravia"] call _createSoldiers;

_marker = createMarker ["markerAO_Town_Gravia", getMarkerPos "town_Gravia"];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [300, 300];

{_x setMarkerAlpha 0} foreach ["opfSpawn_townGravia","indSpawn_townGravia"];

_createSoldiers =
{
    _side = _this select 0;                 // Gets the faction from the call array
    _markerName = _this select 1;           // Gets the marker where to spawn the units from the call array
    _grpArray = _this select 2;             // Selects the group type you want to spawn
    _townMarker = _this select 3;           // Select the town in which to spawn units
    _amount = 0;                            // Counter to get the number of groups 
    

    //hint format ["Total groups in side %1: %2",_side ,_amount];
    //sleep 0.5;
    While {_amount < 10} do
    {
        _posMarker = [_markerName] call SHK_pos; 
        _rnd = floor (random 6);
        _grpType = _grpArray select _rnd;               // Selects the group type you want to spawn
        
        //hint "While Loop: spawning new group";
        //hint format ["Total groups %3 in side %1: %2",_side ,_amount,_rnd];
        _grp  = [_posMarker, createCenter _side, (_grpType)] call BIS_fnc_spawnGroup; 
        _amount = _amount + 1;
        
        _wp =_grp addWaypoint [getMarkerPos _townMarker, 0];
        _wp setWaypointType "DESTROY";
        
        //sleep 1;
        //hint format ["Total groups in side %1: %2",_side ,_amount];
        sleep 1;
    };
    hint "While Loop COMPLETE";
    
};
