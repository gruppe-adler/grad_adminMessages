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
private _player = ace_player;   // ace_player so that a Remote Controlling Zeus see's the message.
private _channelID = GVAR(channel);

_channelID radioChannelAdd [_player];
_channelID radioChannelSetCallSign format [localize "STR_grad_ADMINMESSAGES_CHANNEL", _info];

// Adds frame delay due to the wierd fucky wucky that 2.18 did n stuff
[
    {
        params ["_player", "_message", "_channelID"];
        _player customChat [_channelID, _message];
        _channelID radioChannelRemove [_player];
    },
    [_player, _message, _channelID]
] call CBA_fnc_execNextFrame;