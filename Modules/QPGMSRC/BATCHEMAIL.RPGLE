000100061012     H ActGrp(*caller) BndDir('MODULES') DftActGrp(*no)
000200061012       //*************************************************************************
000300061012       // Program . . . . . BATCHEMAIL
000400061012       //
000500061012       // Created on  . . . 10/12/2006
000600061012       //         by  . . . Michael N. Wills
000700061012       //
000800061012       // Description . . .
000900061012       //
001000061012       // CHANGE LOG:
001100061012       // Date       | Name            | Description
001200061012       // -----------------------------------------------------------------------
001300061012       //            |                 |
001400061012       //            |                 |
001500061012       //            |                 |
001600061012       //*************************************************************************
001700061012       // Entry Parms
002303070619     D BATCHEMAIL      PR                  extpgm('BATCHEMAIL')
002304070620     D fromAddress                  100A   CONST VARYING
002305070620     D toAddress                  32767A   CONST VARYING
002306070620     D ccAddress                  32767A   CONST VARYING
002307070620     D bccAddress                 32767A   CONST VARYING
002308070620     D subject                    32767A   CONST VARYING
002309070620     D body                       32767A   CONST VARYING
002311070619     D BATCHEMAIL      PI
002312070620     D fromAddress                  100A   CONST VARYING
002313070620     D toAddress                  32767A   CONST VARYING
002314070620     D ccAddress                  32767A   CONST VARYING
002315070620     D bccAddress                 32767A   CONST VARYING
002316070620     D subject                    32767A   CONST VARYING
002317070620     D body                       32767A   CONST VARYING
002400061012
002500061012       //*************************************************************************
002600061012       // External Subprocedures
002700061012      /COPY MODULES/QSRVSRC,P.EMAIL
002800061012
003800061012       //*************************************************************************
003900061012      /free
004003070620
004100070620       SendEmail(fromAddress:
004200070619                 toAddress:
004300070619                 ccAddress:
004400070619                 bccAddress:
004500070619                 subject:
004600070619                 body);
004700061012
004800061012       *INLR = *On;
004900061012
005000061012      /end-free
