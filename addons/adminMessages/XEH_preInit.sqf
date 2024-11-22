#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;


[QGVAR(EH_recieveMessage), FUNC(recieveMessage)] call CBA_fnc_addEventHandler;