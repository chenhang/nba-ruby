class DocData

  def self.names
    @names ||= DocData.init_names
  end

  def self.init_names
    test = []
    test2 = []

    test.push "OnCDemoStop-CDemoStop"
    test2.push "CDemoStop-CDemoStop"

    test.push "OnCDemoFileHeader-CDemoFileHeader"
    test2.push "CDemoFileHeader-CDemoFileHeader"

    test.push "OnCDemoFileInfo-CDemoFileInfo"
    test2.push "CDemoFileInfo-CDemoFileInfo"

    test.push "OnCDemoSyncTick-CDemoSyncTick"
    test2.push "CDemoSyncTick-CDemoSyncTick"

    test.push "OnCDemoSendTables-CDemoSendTables"
    test2.push "CDemoSendTables-CDemoSendTables"

    test.push "OnCDemoClassInfo-CDemoClassInfo"
    test2.push "CDemoClassInfo-CDemoClassInfo"

    test.push "OnCDemoStringTables-CDemoStringTables"
    test2.push "CDemoStringTables-CDemoStringTables"

    test.push "OnCDemoPacket-CDemoPacket"
    test2.push "CDemoPacket-CDemoPacket"

    test.push "OnCDemoSignonPacket-CDemoPacket"
    test2.push "CDemoSignonPacket-CDemoSignonPacket"

    test.push "OnCDemoConsoleCmd-CDemoConsoleCmd"
    test2.push "CDemoConsoleCmd-CDemoConsoleCmd"

    test.push "OnCDemoCustomData-CDemoCustomData"
    test2.push "CDemoCustomData-CDemoCustomData"

    test.push "OnCDemoCustomDataCallbacks-CDemoCustomDataCallbacks"
    test2.push "CDemoCustomDataCallbacks-CDemoCustomDataCallbacks"

    test.push "OnCDemoUserCmd-CDemoUserCmd"
    test2.push "CDemoUserCmd-CDemoUserCmd"

    test.push "OnCDemoFullPacket-CDemoFullPacket"
    test2.push "CDemoFullPacket-CDemoFullPacket"

    test.push "OnCDemoSaveGame-CDemoSaveGame"
    test2.push "CDemoSaveGame-CDemoSaveGame"

    test.push "OnCDemoSpawnGroups-CDemoSpawnGroups"
    test2.push "CDemoSpawnGroups-CDemoSpawnGroups"

    test.push "OnCNETMsg_NOP-CNETMsg_NOP"
    test2.push "CNETMsg_NOP-CNETMsg_NOP"

    test.push "OnCNETMsg_Disconnect-CNETMsg_Disconnect"
    test2.push "CNETMsg_Disconnect-CNETMsg_Disconnect"

    test.push "OnCNETMsg_SplitScreenUser-CNETMsg_SplitScreenUser"
    test2.push "CNETMsg_SplitScreenUser-CNETMsg_SplitScreenUser"

    test.push "OnCNETMsg_Tick-CNETMsg_Tick"
    test2.push "CNETMsg_Tick-CNETMsg_Tick"

    test.push "OnCNETMsg_StringCmd-CNETMsg_StringCmd"
    test2.push "CNETMsg_StringCmd-CNETMsg_StringCmd"

    test.push "OnCNETMsg_SetConVar-CNETMsg_SetConVar"
    test2.push "CNETMsg_SetConVar-CNETMsg_SetConVar"

    test.push "OnCNETMsg_SignonState-CNETMsg_SignonState"
    test2.push "CNETMsg_SignonState-CNETMsg_SignonState"

    test.push "OnCNETMsg_SpawnGroup_Load-CNETMsg_SpawnGroup_Load"
    test2.push "CNETMsg_SpawnGroup_Load-CNETMsg_SpawnGroup_Load"

    test.push "OnCNETMsg_SpawnGroup_ManifestUpdate-CNETMsg_SpawnGroup_ManifestUpdate"
    test2.push "CNETMsg_SpawnGroup_ManifestUpdate-CNETMsg_SpawnGroup_ManifestUpdate"

    test.push "OnCNETMsg_SpawnGroup_SetCreationTick-CNETMsg_SpawnGroup_SetCreationTick"
    test2.push "CNETMsg_SpawnGroup_SetCreationTick-CNETMsg_SpawnGroup_SetCreationTick"

    test.push "OnCNETMsg_SpawnGroup_Unload-CNETMsg_SpawnGroup_Unload"
    test2.push "CNETMsg_SpawnGroup_Unload-CNETMsg_SpawnGroup_Unload"

    test.push "OnCNETMsg_SpawnGroup_LoadCompleted-CNETMsg_SpawnGroup_LoadCompleted"
    test2.push "CNETMsg_SpawnGroup_LoadCompleted-CNETMsg_SpawnGroup_LoadCompleted"

    test.push "OnCSVCMsg_ServerInfo-CSVCMsg_ServerInfo"
    test2.push "CSVCMsg_ServerInfo-CSVCMsg_ServerInfo"

    test.push "OnCSVCMsg_FlattenedSerializer-CSVCMsg_FlattenedSerializer"
    test2.push "CSVCMsg_FlattenedSerializer-CSVCMsg_FlattenedSerializer"

    test.push "OnCSVCMsg_ClassInfo-CSVCMsg_ClassInfo"
    test2.push "CSVCMsg_ClassInfo-CSVCMsg_ClassInfo"

    test.push "OnCSVCMsg_SetPause-CSVCMsg_SetPause"
    test2.push "CSVCMsg_SetPause-CSVCMsg_SetPause"

    test.push "OnCSVCMsg_CreateStringTable-CSVCMsg_CreateStringTable"
    test2.push "CSVCMsg_CreateStringTable-CSVCMsg_CreateStringTable"

    test.push "OnCSVCMsg_UpdateStringTable-CSVCMsg_UpdateStringTable"
    test2.push "CSVCMsg_UpdateStringTable-CSVCMsg_UpdateStringTable"

    test.push "OnCSVCMsg_VoiceInit-CSVCMsg_VoiceInit"
    test2.push "CSVCMsg_VoiceInit-CSVCMsg_VoiceInit"

    test.push "OnCSVCMsg_VoiceData-CSVCMsg_VoiceData"
    test2.push "CSVCMsg_VoiceData-CSVCMsg_VoiceData"

    test.push "OnCSVCMsg_Print-CSVCMsg_Print"
    test2.push "CSVCMsg_Print-CSVCMsg_Print"

    test.push "OnCSVCMsg_Sounds-CSVCMsg_Sounds"
    test2.push "CSVCMsg_Sounds-CSVCMsg_Sounds"

    test.push "OnCSVCMsg_SetView-CSVCMsg_SetView"
    test2.push "CSVCMsg_SetView-CSVCMsg_SetView"

    test.push "OnCSVCMsg_ClearAllStringTables-CSVCMsg_ClearAllStringTables"
    test2.push "CSVCMsg_ClearAllStringTables-CSVCMsg_ClearAllStringTables"

    test.push "OnCSVCMsg_CmdKeyValues-CSVCMsg_CmdKeyValues"
    test2.push "CSVCMsg_CmdKeyValues-CSVCMsg_CmdKeyValues"

    test.push "OnCSVCMsg_BSPDecal-CSVCMsg_BSPDecal"
    test2.push "CSVCMsg_BSPDecal-CSVCMsg_BSPDecal"

    test.push "OnCSVCMsg_SplitScreen-CSVCMsg_SplitScreen"
    test2.push "CSVCMsg_SplitScreen-CSVCMsg_SplitScreen"

    test.push "OnCSVCMsg_PacketEntities-CSVCMsg_PacketEntities"
    test2.push "CSVCMsg_PacketEntities-CSVCMsg_PacketEntities"

    test.push "OnCSVCMsg_Prefetch-CSVCMsg_Prefetch"
    test2.push "CSVCMsg_Prefetch-CSVCMsg_Prefetch"

    test.push "OnCSVCMsg_Menu-CSVCMsg_Menu"
    test2.push "CSVCMsg_Menu-CSVCMsg_Menu"

    test.push "OnCSVCMsg_GetCvarValue-CSVCMsg_GetCvarValue"
    test2.push "CSVCMsg_GetCvarValue-CSVCMsg_GetCvarValue"

    test.push "OnCSVCMsg_StopSound-CSVCMsg_StopSound"
    test2.push "CSVCMsg_StopSound-CSVCMsg_StopSound"

    test.push "OnCSVCMsg_PeerList-CSVCMsg_PeerList"
    test2.push "CSVCMsg_PeerList-CSVCMsg_PeerList"

    test.push "OnCSVCMsg_PacketReliable-CSVCMsg_PacketReliable"
    test2.push "CSVCMsg_PacketReliable-CSVCMsg_PacketReliable"

    test.push "OnCSVCMsg_HLTVStatus-CSVCMsg_HLTVStatus"
    test2.push "CSVCMsg_HLTVStatus-CSVCMsg_HLTVStatus"

    test.push "OnCSVCMsg_FullFrameSplit-CSVCMsg_FullFrameSplit"
    test2.push "CSVCMsg_FullFrameSplit-CSVCMsg_FullFrameSplit"

    test.push "OnCUserMessageAchievementEvent-CUserMessageAchievementEvent"
    test2.push "CUserMessageAchievementEvent-CUserMessageAchievementEvent"

    test.push "OnCUserMessageCloseCaption-CUserMessageCloseCaption"
    test2.push "CUserMessageCloseCaption-CUserMessageCloseCaption"

    test.push "OnCUserMessageCloseCaptionDirect-CUserMessageCloseCaptionDirect"
    test2.push "CUserMessageCloseCaptionDirect-CUserMessageCloseCaptionDirect"

    test.push "OnCUserMessageCurrentTimescale-CUserMessageCurrentTimescale"
    test2.push "CUserMessageCurrentTimescale-CUserMessageCurrentTimescale"

    test.push "OnCUserMessageDesiredTimescale-CUserMessageDesiredTimescale"
    test2.push "CUserMessageDesiredTimescale-CUserMessageDesiredTimescale"

    test.push "OnCUserMessageFade-CUserMessageFade"
    test2.push "CUserMessageFade-CUserMessageFade"

    test.push "OnCUserMessageGameTitle-CUserMessageGameTitle"
    test2.push "CUserMessageGameTitle-CUserMessageGameTitle"

    test.push "OnCUserMessageHintText-CUserMessageHintText"
    test2.push "CUserMessageHintText-CUserMessageHintText"

    test.push "OnCUserMessageHudMsg-CUserMessageHudMsg"
    test2.push "CUserMessageHudMsg-CUserMessageHudMsg"

    test.push "OnCUserMessageHudText-CUserMessageHudText"
    test2.push "CUserMessageHudText-CUserMessageHudText"

    test.push "OnCUserMessageKeyHintText-CUserMessageKeyHintText"
    test2.push "CUserMessageKeyHintText-CUserMessageKeyHintText"

    test.push "OnCUserMessageColoredText-CUserMessageColoredText"
    test2.push "CUserMessageColoredText-CUserMessageColoredText"

    test.push "OnCUserMessageRequestState-CUserMessageRequestState"
    test2.push "CUserMessageRequestState-CUserMessageRequestState"

    test.push "OnCUserMessageResetHUD-CUserMessageResetHUD"
    test2.push "CUserMessageResetHUD-CUserMessageResetHUD"

    test.push "OnCUserMessageRumble-CUserMessageRumble"
    test2.push "CUserMessageRumble-CUserMessageRumble"

    test.push "OnCUserMessageSayText-CUserMessageSayText"
    test2.push "CUserMessageSayText-CUserMessageSayText"

    test.push "OnCUserMessageSayText2-CUserMessageSayText2"
    test2.push "CUserMessageSayText2-CUserMessageSayText2"

    test.push "OnCUserMessageSayTextChannel-CUserMessageSayTextChannel"
    test2.push "CUserMessageSayTextChannel-CUserMessageSayTextChannel"

    test.push "OnCUserMessageShake-CUserMessageShake"
    test2.push "CUserMessageShake-CUserMessageShake"

    test.push "OnCUserMessageShakeDir-CUserMessageShakeDir"
    test2.push "CUserMessageShakeDir-CUserMessageShakeDir"

    test.push "OnCUserMessageTextMsg-CUserMessageTextMsg"
    test2.push "CUserMessageTextMsg-CUserMessageTextMsg"

    test.push "OnCUserMessageScreenTilt-CUserMessageScreenTilt"
    test2.push "CUserMessageScreenTilt-CUserMessageScreenTilt"

    test.push "OnCUserMessageTrain-CUserMessageTrain"
    test2.push "CUserMessageTrain-CUserMessageTrain"

    test.push "OnCUserMessageVGUIMenu-CUserMessageVGUIMenu"
    test2.push "CUserMessageVGUIMenu-CUserMessageVGUIMenu"

    test.push "OnCUserMessageVoiceMask-CUserMessageVoiceMask"
    test2.push "CUserMessageVoiceMask-CUserMessageVoiceMask"

    test.push "OnCUserMessageVoiceSubtitle-CUserMessageVoiceSubtitle"
    test2.push "CUserMessageVoiceSubtitle-CUserMessageVoiceSubtitle"

    test.push "OnCUserMessageSendAudio-CUserMessageSendAudio"
    test2.push "CUserMessageSendAudio-CUserMessageSendAudio"

    test.push "OnCUserMessageItemPickup-CUserMessageItemPickup"
    test2.push "CUserMessageItemPickup-CUserMessageItemPickup"

    test.push "OnCUserMessageAmmoDenied-CUserMessageAmmoDenied"
    test2.push "CUserMessageAmmoDenied-CUserMessageAmmoDenied"

    test.push "OnCUserMessageCrosshairAngle-CUserMessageCrosshairAngle"
    test2.push "CUserMessageCrosshairAngle-CUserMessageCrosshairAngle"

    test.push "OnCUserMessageShowMenu-CUserMessageShowMenu"
    test2.push "CUserMessageShowMenu-CUserMessageShowMenu"

    test.push "OnCUserMessageCreditsMsg-CUserMessageCreditsMsg"
    test2.push "CUserMessageCreditsMsg-CUserMessageCreditsMsg"

    test.push "OnCUserMessageCloseCaptionPlaceholder-CUserMessageCloseCaptionPlaceholder"
    test2.push "CUserMessageCloseCaptionPlaceholder-CUserMessageCloseCaptionPlaceholder"

    test.push "OnCUserMessageCameraTransition-CUserMessageCameraTransition"
    test2.push "CUserMessageCameraTransition-CUserMessageCameraTransition"

    test.push "OnCUserMessageAudioParameter-CUserMessageAudioParameter"
    test2.push "CUserMessageAudioParameter-CUserMessageAudioParameter"

    test.push "OnCEntityMessagePlayJingle-CEntityMessagePlayJingle"
    test2.push "CEntityMessagePlayJingle-CEntityMessagePlayJingle"

    test.push "OnCEntityMessageScreenOverlay-CEntityMessageScreenOverlay"
    test2.push "CEntityMessageScreenOverlay-CEntityMessageScreenOverlay"

    test.push "OnCEntityMessageRemoveAllDecals-CEntityMessageRemoveAllDecals"
    test2.push "CEntityMessageRemoveAllDecals-CEntityMessageRemoveAllDecals"

    test.push "OnCEntityMessagePropagateForce-CEntityMessagePropagateForce"
    test2.push "CEntityMessagePropagateForce-CEntityMessagePropagateForce"

    test.push "OnCEntityMessageDoSpark-CEntityMessageDoSpark"
    test2.push "CEntityMessageDoSpark-CEntityMessageDoSpark"

    test.push "OnCEntityMessageFixAngle-CEntityMessageFixAngle"
    test2.push "CEntityMessageFixAngle-CEntityMessageFixAngle"

    test.push "OnCMsgVDebugGameSessionIDEvent-CMsgVDebugGameSessionIDEvent"
    test2.push "CMsgVDebugGameSessionIDEvent-CMsgVDebugGameSessionIDEvent"

    test.push "OnCMsgPlaceDecalEvent-CMsgPlaceDecalEvent"
    test2.push "CMsgPlaceDecalEvent-CMsgPlaceDecalEvent"

    test.push "OnCMsgClearWorldDecalsEvent-CMsgClearWorldDecalsEvent"
    test2.push "CMsgClearWorldDecalsEvent-CMsgClearWorldDecalsEvent"

    test.push "OnCMsgClearEntityDecalsEvent-CMsgClearEntityDecalsEvent"
    test2.push "CMsgClearEntityDecalsEvent-CMsgClearEntityDecalsEvent"

    test.push "OnCMsgClearDecalsForSkeletonInstanceEvent-CMsgClearDecalsForSkeletonInstanceEvent"
    test2.push "CMsgClearDecalsForSkeletonInstanceEvent-CMsgClearDecalsForSkeletonInstanceEvent"

    test.push "OnCMsgSource1LegacyGameEventList-CMsgSource1LegacyGameEventList"
    test2.push "CMsgSource1LegacyGameEventList-CMsgSource1LegacyGameEventList"

    test.push "OnCMsgSource1LegacyListenEvents-CMsgSource1LegacyListenEvents"
    test2.push "CMsgSource1LegacyListenEvents-CMsgSource1LegacyListenEvents"

    test.push "OnCMsgSource1LegacyGameEvent-CMsgSource1LegacyGameEvent"
    test2.push "CMsgSource1LegacyGameEvent-CMsgSource1LegacyGameEvent"

    test.push "OnCMsgSosStartSoundEvent-CMsgSosStartSoundEvent"
    test2.push "CMsgSosStartSoundEvent-CMsgSosStartSoundEvent"

    test.push "OnCMsgSosStopSoundEvent-CMsgSosStopSoundEvent"
    test2.push "CMsgSosStopSoundEvent-CMsgSosStopSoundEvent"

    test.push "OnCMsgSosSetSoundEventParams-CMsgSosSetSoundEventParams"
    test2.push "CMsgSosSetSoundEventParams-CMsgSosSetSoundEventParams"

    test.push "OnCMsgSosSetLibraryStackFields-CMsgSosSetLibraryStackFields"
    test2.push "CMsgSosSetLibraryStackFields-CMsgSosSetLibraryStackFields"

    test.push "OnCMsgSosStopSoundEventHash-CMsgSosStopSoundEventHash"
    test2.push "CMsgSosStopSoundEventHash-CMsgSosStopSoundEventHash"

    test.push "OnCDOTAUserMsg_AIDebugLine-CDOTAUserMsg_AIDebugLine"
    test2.push "CDOTAUserMsg_AIDebugLine-CDOTAUserMsg_AIDebugLine"

    test.push "OnCDOTAUserMsg_ChatEvent-CDOTAUserMsg_ChatEvent"
    test2.push "CDOTAUserMsg_ChatEvent-CDOTAUserMsg_ChatEvent"

    test.push "OnCDOTAUserMsg_CombatHeroPositions-CDOTAUserMsg_CombatHeroPositions"
    test2.push "CDOTAUserMsg_CombatHeroPositions-CDOTAUserMsg_CombatHeroPositions"

    test.push "OnCDOTAUserMsg_CombatLogShowDeath-CDOTAUserMsg_CombatLogShowDeath"
    test2.push "CDOTAUserMsg_CombatLogShowDeath-CDOTAUserMsg_CombatLogShowDeath"

    test.push "OnCDOTAUserMsg_CreateLinearProjectile-CDOTAUserMsg_CreateLinearProjectile"
    test2.push "CDOTAUserMsg_CreateLinearProjectile-CDOTAUserMsg_CreateLinearProjectile"

    test.push "OnCDOTAUserMsg_DestroyLinearProjectile-CDOTAUserMsg_DestroyLinearProjectile"
    test2.push "CDOTAUserMsg_DestroyLinearProjectile-CDOTAUserMsg_DestroyLinearProjectile"

    test.push "OnCDOTAUserMsg_DodgeTrackingProjectiles-CDOTAUserMsg_DodgeTrackingProjectiles"
    test2.push "CDOTAUserMsg_DodgeTrackingProjectiles-CDOTAUserMsg_DodgeTrackingProjectiles"

    test.push "OnCDOTAUserMsg_GlobalLightColor-CDOTAUserMsg_GlobalLightColor"
    test2.push "CDOTAUserMsg_GlobalLightColor-CDOTAUserMsg_GlobalLightColor"

    test.push "OnCDOTAUserMsg_GlobalLightDirection-CDOTAUserMsg_GlobalLightDirection"
    test2.push "CDOTAUserMsg_GlobalLightDirection-CDOTAUserMsg_GlobalLightDirection"

    test.push "OnCDOTAUserMsg_InvalidCommand-CDOTAUserMsg_InvalidCommand"
    test2.push "CDOTAUserMsg_InvalidCommand-CDOTAUserMsg_InvalidCommand"

    test.push "OnCDOTAUserMsg_LocationPing-CDOTAUserMsg_LocationPing"
    test2.push "CDOTAUserMsg_LocationPing-CDOTAUserMsg_LocationPing"

    test.push "OnCDOTAUserMsg_MapLine-CDOTAUserMsg_MapLine"
    test2.push "CDOTAUserMsg_MapLine-CDOTAUserMsg_MapLine"

    test.push "OnCDOTAUserMsg_MiniKillCamInfo-CDOTAUserMsg_MiniKillCamInfo"
    test2.push "CDOTAUserMsg_MiniKillCamInfo-CDOTAUserMsg_MiniKillCamInfo"

    test.push "OnCDOTAUserMsg_MinimapDebugPoint-CDOTAUserMsg_MinimapDebugPoint"
    test2.push "CDOTAUserMsg_MinimapDebugPoint-CDOTAUserMsg_MinimapDebugPoint"

    test.push "OnCDOTAUserMsg_MinimapEvent-CDOTAUserMsg_MinimapEvent"
    test2.push "CDOTAUserMsg_MinimapEvent-CDOTAUserMsg_MinimapEvent"

    test.push "OnCDOTAUserMsg_NevermoreRequiem-CDOTAUserMsg_NevermoreRequiem"
    test2.push "CDOTAUserMsg_NevermoreRequiem-CDOTAUserMsg_NevermoreRequiem"

    test.push "OnCDOTAUserMsg_OverheadEvent-CDOTAUserMsg_OverheadEvent"
    test2.push "CDOTAUserMsg_OverheadEvent-CDOTAUserMsg_OverheadEvent"

    test.push "OnCDOTAUserMsg_SetNextAutobuyItem-CDOTAUserMsg_SetNextAutobuyItem"
    test2.push "CDOTAUserMsg_SetNextAutobuyItem-CDOTAUserMsg_SetNextAutobuyItem"

    test.push "OnCDOTAUserMsg_SharedCooldown-CDOTAUserMsg_SharedCooldown"
    test2.push "CDOTAUserMsg_SharedCooldown-CDOTAUserMsg_SharedCooldown"

    test.push "OnCDOTAUserMsg_SpectatorPlayerClick-CDOTAUserMsg_SpectatorPlayerClick"
    test2.push "CDOTAUserMsg_SpectatorPlayerClick-CDOTAUserMsg_SpectatorPlayerClick"

    test.push "OnCDOTAUserMsg_TutorialTipInfo-CDOTAUserMsg_TutorialTipInfo"
    test2.push "CDOTAUserMsg_TutorialTipInfo-CDOTAUserMsg_TutorialTipInfo"

    test.push "OnCDOTAUserMsg_UnitEvent-CDOTAUserMsg_UnitEvent"
    test2.push "CDOTAUserMsg_UnitEvent-CDOTAUserMsg_UnitEvent"

    test.push "OnCDOTAUserMsg_ParticleManager-CDOTAUserMsg_ParticleManager"
    test2.push "CDOTAUserMsg_ParticleManager-CDOTAUserMsg_ParticleManager"

    test.push "OnCDOTAUserMsg_BotChat-CDOTAUserMsg_BotChat"
    test2.push "CDOTAUserMsg_BotChat-CDOTAUserMsg_BotChat"

    test.push "OnCDOTAUserMsg_HudError-CDOTAUserMsg_HudError"
    test2.push "CDOTAUserMsg_HudError-CDOTAUserMsg_HudError"

    test.push "OnCDOTAUserMsg_ItemPurchased-CDOTAUserMsg_ItemPurchased"
    test2.push "CDOTAUserMsg_ItemPurchased-CDOTAUserMsg_ItemPurchased"

    test.push "OnCDOTAUserMsg_Ping-CDOTAUserMsg_Ping"
    test2.push "CDOTAUserMsg_Ping-CDOTAUserMsg_Ping"

    test.push "OnCDOTAUserMsg_ItemFound-CDOTAUserMsg_ItemFound"
    test2.push "CDOTAUserMsg_ItemFound-CDOTAUserMsg_ItemFound"

    test.push "OnCDOTAUserMsg_SwapVerify-CDOTAUserMsg_SwapVerify"
    test2.push "CDOTAUserMsg_SwapVerify-CDOTAUserMsg_SwapVerify"

    test.push "OnCDOTAUserMsg_WorldLine-CDOTAUserMsg_WorldLine"
    test2.push "CDOTAUserMsg_WorldLine-CDOTAUserMsg_WorldLine"

    test.push "OnCDOTAUserMsg_ItemAlert-CDOTAUserMsg_ItemAlert"
    test2.push "CDOTAUserMsg_ItemAlert-CDOTAUserMsg_ItemAlert"

    test.push "OnCDOTAUserMsg_HalloweenDrops-CDOTAUserMsg_HalloweenDrops"
    test2.push "CDOTAUserMsg_HalloweenDrops-CDOTAUserMsg_HalloweenDrops"

    test.push "OnCDOTAUserMsg_ChatWheel-CDOTAUserMsg_ChatWheel"
    test2.push "CDOTAUserMsg_ChatWheel-CDOTAUserMsg_ChatWheel"

    test.push "OnCDOTAUserMsg_ReceivedXmasGift-CDOTAUserMsg_ReceivedXmasGift"
    test2.push "CDOTAUserMsg_ReceivedXmasGift-CDOTAUserMsg_ReceivedXmasGift"

    test.push "OnCDOTAUserMsg_UpdateSharedContent-CDOTAUserMsg_UpdateSharedContent"
    test2.push "CDOTAUserMsg_UpdateSharedContent-CDOTAUserMsg_UpdateSharedContent"

    test.push "OnCDOTAUserMsg_TutorialRequestExp-CDOTAUserMsg_TutorialRequestExp"
    test2.push "CDOTAUserMsg_TutorialRequestExp-CDOTAUserMsg_TutorialRequestExp"

    test.push "OnCDOTAUserMsg_TutorialPingMinimap-CDOTAUserMsg_TutorialPingMinimap"
    test2.push "CDOTAUserMsg_TutorialPingMinimap-CDOTAUserMsg_TutorialPingMinimap"

    test.push "OnCDOTAUserMsg_GamerulesStateChanged-CDOTAUserMsg_GamerulesStateChanged"
    test2.push "CDOTAUserMsg_GamerulesStateChanged-CDOTAUserMsg_GamerulesStateChanged"

    test.push "OnCDOTAUserMsg_ShowSurvey-CDOTAUserMsg_ShowSurvey"
    test2.push "CDOTAUserMsg_ShowSurvey-CDOTAUserMsg_ShowSurvey"

    test.push "OnCDOTAUserMsg_TutorialFade-CDOTAUserMsg_TutorialFade"
    test2.push "CDOTAUserMsg_TutorialFade-CDOTAUserMsg_TutorialFade"

    test.push "OnCDOTAUserMsg_AddQuestLogEntry-CDOTAUserMsg_AddQuestLogEntry"
    test2.push "CDOTAUserMsg_AddQuestLogEntry-CDOTAUserMsg_AddQuestLogEntry"

    test.push "OnCDOTAUserMsg_SendStatPopup-CDOTAUserMsg_SendStatPopup"
    test2.push "CDOTAUserMsg_SendStatPopup-CDOTAUserMsg_SendStatPopup"

    test.push "OnCDOTAUserMsg_TutorialFinish-CDOTAUserMsg_TutorialFinish"
    test2.push "CDOTAUserMsg_TutorialFinish-CDOTAUserMsg_TutorialFinish"

    test.push "OnCDOTAUserMsg_SendRoshanPopup-CDOTAUserMsg_SendRoshanPopup"
    test2.push "CDOTAUserMsg_SendRoshanPopup-CDOTAUserMsg_SendRoshanPopup"

    test.push "OnCDOTAUserMsg_SendGenericToolTip-CDOTAUserMsg_SendGenericToolTip"
    test2.push "CDOTAUserMsg_SendGenericToolTip-CDOTAUserMsg_SendGenericToolTip"

    test.push "OnCDOTAUserMsg_SendFinalGold-CDOTAUserMsg_SendFinalGold"
    test2.push "CDOTAUserMsg_SendFinalGold-CDOTAUserMsg_SendFinalGold"

    test.push "OnCDOTAUserMsg_CustomMsg-CDOTAUserMsg_CustomMsg"
    test2.push "CDOTAUserMsg_CustomMsg-CDOTAUserMsg_CustomMsg"

    test.push "OnCDOTAUserMsg_CoachHUDPing-CDOTAUserMsg_CoachHUDPing"
    test2.push "CDOTAUserMsg_CoachHUDPing-CDOTAUserMsg_CoachHUDPing"

    test.push "OnCDOTAUserMsg_ClientLoadGridNav-CDOTAUserMsg_ClientLoadGridNav"
    test2.push "CDOTAUserMsg_ClientLoadGridNav-CDOTAUserMsg_ClientLoadGridNav"

    test.push "OnCDOTAUserMsg_TE_Projectile-CDOTAUserMsg_TE_Projectile"
    test2.push "CDOTAUserMsg_TE_Projectile-CDOTAUserMsg_TE_Projectile"

    test.push "OnCDOTAUserMsg_TE_ProjectileLoc-CDOTAUserMsg_TE_ProjectileLoc"
    test2.push "CDOTAUserMsg_TE_ProjectileLoc-CDOTAUserMsg_TE_ProjectileLoc"

    test.push "OnCDOTAUserMsg_TE_DotaBloodImpact-CDOTAUserMsg_TE_DotaBloodImpact"
    test2.push "CDOTAUserMsg_TE_DotaBloodImpact-CDOTAUserMsg_TE_DotaBloodImpact"

    test.push "OnCDOTAUserMsg_TE_UnitAnimation-CDOTAUserMsg_TE_UnitAnimation"
    test2.push "CDOTAUserMsg_TE_UnitAnimation-CDOTAUserMsg_TE_UnitAnimation"

    test.push "OnCDOTAUserMsg_TE_UnitAnimationEnd-CDOTAUserMsg_TE_UnitAnimationEnd"
    test2.push "CDOTAUserMsg_TE_UnitAnimationEnd-CDOTAUserMsg_TE_UnitAnimationEnd"

    test.push "OnCDOTAUserMsg_AbilityPing-CDOTAUserMsg_AbilityPing"
    test2.push "CDOTAUserMsg_AbilityPing-CDOTAUserMsg_AbilityPing"

    test.push "OnCDOTAUserMsg_ShowGenericPopup-CDOTAUserMsg_ShowGenericPopup"
    test2.push "CDOTAUserMsg_ShowGenericPopup-CDOTAUserMsg_ShowGenericPopup"

    test.push "OnCDOTAUserMsg_VoteStart-CDOTAUserMsg_VoteStart"
    test2.push "CDOTAUserMsg_VoteStart-CDOTAUserMsg_VoteStart"

    test.push "OnCDOTAUserMsg_VoteUpdate-CDOTAUserMsg_VoteUpdate"
    test2.push "CDOTAUserMsg_VoteUpdate-CDOTAUserMsg_VoteUpdate"

    test.push "OnCDOTAUserMsg_VoteEnd-CDOTAUserMsg_VoteEnd"
    test2.push "CDOTAUserMsg_VoteEnd-CDOTAUserMsg_VoteEnd"

    test.push "OnCDOTAUserMsg_BoosterState-CDOTAUserMsg_BoosterState"
    test2.push "CDOTAUserMsg_BoosterState-CDOTAUserMsg_BoosterState"

    test.push "OnCDOTAUserMsg_WillPurchaseAlert-CDOTAUserMsg_WillPurchaseAlert"
    test2.push "CDOTAUserMsg_WillPurchaseAlert-CDOTAUserMsg_WillPurchaseAlert"

    test.push "OnCDOTAUserMsg_TutorialMinimapPosition-CDOTAUserMsg_TutorialMinimapPosition"
    test2.push "CDOTAUserMsg_TutorialMinimapPosition-CDOTAUserMsg_TutorialMinimapPosition"

    test.push "OnCDOTAUserMsg_PlayerMMR-CDOTAUserMsg_PlayerMMR"
    test2.push "CDOTAUserMsg_PlayerMMR-CDOTAUserMsg_PlayerMMR"

    test.push "OnCDOTAUserMsg_AbilitySteal-CDOTAUserMsg_AbilitySteal"
    test2.push "CDOTAUserMsg_AbilitySteal-CDOTAUserMsg_AbilitySteal"

    test.push "OnCDOTAUserMsg_CourierKilledAlert-CDOTAUserMsg_CourierKilledAlert"
    test2.push "CDOTAUserMsg_CourierKilledAlert-CDOTAUserMsg_CourierKilledAlert"

    test.push "OnCDOTAUserMsg_EnemyItemAlert-CDOTAUserMsg_EnemyItemAlert"
    test2.push "CDOTAUserMsg_EnemyItemAlert-CDOTAUserMsg_EnemyItemAlert"

    test.push "OnCDOTAUserMsg_StatsMatchDetails-CDOTAUserMsg_StatsMatchDetails"
    test2.push "CDOTAUserMsg_StatsMatchDetails-CDOTAUserMsg_StatsMatchDetails"

    test.push "OnCDOTAUserMsg_MiniTaunt-CDOTAUserMsg_MiniTaunt"
    test2.push "CDOTAUserMsg_MiniTaunt-CDOTAUserMsg_MiniTaunt"

    test.push "OnCDOTAUserMsg_BuyBackStateAlert-CDOTAUserMsg_BuyBackStateAlert"
    test2.push "CDOTAUserMsg_BuyBackStateAlert-CDOTAUserMsg_BuyBackStateAlert"

    test.push "OnCDOTAUserMsg_SpeechBubble-CDOTAUserMsg_SpeechBubble"
    test2.push "CDOTAUserMsg_SpeechBubble-CDOTAUserMsg_SpeechBubble"

    test.push "OnCDOTAUserMsg_CustomHeaderMessage-CDOTAUserMsg_CustomHeaderMessage"
    test2.push "CDOTAUserMsg_CustomHeaderMessage-CDOTAUserMsg_CustomHeaderMessage"

    test.push "OnCDOTAUserMsg_QuickBuyAlert-CDOTAUserMsg_QuickBuyAlert"
    test2.push "CDOTAUserMsg_QuickBuyAlert-CDOTAUserMsg_QuickBuyAlert"

    test.push "OnCDOTAUserMsg_PredictionResult-CDOTAUserMsg_PredictionResult"
    test2.push "CDOTAUserMsg_PredictionResult-CDOTAUserMsg_PredictionResult"

    test.push "OnCDOTAUserMsg_ModifierAlert-CDOTAUserMsg_ModifierAlert"
    test2.push "CDOTAUserMsg_ModifierAlert-CDOTAUserMsg_ModifierAlert"

    test.push "OnCDOTAUserMsg_HPManaAlert-CDOTAUserMsg_HPManaAlert"
    test2.push "CDOTAUserMsg_HPManaAlert-CDOTAUserMsg_HPManaAlert"

    test.push "OnCDOTAUserMsg_GlyphAlert-CDOTAUserMsg_GlyphAlert"
    test2.push "CDOTAUserMsg_GlyphAlert-CDOTAUserMsg_GlyphAlert"

    test.push "OnCDOTAUserMsg_BeastChat-CDOTAUserMsg_BeastChat"
    test2.push "CDOTAUserMsg_BeastChat-CDOTAUserMsg_BeastChat"

    test.push "OnCDOTAUserMsg_SpectatorPlayerUnitOrders-CDOTAUserMsg_SpectatorPlayerUnitOrders"
    test2.push "CDOTAUserMsg_SpectatorPlayerUnitOrders-CDOTAUserMsg_SpectatorPlayerUnitOrders"

    test.push "OnCDOTAUserMsg_CustomHudElement_Create-CDOTAUserMsg_CustomHudElement_Create"
    test2.push "CDOTAUserMsg_CustomHudElement_Create-CDOTAUserMsg_CustomHudElement_Create"

    test.push "OnCDOTAUserMsg_CustomHudElement_Modify-CDOTAUserMsg_CustomHudElement_Modify"
    test2.push "CDOTAUserMsg_CustomHudElement_Modify-CDOTAUserMsg_CustomHudElement_Modify"

    test.push "OnCDOTAUserMsg_CustomHudElement_Destroy-CDOTAUserMsg_CustomHudElement_Destroy"
    test2.push "CDOTAUserMsg_CustomHudElement_Destroy-CDOTAUserMsg_CustomHudElement_Destroy"

    test.push "OnCDOTAUserMsg_CompendiumState-CDOTAUserMsg_CompendiumState"
    test2.push "CDOTAUserMsg_CompendiumState-CDOTAUserMsg_CompendiumState"

    test.push "OnCDOTAUserMsg_ProjectionAbility-CDOTAUserMsg_ProjectionAbility"
    test2.push "CDOTAUserMsg_ProjectionAbility-CDOTAUserMsg_ProjectionAbility"

    test.push "OnCDOTAUserMsg_ProjectionEvent-CDOTAUserMsg_ProjectionEvent"
    test2.push "CDOTAUserMsg_ProjectionEvent-CDOTAUserMsg_ProjectionEvent"

    test.push "OnCMsgDOTACombatLogEntry-CMsgDOTACombatLogEntry"
    test2.push "CMsgDOTACombatLogEntry-CMsgDOTACombatLogEntry"
    test.map { |item| item.split('-') }
  end
end