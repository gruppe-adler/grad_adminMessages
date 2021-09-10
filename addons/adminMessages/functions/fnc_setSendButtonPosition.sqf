#include "script_component.hpp"
#include "..\gui\defines.hpp"

params [["_ctrl", controlNull]];

uiNamespace setVariable [QGVAR(sendBoxButtonCtrl), _ctrl];

if !([] call FUNC(isAdminOrZeus)) exitWith {};

_ctrl ctrlSetPosition [GA_ADMINMESSAGES_TITLE_X,GA_ADMINMESSAGES_SENDBUTTON_Y_2];
_ctrl ctrlCommit 0;
