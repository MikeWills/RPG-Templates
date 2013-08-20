000100110106     H nomain option(*srcstmt:*nodebugio)
000200110106       //*************************************************************************
000300110106       // Program . . . . . IFS
000400110106       //
000500110106       // Created on  . . . 01/06/2011
000600110106       //         by  . . . Michael N. Wills
000700110106       //
000800110106       // Description . . .
000900110512       //
001000110512       // To Compile:
001100110512       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N)
001200110512       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
001300110516       // *> DLTSPLF FILE(&ON) SPLNBR(*LAST)
001400110106       //
001500110106       // CHANGE LOG:
001600110106       // Date       | Name            | Description
001700110106       // -----------------------------------------------------------------------
001800110106       //            |                 |
001900110106       //            |                 |
002000110106       //            |                 |
002100110106       //*************************************************************************
002200110106
002300110106       // Prototypes
002400110512      /copy QSRVSRC,IFS_H
002500110106      /copy IFSEBOOK/QRPGLESRC,IFSIO_H
002600110106
002700110106       // **********************************************************************
002800110106       // Global Definitions
002900110106     D fd              S             10I 0
003000110106
003100110106     D*--------------------------------------------------
003200110106     D* Procedure name: BuildFileMode
003300110106     D* Purpose:
003400110106     D* Returns:
003500110106     D* Parameter:      mode
003600110106     D*--------------------------------------------------
003700110106     D BuildFileMode   PR            10I 0
003800110106     D  mode                          3A   CONST
003900110106
004000110106     D*--------------------------------------------------
004100110106     D* Procedure name: BuildFileOFlag
004200110106     D* Purpose:
004300110106     D* Returns:
004400110106     D*--------------------------------------------------
004500110106     D BuildFileOFlag  PR            10I 0
004600110106     D  flags                         3A   const
004700110106     D  overwrite                      N   const
004800110106
004900110106
005000110106       // **********************************************************************
005100110106     P*--------------------------------------------------
005200110106     P* Procedure name: InitFile
005300110106     P* Purpose:        Initialize the file and prepare for writting the file
005400110106     P* Returns:        *ON if open error
005500110106     P* Parameter:      path
005600110106     P* Parameter:      file
005700110106     P* Parameter:      options => Pass options on how to open the file
005800110106     P* Parameter:      overwrite
005900110106     P*--------------------------------------------------
006000110106     P InitFile        B                   EXPORT
006100110106     D InitFile        PI            10I 0
006200110106     D  path                        512A   VARYING
006300110106     D                                     CONST
006400110106     D  mode                          3A   CONST
006500110106     D  flags                         3A   CONST
006600110106     D  overwrite                      N   CONST
006700110106     D                                     OPTIONS(*NOPASS)
006800110106
006900110106      /free
007000110107       callp unlink(%trim(path));
007100110107       return open(%trim(path):
007200110106                 BuildFileOFlag(flags:overwrite):
007300110107                 BuildFileMode(mode):819);
007400110106      /end-free
007500110106     P InitFile        E
007600110106
007700110106
007800110106     P*--------------------------------------------------
007900110106     P* Procedure name: CloseFile
008000110106     P* Purpose:
008100110106     P* Returns:
008200110106     P*--------------------------------------------------
008300110106     P CloseFile       B                   EXPORT
008400110106     D CloseFile       PI
008500110107     D  fileDesc                     10I 0 VALUE
008600110106      /free
008700110106       callp close(fileDesc);
008800110106      /end-free
008900110106     P CloseFile       E
009000110106
009100110106
009200110106     P*--------------------------------------------------
009300110106     P* Procedure name: WriteBuffer
009400110106     P* Purpose:
009500110106     P* Returns:        Number of bytes written
009600110106     P* Parameter:      buffer
009700110106     P*--------------------------------------------------
009800110106     P WriteBuffer     B                   EXPORT
009900110106     D WriteBuffer     PI            10I 0
010000110107     D  fileDesc                     10I 0 VALUE
010100110106     D  buffer                         *   VALUE
010200110106
010300110106
010400110106     D* Local fields
010500110106     D retField        S             10I 0
010600110106
010700110106      /free
010800110106
010900110106       return write(fd: %addr(buffer):%size(buffer));
011000110106
011100110106      /end-free
011200110106     P WriteBuffer     E
011300110106
011400110106
011500110106     P*--------------------------------------------------
011600110106     P* Procedure name: ReadBuffer
011700110106     P* Purpose:
011800110106     P* Returns:        number of bytes read
011900110106     P* Parameter:      buffer
012000110106     P*--------------------------------------------------
012100110106     P ReadBuffer      B                   EXPORT
012200110106     D ReadBuffer      PI            10I 0
012300110107     D  fileDesc                     10I 0 VALUE
012400110106     D  buffer                         *   VALUE
012500110106
012600110106
012700110106     D* Local fields
012800110106     D retField        S             10I 0
012900110106
013000110106      /free
013100110106
013200110106       retField = read(fd: %addr(buffer): %size(buffer));
013300110106
013400110106       return retField;
013500110106
013600110106      /end-free
013700110106     P ReadBuffer      E
013800110106
013900110106
014000110106     P*--------------------------------------------------
014100110106     P* Procedure name: DeleteFile
014200110106     P* Purpose:
014300110106     P* Returns:        Success = *on
014400110106     P* Parameter:      path
014500110106     P*--------------------------------------------------
014600110106     P DeleteFile      B                   EXPORT
014700110106     D DeleteFile      PI            10I 0
014800110106     D  path                        512A   VARYING
014900110106     D                                     CONST
015000110106
015100110106      /free
015200110106
015300110106       return unlink(path);
015400110106
015500110106      /end-free
015600110106     P DeleteFile      E
015700110106
015800110106
015900110106     P*--------------------------------------------------
016000110106     P* Procedure name: BuildFileMode
016100110106     P* Purpose:
016200110106     P* Returns:
016300110106     P* Parameter:      mode
016400110106     P*--------------------------------------------------
016500110106     P BuildFileMode   B
016600110106     D BuildFileMode   PI            10I 0
016700110106     D  mode                          3A   CONST
016800110106
016900110106     D* Local fields
017000110106     D retField        S             10I 0
017100110106
017200110106      /free
017300110106
017400110106       retField = 0;
017500110106
017600110106       //
017700110106       // User
017800110106       // No Permission
017900110106       if (%subst(mode:1:1) = '0');
018000110106         retField += 0;
018100110106       endif;
018200110106       // Execute
018300110106       if (%subst(mode:1:1) = '1');
018400110106         retField += S_IXUSR;
018500110106       endif;
018600110106       // Write
018700110106       if (%subst(mode:1:1) = '2');
018800110106         retField += S_IWUSR;
018900110106       endif;
019000110106       // Write & Execute
019100110106       if (%subst(mode:1:1) = '3');
019200110106         retField += S_IWUSR + S_IXUSR;
019300110106       endif;
019400110106       // Read
019500110106       if (%subst(mode:1:1) = '4');
019600110106         retField += S_IRUSR;
019700110106       endif;
019800110106       // Read & Execute
019900110106       if (%subst(mode:1:1) = '5');
020000110106         retField += S_IRUSR + S_IXUSR;
020100110106       endif;
020200110106       // Read & Write
020300110106       if (%subst(mode:1:1) = '6');
020400110106         retField += S_IRUSR + S_IWUSR;
020500110106       endif;
020600110106       // Read, Write & Execute
020700110106       if (%subst(mode:1:1) = '7');
020800110106         retField += S_IRWXU;
020900110106       endif;
021000110106
021100110106       //
021200110106       // Group
021300110106       // No Permission
021400110106       if (%subst(mode:2:1) = '0');
021500110106         retField += 0;
021600110106       endif;
021700110106       // Execute
021800110106       if (%subst(mode:2:1) = '1');
021900110106         retField += S_IXGRP;
022000110106       endif;
022100110106       // Write
022200110106       if (%subst(mode:2:1) = '2');
022300110106         retField += S_IWGRP;
022400110106       endif;
022500110106       // Write & Execute
022600110106       if (%subst(mode:2:1) = '3');
022700110106         retField += S_IWGRP + S_IXGRP;
022800110106       endif;
022900110106       // Read
023000110106       if (%subst(mode:2:1) = '4');
023100110106         retField += S_IRGRP;
023200110106       endif;
023300110106       // Read & Execute
023400110106       if (%subst(mode:2:1) = '5');
023500110106         retField += S_IRGRP + S_IXGRP;
023600110106       endif;
023700110106       // Read & Write
023800110106       if (%subst(mode:2:1) = '6');
023900110106         retField += S_IRGRP + S_IWGRP;
024000110106       endif;
024100110106       // Read, Write & Execute
024200110106       if (%subst(mode:2:1) = '7');
024300110106         retField += S_IRWXG;
024400110106       endif;
024500110106
024600110106       //
024700110106       // Other
024800110106       // No Permission
024900110106       if (%subst(mode:3:1) = '0');
025000110106         retField += 0;
025100110106       endif;
025200110106       // Execute
025300110106       if (%subst(mode:3:1) = '1');
025400110106         retField += S_IXOTH;
025500110106       endif;
025600110106       // Write
025700110106       if (%subst(mode:3:1) = '2');
025800110106         retField += S_IWOTH;
025900110106       endif;
026000110106       // Write & Execute
026100110106       if (%subst(mode:3:1) = '3');
026200110106         retField += S_IWOTH + S_IXOTH;
026300110106       endif;
026400110106       // Read
026500110106       if (%subst(mode:3:1) = '4');
026600110106         retField += S_IROTH;
026700110106       endif;
026800110106       // Read & Execute
026900110106       if (%subst(mode:3:1) = '5');
027000110106         retField += S_IROTH + S_IXOTH;
027100110106       endif;
027200110106       // Read & Write
027300110106       if (%subst(mode:3:1) = '6');
027400110106         retField += S_IROTH + S_IWOTH;
027500110106       endif;
027600110106       // Read, Write & Execute
027700110106       if (%subst(mode:3:1) = '7');
027800110106         retField += S_IRWXO;
027900110106       endif;
028000110106
028100110106       return retField;
028200110106
028300110106      /end-free
028400110106     P BuildFileMode   E
028500110106
028600110106
028700110106     P*--------------------------------------------------
028800110106     P* Procedure name: BuildFileOFlag
028900110106     P* Purpose:
029000110106     P* Returns:
029100110106     P*--------------------------------------------------
029200110106     P BuildFileOFlag  B
029300110106     D BuildFileOFlag  PI            10I 0
029400110106     D  flags                         3A   const
029500110106     D  overwrite                      N   const
029600110106
029700110106     D* Local fields
029800110106     D retField        S             10I 0
029900110106
030000110106      /free
030100110106
030200110107        retField = O_CREAT + O_CCSID +  O_TEXTDATA;
030300110106
030400110106        select;
030500110106          when flags = 'R';
030600110106            retField += O_RDONLY;
030700110106          when flags = 'W';
030800110106            retField += O_WRONLY;
030900110106          when flags = 'RW';
031000110106            retField += O_RDWR;
031100110106        endsl;
031200110106
031300110106        if (overwrite);
031400110106          retField += O_TRUNC;
031500110106        else;
031600110106          retField += O_APPEND;
031700110106        endif;
031800110106
031900110106        return retField;
032000110106
032100110106      /end-free
032200110106     P BuildFileOFlag  E
032300110106
