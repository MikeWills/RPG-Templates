000100080118       // **********************************************************************
000200080118       // Copybook for misc commands
000300080118
000400080118     D*--------------------------------------------------
000500080118     D* Procedure name: ErrorMsg
000600080118     D* Purpose:        Pop-up a screen with a longer error message
000700080118     D* Returns:
000800080118     D* Parameter:      errorText
000900080118     D*--------------------------------------------------
001000080118     D ErrorMsg        PR
001100080118     D  errorText                   150A   VARYING
001200080118     D                                     CONST
001300081010
001400081010     D*--------------------------------------------------
001500081010     D* Procedure name: PromptMsg
001600081010     D* Purpose:        Pop-up a screen with a longer error message
001700081010     D* Returns:
001800081010     D* Parameter:      errorText
001900081010     D*--------------------------------------------------
002000081010     D PromptMsg       PR              N
002100081010     D  errorText                   150A   VARYING
002200081010     D                                     CONST
