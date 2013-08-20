000100071219     H NoMain
000200071219       //*************************************************************************
000300071219       // Program . . . . . CSV
000400071219       //
000500110620       // Created on  . . . 06/20/2011
000600110620       //         by  . . . Mike Wills (http://mikewills.me)
000700071219       //
000800110620       // Description . . . Parse CSV files
000900110512       //
001000110512       // To Compile:
001100110622       // *> CRTRPGMOD MODULE(MODULES/CSV) SRCFILE(MODULES/QMODSRC) SRCMBR(CSV)
001200110622       // *> CRTSRVPGM SRVPGM(MODULES/CSV) OPTION(*DUPPROC)
001300110620       // *> DLTSPLF FILE(CSV) SPLNBR(*LAST)
001400071219       //
001500071219       // CHANGE LOG:
001600071219       // Date       | Name            | Description
001700071219       // -----------------------------------------------------------------------
001800071219       //            |                 |
001900071219       //            |                 |
002000071219       //            |                 |
002100071219       //*************************************************************************
002200071219
002300071219       // Prototypes
002400110512      /copy qsrvsrc,csv_h
002500071219
002600071219       // **********************************************************************
002700071219       // Global Definitions
002800071219
003001110620     D gCsvDelimter    S              1A
003002110620     D gCsvDefaultDelimater...
003003110620     D                 S              1A   inz(',')
003004110620     D gCsvString      S          65535A   varying
003097110620     d gCsvPosition    S             10I 0
003098110620     d gCsvLastDelimiterPosition...
003099110620     d                 S             10I 0
003100110620     d gCsvNextDelimiterPosition...
003101110620     d                 S             10I 0
003102110621     d gCsvField       S          32767A   varying
003103110621
003104110622
003105110620     P*--------------------------------------------------
003106110620     P* Procedure name: LoadCsvString
003107110620     P* Purpose:        Gets the next field in the line
003108110620     P* Returns:
003109110620     P* Parameter:      csvString
003110110620     P* Parameter:      csvDelimiter
003111110620     P*--------------------------------------------------
003112110620     P LoadCsvString   B                   EXPORT
003113110620     D LoadCsvString   PI
003114110620     D  csvString                 65535A   const varying
003115110620     D  csvDelimiter                  1A   CONST
003116110620     D                                     OPTIONS(*NOPASS)
003117110620      /free
003118110620       if (%parms = 2);
003119110620         gCsvDelimter = csvDelimiter;
003120110620       else;
003121110620         gCsvDelimter = gCsvDefaultDelimater;
003123110620       endif;
003125110620       gCsvString = csvString;
003126110621       gCsvPosition = -1;
003127110621       gCsvLastDelimiterPosition = -1;
003128110620      /end-free
003129110620     P LoadCsvString   E
003141110620
003142110620
003143110620     P*--------------------------------------------------
003144110620     P* Procedure name: GetNextField
003145110620     P* Purpose:        Get the next field in the string
003146110620     P* Returns:
003147110620     P*--------------------------------------------------
003148110620     P GetNextField    B                   EXPORT
003149110620     D GetNextField    PI         32767A   VARYING
003154110620
003155110621     D fieldLength     S             10I 0
003156110621
003157110620      /free
003158110621       // Determine if this is the first field
003159110621       if (gCsvLastDelimiterPosition < 0);
003160110621         gCsvLastDelimiterPosition = 0;
003161110621       else;
003162110621         gCsvLastDelimiterPosition = gCsvNextDelimiterPosition;
003163110621       endif;
003164110621
003165110621       //Determine the next delimiter
003166110621       if (%subst(gCsvString:gCsvLastDelimiterPosition + 1:1) = '"');
003167110621         gCsvLastDelimiterPosition += 1;
003168110621         gCsvNextDelimiterPosition =
003169110621             %scan('"':gCsvString:gCsvLastDelimiterPosition);
003170110621       else;
003171110621         gCsvNextDelimiterPosition =
003172110621             %scan(gCsvDelimter:gCsvString:gCsvLastDelimiterPosition + 1);
003173110621       endif;
003174110621
003175110621       fieldLength = gCsvNextDelimiterPosition - gCsvLastDelimiterPosition + 1;
003176110621
003177110621       gCsvField = %subst(gCsvString:gCsvLastDelimiterPosition + 1:fieldLength);
003178110621
003179110621       return gCsvField;
003180110620
003181110620      /end-free
003182110620     P GetNextField    E
003183110620
