000100080118     H NoMain
000200101222     H BNDDIR('MODULES')
000300080118       //*************************************************************************
000400080118       // Program . . . . . ADVERROR
000500080118       //
000600080118       // Created on  . . .
000700080118       //         by  . . .
000800080118       //
000900080118       // Description . . .
001000110512       //
001100110512       // To Compile:
001200110512       // *> CRTRPGMOD MODULE(MODULES/ADVERROR) SRCFILE(MODULES/QMODSRC) -
001300121015       // *>   SRCMBR(ADVERROR) DBGVIEW(*SOURCE)
001400110512       // *> CRTSRVPGM SRVPGM(MODULES/ADVERROR) OPTION(*DUPPROC)
001500110516       // *> DLTSPLF FILE(ADVERROR) SPLNBR(*LAST)
001600080118       //
001700080118       // CHANGE LOG:
001800080118       // Date       | Name            | Description
001900080118       // -----------------------------------------------------------------------
002000080118       //            |                 |
002100080118       //            |                 |
002200080118       //            |                 |
002300080118       //*************************************************************************
002400101222     FADVERRORFMCF   E             WORKSTN USROPN
002500080118
002600080118       // Prototypes
002700110512      /copy qsrvsrc,adverror_h
002800110512      /copy modules/qsrvsrc,string_h
002900080125
003000080118       // **********************************************************************
003100080118       // Global Definitions
003200081010
003300081010     P*--------------------------------------------------
003400081010     P* Procedure name: ErrorMsg
003500081010     P* Purpose:        Pop-up a screen with a longer error message
003600081010     P* Returns:
003700081010     P* Parameter:      errorText
003800081010     P*--------------------------------------------------
003900081010     P ErrorMsg        B                   EXPORT
004000081010     D ErrorMsg        PI
004100081010     D  errorText                   150A   VARYING
004200081010     D                                     CONST
004300081010
004400081010     D len             S              3P 0
004500081010
004600081010      /free
004700081010
004800101222       if (not %open(ADVERRORFM));
004900101222         open ADVERRORFM;
005000101222       endif;
005100101222
005200081010       retWordWrap = WordWrap(errorText:50);
005300081010
005400081010       wError1 = %subst(retWordWrap(1):1:50);
005500081010       wError2 = %subst(retWordWrap(2):1:50);
005600081010       wError3 = %subst(retWordWrap(3):1:50);
005700081010
005800081010       exfmt ERRORSCRN;
005900101222
006000101222       close ADVERRORFM;
006100081010
006200081010       return;
006300081010
006400081010      /end-free
006500081010     P ErrorMsg        E
006600081010
006700080118
006800080118     P*--------------------------------------------------
006900081010     P* Procedure name: PromptMsg
007000080118     P* Purpose:        Pop-up a screen with a longer error message
007100080118     P* Returns:
007200080118     P* Parameter:      errorText
007300080118     P*--------------------------------------------------
007400081010     P PromptMsg       B                   EXPORT
007500081010     D PromptMsg       PI              N
007600080118     D  errorText                   150A   VARYING
007700080118     D                                     CONST
007800080118
007900080118     D len             S              3P 0
008000080118
008100080118      /free
008200101222
008300101222       if (not %open(ADVERRORFM));
008400101222         open ADVERRORFM;
008500101222       endif;
008600080118
008700080125       retWordWrap = WordWrap(errorText:50);
008800080125
008900080125       wError1 = %subst(retWordWrap(1):1:50);
009000080125       wError2 = %subst(retWordWrap(2):1:50);
009100080125       wError3 = %subst(retWordWrap(3):1:50);
009200080118
009300081013       exfmt PROMPTSCRN;
009400081013
009500081010       if (not *in12);
009600081010         if (wPrompt = 'Y');
009700081010           return *on;
009800081010         else;
009900081010           return *off;
010000081010         endif;
010100081010       endif;
010200081010
010300101222       close ADVERRORFM;
010400101222
010500081010       return *off;
010600080118
010700080118      /end-free
010800081010     P PromptMsg       E
010900080118
