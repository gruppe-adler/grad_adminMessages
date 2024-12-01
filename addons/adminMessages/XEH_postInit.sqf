#include "script_component.hpp"

GVAR(channel) = radioChannelCreate [[0.9,0.1,0.1,1],"Admin","Admin",[],true];
publicVariable QGVAR(channel);

[QGVAR(receiveMessage), {_this call FUNC(receiveMessage);}] call CBA_fnc_addEventHandler;