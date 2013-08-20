000100121009     H nomain option(*srcstmt:*nodebugio)
000200121009       //*************************************************************************
000300121009       // Program . . . . . T_MOD
000400121009       //
000500121009       // Created on  . . .
000600121009       //         by  . . .
000700121009       //
000800121009       // Description . . .
000900121009       //
001000121009       // To Compile:
001100121010       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N) DBGVIEW(*SOURCE)
001200121009       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
001300121009       //
001400121009       // CHANGE LOG:
001500121009       // Date       | Name            | Description
001600121009       // -----------------------------------------------------------------------
001700121009       //            |                 |
001800121009       //            |                 |
001900121009       //            |                 |
002000121009       //*************************************************************************
002100121009
002200121009       // Prototypes
002300121009      /copy QSRVSRC,BANK_H
002400121009
002500121009       // **********************************************************************
002600121009       // Global Definitions
002700121009
002800121009     P*--------------------------------------------------
002900121009     P* Procedure name: IsValidRoutingNumber
003000121009     P* Purpose:        Validate the routing number is a valid number (not ...
003100121009     P*                          necessarily the right number)
003200121009     P* Returns:        Returns true/false
003300121009     P* Parameter:      routingNumber
003400121009     P*--------------------------------------------------
003500121009     P IsValidRoutingNumber...
003600121009     P                 B                   EXPORT
003700121009     D IsValidRoutingNumber...
003800121009     D                 PI              N
003900121009     D  routingNumber                10I 0 CONST
004000121009
004100121009     D* Local fields
004200121009     D str             S              9A
004300121009     D checkDigit      S             18P 5
004400121009     D retField        S               N
004500121009
004600121009      /free
004700121009
004800121010       evalr str = %editc(routingNumber:'X');
004900121009
005000121009       checkDigit = %rem((3 * (%int(%subst(str:1:1)) + %int(%subst(str:4:1)) +
005100121009                            %int(%subst(str:7:1)))) +
005200121009                         (7 * (%int(%subst(str:2:1)) + %int(%subst(str:5:1)) +
005300121009                            %int(%subst(str:8:1)))) +
005400121009                         (%int(%subst(str:3:1)) + %int(%subst(str:6:1)) +
005500121009                            %int(%subst(str:9:1))):10);
005600121009
005700121009       if (checkDigit = 0);
005800121009         return *on;
005900121009       else;
006000121009         return *off;
006100121009       endif;
006200121009
006300121009      /end-free
006400121009     P IsValidRoutingNumber...
006500121009     P                 E
006600121009
