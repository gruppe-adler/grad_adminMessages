#include "script_component.hpp"

serverCommandAvailable "#kick" || // Alternative could be: call BIS_fnc_admin > 0
!isNull (getAssignedCuratorLogic player)
