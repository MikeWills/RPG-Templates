000100060627     H NoMain
000200060627       //*************************************************************************
000300110411       // Program . . . . . F.STRING
000400060627       //
000500110411       // Created on  . . . 06/27/2006
000600110411       //         by  . . . Michael N. Wills
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
002200080111     D up              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
002300080111     D lo              C                   'abcdefghijklmnopqrstuvwxyz'
002400080111
002500060627       // Prototypes
002600110512      /copy qsrvsrc,string_h
002700060627
002800060627       // **********************************************************************
002900060627       // Global Definitions
003000060627
003100060627     P*--------------------------------------------------
003200060627     P* Procedure name: CenterText
003300060627     P* Purpose:        Center the text in a given string to for a given length
003400060627     P* Returns:        The centered string
003500060627     P* Parameter:      stringIn => The String to center
003600060627     P* Parameter:      fieldLength => The length of the field that the str...
003700060627     P*                          ing will be centered in
003800060627     P*--------------------------------------------------
003900060627     P CenterText      B                   EXPORT
004000060627     D CenterText      PI         32767A
004100060627     D  stringIn                  32767A   CONST
004200070626     D*                                    OPTIONS(*VARSIZE)
004300060627     D  fieldLength                   5P 0 CONST
004400060627
004500060627       // Local fields
004600060627     D retField        S          32767A
004700060627     D stringPosition  S              5P 0 inz(0)
004800060627
004900060627      /free
005000060627
005100060627       // Figure out
005200060627       stringPosition = (fieldLength - %len(%trim(stringIn))) / 2;
005300060627
005400080611       if (stringPosition = 0);
005500080611         stringPosition = 1;
005600080611       endif;
005700080611
005800060630       %subst(retField:stringPosition) = %trim(stringIn);
005900060627
006000060627       return retField;
006100060627
006200060627      /end-free
006300060627     P CenterText      E
006400060627
006500080111
006600080111     P*--------------------------------------------------
006700080111     P* Procedure name: ConvertToUpperCase
006800080111     P* Purpose:        Convert all characters to upper case
006900080111     P* Returns:
007000080111     P* Parameter:      stringIn
007100080111     P* Parameter:      lengthToConvert
007200080111     P*--------------------------------------------------
007300080111     P ConvertToUpperCase...
007400080111     P                 B                   EXPORT
007500080111     D ConvertToUpperCase...
007600080111     D                 PI         32767A   VARYING
007700080111     D  stringIn                  32767A   VARYING
007800080111     D                                     CONST
007900080111     D  lengthToConvert...
008000080111     D                                5P 0 CONST
008100080111     D                                     OPTIONS(*NOPASS)
008200080111
008300080111     D* Local fields
008400080111     D retField        S          32767A   VARYING
008500080111
008600080111      /free
008700080111
008800080111       select;
008900080111         when (%parms() = 1);
009000080111           retField = %xlate(lo:up:stringIn);
009100080111
009200080111         when (%parms() = 2);
009300080111           retField = %xlate(lo:up:stringIn:lengthToConvert);
009400080111
009500080111       endsl;
009600080111
009700080111       return retField;
009800080111
009900080111      /end-free
010000080111     P ConvertToUpperCase...
010100080111     P                 E
010200080111
010300080111
010400080111     P*--------------------------------------------------
010500080111     P* Procedure name: ConvertToLowerCase
010600080111     P* Purpose:        Convert all characters to upper case
010700080111     P* Returns:
010800080111     P* Parameter:      stringIn
010900080111     P* Parameter:      lengthToConvert
011000080111     P*--------------------------------------------------
011100080111     P ConvertToLowerCase...
011200080111     P                 B                   EXPORT
011300080111     D ConvertToLowerCase...
011400080111     D                 PI         32767A   VARYING
011500080111     D  stringIn                  32767A   VARYING
011600080111     D                                     CONST
011700080111     D  lengthToConvert...
011800080111     D                                5P 0 CONST
011900080111     D                                     OPTIONS(*NOPASS)
012000080111
012100080111     D* Local fields
012200080111     D retField        S          32767A   VARYING
012300080111
012400080111      /free
012500080111
012600080111       select;
012700080111         when (%parms() = 1);
012800080111           retField = %xlate(up:lo:stringIn);
012900080111
013000080111         when (%parms() = 2);
013100080111           retField = %xlate(up:lo:stringIn:lengthToConvert);
013200080111
013300080111       endsl;
013400080111
013500080111       return retField;
013600080111
013700080111      /end-free
013800080111     P ConvertToLowerCase...
013900080111     P                 E
014000080124
014100080124
014200080125     P*--------------------------------------------------
014300080125     P* Procedure name: WordWrap
014400080125     P* Purpose:        Wrap words so that they fit in the allowed space
014500080125     P* Returns:        Return the array with everything parsed
014600080125     P* Parameter:      stringIn
014700080125     P* Parameter:      trimLength
014800080125     P*--------------------------------------------------
014900080125     P WordWrap        B                   export
015000080125     D WordWrap        PI          4096A   dim(255)
015100080125     D  stringIn                  32767A   varying const options(*varsize)
015200080125     D  trimLength                    5P 0 const
015300080125
015400080125     D* Local fields
015500080207     D i               S              5P 0                                      Current Position
015600080207     D start           S              5P 0                                      Start of String
015700080207     D space           S              5P 0                                      Last Space Found
015800080207     D end             S              5P 0                                      End Of Line
015900080207     D length          S              5P 0                                      Length
016000080207     D x               S              5P 0                                      Array Position
016100080207     D lengthCounter   S              5P 0
016200080207     D stringInLen     S              5P 0
016300080125
016400080125      /free
016500080125
016600080207       i = 1;
016700080207       start = 1;
016800080207       space = 0;
016900080207       end = 0;
017000080207       length = 0;
017100080207       x = 0;
017200080207       lengthCounter = 0;
017300080207       stringInLen = 0;
017400080207
017500080207       dow (i < 255);
017600080207         retWordWrap(i) = ' ';
017700080207         i += 1;
017800080207       enddo;
017900080207
018000080207       i = 1;
018100080125       StringInLen = %len(%trim(stringIn));
018200080125
018300080125       dow i <= StringInLen and %subst(stringIn:i) <> ' ';
018400080125
018500080125         // Check to see if it is a space
018600080125         if %subst(stringIn:i:1) = ' ';
018700080125           space = i;
018800080125         endif;
018900080125
019000080125         if LengthCounter >= trimLength;
019100080125           end = space - 1;
019200080125           exsr AddString;
019300080125           start = space + 1;
019400080125           LengthCounter = (1 + (i - start + 1));
019500080125         endif;
019600080125
019700080125         i += 1;
019800080125         LengthCounter += 1;
019900080125       enddo;
020000080125
020100080207       end = i;
020200080125       exsr AddString;
020300080125
020400080125       return retWordWrap;
020500080125
020600080125       //-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
020700080125       // AddString - Add the line to the array
020800080125       begsr AddString;
020900080125
021000080125         x += 1;
021100080125         length = end - start + 1;
021200080125
021300080125         if length < 1;
021400080125           length = trimLength;
021500080125         endif;
021600080125
021700080410         if ((start + length) < stringInLen);
021800080410           retWordWrap(x) = %subst(stringIn:start:length);
021900080410         else;
022000080410           retWordWrap(x) = %subst(stringIn:start);
022100080410         endif;
022200080125
022300080125       endsr;    // AddString
022400080125      /end-free
022500080125     P WordWrap        E
022600080124
022700090611
022800090611     P*--------------------------------------------------
022900090611     P* Procedure name: SanitizeString
023000090611     P* Purpose:        Clean up any rouge characters in a string
023100090611     P* Returns:
023200090611     P* Parameter:      stringIn
023300090611     P*--------------------------------------------------
023400090611     P SanitizeString  B                   EXPORT
023500090611     D SanitizeString  PI         32767A   VARYING
023600090611     D  stringIn                  32767A   VARYING
023700090611     D                                     CONST
023800090611
023900090611     D* Local fields
024000090807     D temp            S          32767A   VARYING
024100090611     D retField        S          32767A   VARYING
024200090611     D position        S              6P 0
024300090611     D start           S              6P 0
024400090611
024500090611      /free
024600090611
024700090611       retField = stringIn;
024800090611
024900090611       // Replace a single quote with two single quotes
025000090611       position = %scan('''': stringIn);
025100090611
025200090611       dow (position > 0);
025300090807
025400090807         temp = %subst(retField:position+1);
025500090807         //retField = %replace('''''':retField:position:2);
025600090807         retField = %subst(retField:1:position-1) + '''''' + temp;
025700090807         start = position + 2;
025800090807         position = %scan('''': retField: start);
025900090611
026000090611       enddo;
026100090611
026200090611        return retField;
026300090611
026400090611      /end-free
026500091109     P SanitizeString  E
026600091109
026700091109
026800091109     P*--------------------------------------------------
026900091109     P* Procedure name: FindReplace
027000091109     P* Purpose:
027100091109     P* Returns:
027200091109     P* Parameter:      string
027300091109     P* Parameter:      findString
027400091109     P*--------------------------------------------------
027500091109     P FindReplace     B                   EXPORT
027600091109     D FindReplace     PI         32767A   VARYING
027700100827     D  source                    32767A   VARYING
027800091109     D                                     CONST
027900100827     D  find                        255A   VARYING
028000100827     D                                     VALUE
028100100827     D  replace                     255A   VARYING
028200100827     D                                     VALUE
028300100827
028400100827     D work            S                   like(source)
028500091109
028600091109      /free
028700100827       work = source;
028800100827
028900100827       dow (%scan(find:work) > 0);
029000100827         work = %replace(replace:work:%scan(find:work):%len(find));
029100100827       enddo;
029200091109
029300100827       return work;
029400091109
029500091109      /end-free
029600091109     P FindReplace     E
029700091109
029800100805
029900100805     P*--------------------------------------------------
030000100827     P* Procedure name: RtrimZeros
030100100805     P* Purpose:
030200100805     P* Returns:
030300100805     P* Parameter:      string
030400100805     P* Parameter:      number decimal places
030500100805     P*--------------------------------------------------
030600100805     P RtrimZeros      B                   EXPORT
030700100805
030800100805     D RtrimZeros      PI            25
030900100805     D  cStringIn                    25    Value
031000100805     D  nDecPlaces                    2  0 Value
031100100805
031200100805     D cStringOut      S             25
031300100805     D nStartPos       S              2  0
031400100805
031500100805      /free
031600100805       // Determine the start position
031700100805       nStartPos = %scan('.':cStringIn)+nDecPlaces+1;
031800100805       if %CHECKR(' 0':cStringIn) > nStartPos;
031900100805         nStartPos = %CHECKR(' 0':cStringIn);
032000100805       endif;
032100100805
032200100805       return %XLATE('0':' ':cStringIn:nStartPos);
032300100805      /end-free
032400100805
032500100805     P                 E
032600110512
032700110512
032800110512     P*--------------------------------------------------
032900110512     P* Procedure name: RightAlign
033000110512     P* Purpose:
033100110512     P* Returns:
033200110512     P* Parameter:      textIn
033300110512     P*--------------------------------------------------
033400110512     P RightAlign      B                   EXPORT
033500110512     D RightAlign      PI         32767A   VARYING
033600110512     D  textIn                    32767A   VARYING
033700110512     D                                     CONST
033800110512     D  length                        5I 0 CONST
033900110512
034000110512     D* Local fields
034100110512     D retField        S          32767A
034200110512     D startPosn       S              5I 0
034300110512
034400110512      /free
034500110512       startPosn = length - %len(%trim(textIn));
034600110512       if (startPosn = 0);
034700110512         return textIn;
034800110512       endif;
034900110512       %subst(retField:startPosn) = %trim(textIn);
035000110512       return retField;
035100110512      /end-free
035200110512     P RightAlign      E
035300110512
