000100091216     H nomain option(*srcstmt:*nodebugio)
000200091216       //*************************************************************************
000300091216       // Program . . . . . WEB
000400091216       //
000500091216       // Created on  . . . 12/16/2009
000600091216       //         by  . . . Michael N. Wills
000700091216       //
000800091216       // Description . . .
000900110513       //
001000110513       // To Compile:
001100110513       // *> CRTRPGMOD MODULE(MODULES/WEB) SRCFILE(MODULES/QMODSRC) SRCMBR(WEB) -
001200110513       // *>   BNDDIR(QC2LE)
001300110513       // *> CRTSRVPGM SRVPGM(MODULES/WEB) OPTION(*DUPPROC) -
001400110513       // *>   BNDSRVPGM((QHTTPSVR/QZHBCGI))
001500110516       // *> DLTSPLF FILE(&ON) SPLNBR(*LAST)
001600091216       //
001700091216       // CHANGE LOG:
001800091216       // Date       | Name            | Description
001900091216       // -----------------------------------------------------------------------
002000091216       //            |                 |
002100091216       //            |                 |
002200091216       //            |                 |
002300091216       //*************************************************************************
002400091216
002500091216       // Prototypes
002600110513      /copy QSRVSRC,WEB_H
002700110513      /copy QSRVSRC,USRSPC_H
002800091216
002900091216       // **********************************************************************
003000091216       // Global Definitions
003100091216
003200091217     P*--------------------------------------------------
003300091217     P* Procedure name: WriteToStdOut
003400091217     P* Purpose:
003500091217     P* Returns:
003600091217     P* Parameter:      buffer
003700091217     P*--------------------------------------------------
003800091217     P WriteToStdOut   B                   EXPORT
003900091217     D WriteToStdOut   PI
004000091217     D  buffer                    32767A   VARYING
004100091217     D                                     CONST
004200091217      /free
004300091217       WriteStandardOut(buffer:%len(buffer):ErrCodeWeb);
004400091217      /end-free
004500091217     P WriteToStdOut   E
004600091222
004700091222
004800091222     P*--------------------------------------------------
004900091222     P* Procedure name: CgiParseInz
005000091222     P* Purpose: http://systeminetwork.com/node/26490
005100091222     P* Returns:
005200091222     P*--------------------------------------------------
005300091222     P CgiParseInz     B                   EXPORT
005400091222     D CgiParseInz     PI            10I 0
005500091222
005600091222     D cgiBuffer       S           4096A
005700091222     D reqMethod       S             10A
005800091222     D nContentLen     S             10I 0
005900091222     D nBytesRead      S             10I 0
006000091222     D api_error       S             64A   Inz(*ALLX'00')
006100091222      /free
006200091222
006300091222       ///////////////////////////////////////////////////
006400091222       //  If the request_method is "POST", then
006500091222       //  we use cgiParse to initialize the QUERY_STRING
006600091222       //  environment variable so we can use it
006700091222       //  similar to the 'GET' method.
006800091222       ///////////////////////////////////////////////////
006900091222       reqMethod = %str(getenv('REQUEST_METHOD'));
007000091222       nContentLen = %int(%str(getenv('CONTENT_LENGTH')));
007100091222
007200091223       if (reqMethod = 'POST' and nContentLen  > 0);
007300091222         cgiParse('-i ':'CGII0100': cgiBuffer: %size(cgiBuffer) :
007400091222                  nBytesRead : api_error);
007500091222         if (nBytesRead  > 0);
007600091222           putenv(%subst(cgiBuffer:1:nBytesRead)); // Set QRY_STR
007700091222           putenv('REQUEST_METHOD=GET');  // Override method
007800091222         endif;
007900091222
008000091222       endif;
008100091222       return nBytesRead;
008200091222      /end-free
008300091222     P CgiParseInz     E
008400091222
008500091222
008600091222     P*--------------------------------------------------
008700091222     P* Procedure name: CgiParseGet
008800091222     P* Purpose: http://systeminetwork.com/node/26490
008900091222     P* Returns:
009000091222     P*--------------------------------------------------
009100091222     P CgiParseGet     B                   EXPORT
009200091222     D CgiParseGet     PI          4096A
009300091222     D   varName                    120A   Const Varying
009400091222     D   nIndex                      10I 0 Const OPTIONS(*NOPASS)
009500091222
009600091222     D szCmd           S            128A
009700091222     D seps            S             10A   Inz(X'250040') Varying
009800091222     D cgiValue        S           4096A
009900091222     D nBytesRead      S             10I 0
010000091222     D nLen            S             10I 0
010100091222     D api_error       S             64A   Inz(*ALLX'00')
010200091222
010300091222      /free
010400091222       if (varName = ' ');
010500091222         return '';
010600091222       endif;
010700091222
010800091222       szCmd = '-v ' + %trimR(varName);
010900091222       if  (%parms()  >= 2); // Index specified?
011000091222         if (nIndex  > 1);
011100091222           szCmd = '-' + %char(nIndex) + ' -v ' + %trimR(varName);
011200091222         endif;
011300091222       endif;
011400091222
011500091222       cgiParse(szCmd:'CGII0100': cgiValue: %size(cgiValue) :
011600091222                nBytesRead : api_error);
011700091222
011800091222         if  (nBytesRead  > 0);
011900091222           nLen = %checkR(seps:%subst(cgiValue : 1 : nBytesRead));
012000091222           if (nLen  > 0);  // Remove separators
012100091222             nBytesRead -= (nBytesRead - nLen);
012200091222           endif;
012300091222           if (nBytesRead  > 0); // Still have something to return?
012400091222             return %subst(cgiValue : 1 : nBytesRead);
012500091222           endif;
012600091222         endif;
012700091222       return '';
012800091222      /end-free
012900091222     P CgiParseGet     E
013000091222
013100091222
013200091222     P*--------------------------------------------------
013300091222     P* Procedure name: CgiParseGetCount
013400091222     P* Purpose: http://systeminetwork.com/node/26490
013500091222     P* Returns:
013600091222     P*--------------------------------------------------
013700091222     P CgiParseGetCount...
013800091222     P                 B                   EXPORT
013900091222     D CgiParseGetCount...
014000091222     D                 PI            10I 0
014100091222     D   varName                    120A   Const Varying
014200091222
014300091222     D szCmd           S            128A
014400091222     D seps            S             10A   Inz(X'250040') Varying
014500091222     D cgiValue        S           4096A
014600091222     D nBytesRead      S             10I 0
014700091222     D nLen            S             10I 0
014800091222     D api_error       S             64A   Inz(*ALLX'00')
014900091222
015000091222      /free
015100091222       if (varName = ' ');
015200091222         return 0;
015300091222       endif;
015400091222
015500091222       szCmd = '-c ' + %trimR(varName);
015600091222
015700091222       cgiParse(szCmd:'CGII0100': cgiValue: %size(cgiValue) :
015800091222                nBytesRead : api_error);
015900091222       if (nBytesRead  > 0);
016000091222         nLen = %checkR(seps:%subst(cgiValue : 1 : nBytesRead));
016100091222         if (nLen  > 0);  // Remove separators
016200091222           nBytesRead -= (nBytesRead - nLen);
016300091222         endif;
016400091222         if (nBytesRead  > 0); // Still have something to return?
016500091222           return %int(%subst(cgiValue : 1 : nBytesRead));
016600091222         endif;
016700091222       endif;
016800091222       return 0;
016900091222      /end-free
017000091222     P CgiParseGetCount...
017100091222     P                 E
017200091217
