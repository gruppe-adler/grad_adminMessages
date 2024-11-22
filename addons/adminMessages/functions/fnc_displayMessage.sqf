#include "script_component.hpp"
#include "..\gui\defines.hpp"

params [["_info",""],["_message",""]];

// chat is disabled by grad_minui >> display message in custom rscTitle
if (
    !isNil "grad_minui_fnc_setting" &&
    {
        (!visibleMap && !(["chat_enabled"] call grad_minui_fnc_setting)) ||
        (visibleMap && !(["chat_enabled_map"] call grad_minui_fnc_setting))
    }
) then {

    QGVAR(customChatLayer) cutRsc [QGVAR(rscCustomChat),"PLAIN",-1,true];
    private _customChatTitleDisplay = uiNamespace getVariable [QGVAR(rscCustomChat),displayNull];
    private _ctrlText = _customChatTitleDisplay displayCtrl GA_ADMINMESSAGES_IDC_CUSTOMCHATTEXT;

    _ctrlText ctrlSetStructuredText parseText format ["<t color='#E51919'>%1</t> %2",format [localize "STR_grad_ADMINMESSAGES_CHANNEL",_info],_message];

    private _textHeight = ctrlTextHeight _ctrlText;
    /* private _textWidth = ctrlTextWidth _ctrlText; */

    (ctrlPosition _ctrlText) params ["_origX","_origY","_origW"];

    _ctrlText ctrlSetPosition [_origX,_origY - _textHeight,_origW,_textHeight];
    _ctrlText ctrlCommit 0;

};


// add message to chat either way >> user can check chat history on map, if enabled

// ace_player so that a Remote Controlling Zeus see's the message.
private _player = ace_player;
private _chID = GVAR(channel);

_chID radioChannelAdd [_player];
_chID radioChannelSetCallSign format [localize "STR_grad_ADMINMESSAGES_CHANNEL", _info];

// Adds frame delay due to the wierd fucky wucky that 2.18 did n stuff
[
    {
        _this#0 customChat [_this#2, _this#1]
        _this#2 radioChannelRemove [_this#0];
    },
    [_player, _message, _chID]
] call CBA_fnc_execNextFrame;