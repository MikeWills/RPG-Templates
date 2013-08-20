000100060608     H NoMain
000200060608       //*************************************************************************
000300120522       // Program . . . . . DATE
000400060608       //
000500110411       // Created on  . . . 06/08/2006
000600110411       //         by  . . . Michael N. Wills
000700060608       //
000800060608       // Description . . .
000900110512       //
001000110512       // To Compile:
001100110512       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N)
001200110512       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
001300110516       // *> DLTSPLF FILE(&ON) SPLNBR(*LAST)
001400060608       //
001500060608       // CHANGE LOG:
001600060608       // Date       | Name            | Description
001700060608       // -----------------------------------------------------------------------
001800060608       //            |                 |
001900060608       //            |                 |
002000060608       //            |                 |
002100060608       //*************************************************************************
002200090901     FHOLIDAYP  IF   E           K DISK    usropn
002300090901
002400060608       // Prototypes
002500120522      /copy qsrvsrc,date_h
002600060608
002700060608       // **********************************************************************
002800060608       // Global Definitions
002900060714
003000060714     P*--------------------------------------------------
003100060714     P* Procedure name: IsValidDate
003200060714     P* Purpose:        Validate a date in numeric format
003300060714     P* Returns:
003400060714     P* Parameter:      DateIn YYYYMMDD format only
003500060714     P*--------------------------------------------------
003600060714     P IsValidDate     B                   EXPORT
003700060714     D IsValidDate     PI              N
003800060714     D  DateIn                        8P 0 CONST
003900060714
004000060714       // Work fields
004100060714     D workDate        S               D
004200060717     D retField        S               N   inz(*ON)
004300060714
004400060714      /free
004500060714
004600060717
004700060717       // Check for valid YYYYMMDD
004800060714       monitor;
004900060717         retField = *ON; // Assume is valid
005000060717         workDate = %date(DateIn:*ISO);
005100060714       on-error *ALL;
005200060717         retField = *OFF;  // It is not valid
005300060714       endmon;
005400070912
005500070912       if (not retField);
005600060717
005700070912         // Maybe the date is in MMDDYYYY format
005800070912         monitor;
005900070912           retField = *ON; // Assume is valid
006000070912           workDate = %date(DateIn:*USA);
006100070912         on-error;
006200070912           retField = *OFF;
006300070912         endmon;
006400070912
006500070912       endif;
006600060714
006700060717       return retField;    // It is valid
006800060714
006900060714      /end-free
007000060714     P IsValidDate     E
007100060714
007200070725     P*--------------------------------------------------
007300070725     P* Procedure name: ConvertDecimalDateToUsa
007400070725     P* Purpose:
007500070725     P* Returns:
007600070725     P* Parameter:      dateIn
007700070725     P*--------------------------------------------------
007800070725     P ConvertDecimalDateToUsa...
007900070725     P                 B                   EXPORT
008000070725     D ConvertDecimalDateToUsa...
008100070725     D                 PI             8P 0
008200070725     D  dateIn                        8P 0 CONST
008300070725
008400070725     D* Local fields
008500070725     D retField        S              8P 0
008600070725
008700070725      /free
008800070730
008900070730       monitor;
009000070730         retField = %int(%char(%date(dateIn):*usa0));
009100070730       on-error *all;
009200070730         retField = 0;
009300070730       endmon;
009400070730
009500070725       return retField;
009600070725
009700070725      /end-free
009800070725     P ConvertDecimalDateToUsa...
009900070725     P                 E
010000070725
010100070725     P*--------------------------------------------------
010200070725     P* Procedure name: ConvertDecimalDateToIso
010300070725     P* Purpose:
010400070725     P* Returns:
010500070725     P* Parameter:      dateIn
010600070725     P*--------------------------------------------------
010700070725     P ConvertDecimalDateToIso...
010800070725     P                 B                   EXPORT
010900070725     D ConvertDecimalDateToIso...
011000070725     D                 PI             8P 0
011100070725     D  dateIn                        8P 0 CONST
011200070725
011300070725     D* Local fields
011400070725     D retField        S              8P 0
011500070725
011600070725      /free
011700070725
011800070730       monitor;
011900070730         retField = %int(%char(%date(dateIn:*usa):*iso0));
012000070730       on-error *all;
012100070730         retField = 0;
012200070730       endmon;
012300070725
012400070725       return retField;
012500070725
012600070725      /end-free
012700070725     P ConvertDecimalDateToIso...
012800070725     P                 E
012900080429
013000080429
013100080429     P*--------------------------------------------------
013200080429     P* Procedure name: ZeroDateToBlank
013300080429     P* Purpose:
013400080429     P* Returns:
013500080429     P*--------------------------------------------------
013600080429     P ZeroDateToBlank...
013700080429     P                 B                   EXPORT
013800080429     D ZeroDateToBlank...
013900080429     D                 PI            10A
014000080429     D  dateIn                         D
014100080429
014200080429      /free
014300080429
014400080429       if (dateIn = %date('0001-01-01'));
014500080429         return ' ';
014600080429       else;
014700080429         return %char(dateIn:*usa);
014800080429       endif;
014900080429
015000080429       return ' ';
015100080429
015200080429      /end-free
015300080429     P ZeroDateToBlank...
015400080429     P                 E
015500080429
015600080429
015700080429     P*--------------------------------------------------
015800080429     P* Procedure name: BlankToZeroDate
015900080429     P* Purpose:
016000080429     P* Returns:
016100080429     P*--------------------------------------------------
016200080429     P BlankToZeroDate...
016300080429     P                 B                   EXPORT
016400080429     D BlankToZeroDate...
016500080429     D                 PI              D
016600080429     D  dateIn                       10A
016700080429
016800080429      /free
016900080429
017000080429       if (dateIn = ' ');
017100080429         return %date('0001-01-01');
017200080429       else;
017300080429         return %date(dateIn:*usa);
017400080429       endif;
017500080429
017600080429       return %date('0001-01-01');
017700080429
017800080429      /end-free
017900080429     P BlankToZeroDate...
018000080429     P                 E
018100070725
018200090901
018300090901     P*--------------------------------------------------
018400090901     P* Procedure name: DayOfWeek
018500090901     P* Purpose: Calculates the day of the week
018600090901     P* Returns:
018700090901     P*--------------------------------------------------
018800090901     P DayOfWeek       B                   EXPORT
018900090901     D DayOfWeek       PI            10A
019000090901     D   dt                            D   value datfmt(*iso)
019100090901
019200090901     D returnDay       S             10P 0
019300090901
019400090901      /free
019500090901
019600090901       returnDay = %rem (%diff (dt: d'1800-01-05': *days): 7);
019700090901
019800090901       select;
019900090901         when (returnDay = 0);
020000090901           return 'Sunday';
020100090901
020200090901         when (returnDay = 1);
020300090901           return 'Monday';
020400090901
020500090901         when (returnDay = 2);
020600090901           return 'Tuesday';
020700090901
020800090901         when (returnDay = 3);
020900090901           return 'Wednesday';
021000090901
021100090901         when (returnDay = 4);
021200090901           return 'Thursday';
021300090901
021400090901         when (returnDay = 5);
021500090901           return 'Friday';
021600090901
021700090901         when (returnDay = 6);
021800090901           return 'Saturday';
021900090901
022000090901       endsl;
022100090901
022200090901      /end-free
022300090901     P DayOfWeek       E
022400090901
022500090901
022600090901     P*--------------------------------------------------
022700090901     P* Procedure name: IsHoliday
022800090901     P* Purpose:
022900090901     P* Returns:
023000090901     P* Parameter:      dateIn
023100090901     P*--------------------------------------------------
023200090901     P IsHoliday       B                   EXPORT
023300090901     D IsHoliday       PI              N
023400090901     D  dateIn                         D   DATFMT(*ISO)
023500090901     D                                     CONST
023600090901
023700090901     D* Local fields
023800090901     D retField        S               N
023900090901
024000090901      /free
024100090901
024200090901       open HOLIDAYP;
024300090901
024400090901       chain (dateIn) HOLIDAYR;
024500090901
024600090901       if (%found());
024700090901         retField = *on;
024800090901       else;
024900090901         retField = *off;
025000090901       endif;
025100090901
025200090901       close HOLIDAYP;
025300090901
025400090901       return retField;
025500090901
025600090901      /end-free
025700120522     P IsHoliday       E
025800120522
025900120522
026000120522     P*--------------------------------------------------
026100120522     P* Procedure name: DecimalDateToDate
026200120522     P* Purpose:        Convert a decimal date to a date field
026300120522     P* Returns:
026400120522     P* Parameter:      decimalDate
026500120522     P*--------------------------------------------------
026600120522     P DecimalDateToDate...
026700120522     P                 B                   EXPORT
026800120522     D DecimalDateToDate...
026900120523     D                 PI              D   DATFMT(*USA)
027000120522     D  decimalDate                   8P 0 CONST
027100120522
027200120522     D* Local fields
027300120523     D retField        S               D   DATFMT(*USA)
027400120522
027500120522      /free
027600120522
027700120522       monitor;
027800120523         retField = %date(%char(decimalDate):*iso0);
027900120522       on-error;
028000120523         retField = %date('0001-01-01':*iso);
028100120522       endmon;
028200120522
028300120522       return retField;
028400120522
028500120522      /end-free
028600120522     P DecimalDateToDate...
028700120522     P                 E
028800120522
