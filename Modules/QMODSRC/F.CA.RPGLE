000100060627     H NoMain
000200060627       //*************************************************************************
000300060627       // Program . . . . . F.pgmname
000400060627       //
000500060627       // Created on  . . .
000600060627       //         by  . . .
000700060627       //
000800060627       // Description . . .
000900110512       //
001000110512       // To Compile:
001100110512       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N)
001200110512       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
001300110516       // *> DLTSPLF FILE(&ON) SPLNBR(*LAST)
001400060627       //
001500060627       // CHANGE LOG:
001600060627       // Date       | Name            | Description
001700060627       // -----------------------------------------------------------------------
001800060627       //            |                 |
001900060627       //            |                 |
002000060627       //            |                 |
002100060627       //*************************************************************************
002200060627       // Files
002300060627     FCAMASTP   IF   E           K DISK    usropn
002400060627       // Prototypes
002500060627      /copy QSRVSRC,P.CA
002600060627
002700060627       // **********************************************************************
002800060627       // Global Definitions
002900060627
003000060627     P*--------------------------------------------------
003100060627     P* Procedure name: GetCAUKeyInfo
003200060627     P* Purpose:        Get the Common Address Unique Key Info
003300060627     P* Returns:        cauKey Data Return
003400060627     P* Parameter:      cauKey => Common Address Key
003500060627     P*--------------------------------------------------
003600060627     P GetCAUKeyInfo   B                   EXPORT
003700060627     D GetCAUKeyInfo   PI            88A
003800060627     D  cauKey                        6P 0 CONST
003900060627
004000060627      /free
004100060731       monitor;
004200060731         open CAMASTP;
004300060731       on-error *ALL;
004400060731       endmon;
004500060731
004600060627       chain (cauKey) CAMASTP;
004700060627
004800060627       retCaPin = caPin;
004900060627       retOwner = caName;
005000060627       retCaStNu = caStNu;
005100060627       retCaStEx = caStEx;
005200060627       retCaStNa = caStNa;
005300060627       retCaStSu = caStSu;
005400060627       retCaStDir = caDir;
005500060627
005600060731       monitor;
005700060731         close CAMASTP;
005800060731       on-error *ALL;
005900060731       endmon;
006000060627
006100060627       return caReturnDS;
006200060627      /end-free
006300060627     P GetCAUKeyInfo   E
006400060720
006500060720     P*--------------------------------------------------
006600060720     P* Procedure name: BuildAddress
006700060720     P* Purpose:        Join the Address into one text field
006800060720     P* Returns:        Joined Address
006900060720     P* Parameter:      CommonAddrKey
007000060720     P*--------------------------------------------------
007100060720     P BuildAddress    B                   EXPORT
007200060720     D BuildAddress    PI            40A
007300060720     D  CommonAddrKey                 6P 0 CONST
007400060720
007500060720     D fullAddr        S             40A
007600060720      /FREE
007700060720
007800060731       monitor;
007900060731         open CAMASTP;
008000060731       on-error *ALL;
008100060731       endmon;
008200060731
008300060720       chain (CommonAddrKey) CAMASTP;
008400060720
008500060720       if %found();
008600060720
008700060720         if caStEx <> ' ';
008800060720           fullAddr = %trim(caStNu) + ' ' + %trim(caStEx);
008900060720         else;
009000060720           fullAddr = %trim(caStNu);
009100060720         endif;
009200060720
009300060720         fullAddr = %trim(fullAddr) + ' ' + %trim(caStNa) + ' ' +
009400071010                    %trim(caStSu) + %trim(caDir);
009500060720
009600060720       endif;
009700060720
009800060731       monitor;
009900060731         close CAMASTP;
010000060731       on-error *ALL;
010100060731       endmon;
010200060731
010300060720
010400060720       return fullAddr;
010500060720
010600060720      /END-FREE
010700060720     P BuildAddress    E
010800060720
