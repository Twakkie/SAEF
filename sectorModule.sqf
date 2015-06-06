//Exit if we are not the server 
if !( isServer ) exitWith {}; 



_pos          = [_this,0,[],[[],objNull,""],3] call BIS_fnc_param;
_trgSize      = [_this,1,500,[[],objNull,""],2] call BIS_fnc_param;   //A size for the trigger 
_side1        = [_this,2,east,[[],objNull,""],1] call BIS_fnc_param;
_side2        = [_this,3,west,[[],objNull,""],1] call BIS_fnc_param;
_defaultOwner = [_this,4,"-1",[[],objNull,""],1] call BIS_fnc_param;




//Create the sector logic 
_logic = (createGroup sideLogic) createUnit ["ModuleSector_F",_pos,[],0,"NONE"]; 

//Default setting,  which are optional 
_logic setVariable ["CostAir","2"]; 
_logic setVariable ["CostInfantry","1"]; 
_logic setVariable ["CostPlayers","2"]; 
_logic setVariable ["CostTracked","4"]; 
_logic setVariable ["CostWater","0"]; 
_logic setVariable ["CostWheeled","2"]; 
_logic setVariable ["DefaultOwner",_defaultOwner]; 
_logic setVariable ["Designation","A"]; 
_logic setVariable ["Name","Alpha"]; 
_logic setVariable ["OnOwnerChange",""]; 
_logic setVariable ["OwnerLimit","0"]; 
_logic setVariable ["ScoreReward","0"]; 
_logic setVariable ["TaskDescription","Capture Alpha by eliminating the enemies"]; 
_logic setVariable ["TaskOwner","3"]; 
_logic setVariable ["TaskTitle","Capture Alpha"]; 

//Set the sides for the sector 
_logic setVariable ["sides",[ _side1, _side2 ]]; 

//Wait until sector is initialised 
waitUntil { 
    !isNil { _logic getVariable [ "finalized", nil ] } && 
    { !( _logic getVariable [ "finalized", true ] ) } 
}; 

//Set the trigger size on the sector 
_logic setVariable [ "size", _trgSize ]; 
//Make the module update its trigger 
[ _logic, [], true, "area" ] call BIS_fnc_moduleSector; 

//Unfortunately the sector has not been written to also update its marker so.. 
//Get the modules trigger 
_trg = ( _logic getVariable "areas" ) select 0; 
//Get the triggers marker 
_mrk = ( _trg getVariable "markers" ) select 0; 
//Update the markers size 
_mrk setMarkerSize [ _trgSize, _trgSize ];  
