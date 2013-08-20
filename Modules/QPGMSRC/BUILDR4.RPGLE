000100110512      * BUILDR4 -- Utility to build programs by searching for compile statements
000200110512      *            in the source code.
000300110512      *                                               SCK 11/05/2007
000400110512      *
000500110512      * To compile this utility:
000600110512      *
000700110512      *> CRTBNDRPG PGM(QGPL/BUILDR4) SRCFILE(&L/&F) DBGVIEW(&DV)
000800110512      *
000900110512      *> CRTCMD CMD(QGPL/BUILD) PGM(*LIBL/BUILDR4) -
001000110512      *>        MODE(*ALL) ALLOW(*ALL) -
001100110512      *>        TEXT(&X)
001200110512      *
001300110512      *       BUILDR4 allows the following values to be substituted into
001400110512      *            the command string:
001500110512      *
001600110512      *             &O      = Object library
001700110512      *             &ON     = Object name
001800110512      *             &F      = Source File
001900110512      *             &L      = Source Library
002000110512      *             &N      = Member name
002100110512      *             &DV     = Debug View (ILE)
002200110512      *             &OV     = Debug View (OPM)
002300110512      *             &EV     = *EVENTF or *NOEVENTF
002400110512      *             &R      = Replace *YES/*NO
002500110512      *             &X      = Source member text (single quotes added)
002600110512      *             &YY     = Current Year (YY)
002700110512      *             &YYYY   = Current Year (YYYY)
002800110512      *
002900110512      * The following variables are for Klement's Sausage's special
003000110512      * values.
003100110512      *             &FYY    = Klement's Sausage Fiscal Year (YY)
003200110512      *             &FYYYY  = Klement's Sausage Fiscal Year (YYYY)
003300110512      *             &PLDATE = Klement's most recent price list date
003400110512      *
003500110512      * To compile this utility:
003600110512      *
003700110512      *>    CRTBNDRPG PGM(QTEMP/&ON) SRCFILE(&L/&F) DBGVIEW(&DV)
003800110512      *
003900110512      *
004000110512      /if defined(*CRTBNDRPG)
004100110512     H DFTACTGRP(*NO) ACTGRP(*CALLER)
004200110512      /endif
004300110512     H BNDDIR('QC2LE') OPTION(*SRCSTMT:*NODEBUGIO)
004400110512
004500110512     FSOURCE    IF   F  256        DISK    EXTFILE(SrcFile)
004600110512     F                                     EXTMBR(SrcMbr)
004700110512     F                                     INFDS(SrcAttr)
004800110512     F                                     USROPN
004900110512      /undefine KLEMENT_SAUSAGE
005000110512      /if defined(KLEMENT_SAUSAGE)
005100110512     FPLFILE    IF   E           K DISK    USROPN
005200110512     FPERCAL    IF   E           K DISK    USROPN
005300110512      /endif
005400110512
005500110512     D BUILDR4         PR
005600110512     D   peObj                       20a   const
005700110512     D   peSrcFile                   20a   const
005800110512     D   peMbr                       10a   const
005900110512     D   peDbgView                    7a   const
006000110512     D   peReplace                    4a   const
006100110512     D   peAllowF9                    4a   const
006200110512     D   peOption                    10a   const
006300110512      ** This is equivalent to *ENTRY PLIST:
006400110512     D BUILDR4         PI
006500110512     D   peObj                       20a   const
006600110512     D   peSrcFile                   20a   const
006700110512     D   peMbr                       10a   const
006800110512     D   peDbgView                    7a   const
006900110512     D   peReplace                    4a   const
007000110512     D   peAllowF9                    4a   const
007100110512     D   peOption                    10a   const
007200110512
007300110512     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
007400110512     D   msgid                        7a   const
007500110512     D   msgf                        20a   const
007600110512     D   msgdta                   32702a   const options(*varsize)
007700110512     D   dtalen                      10i 0 const
007800110512     D   msgtype                     10a   const
007900110512     D   callstack                   10a   const
008000110512     D   stackcount                  10i 0 const
008100110512     D   msgkey                       4a
008200110512     D   errorcode                    8a   const
008300110512
008400110512     D QMHRSNEM        PR                  ExtPgm('QMHRSNEM')
008500110512     D   MsgKey                       4A   const
008600110512     D   ErrorCode                    8A   const
008700110512     D   ToStack                     10a   const
008800110512     D   ToStackLen                  10i 0 const
008900110512     D   ToStackFmt                   8a   const
009000110512     D   FromStack                     *   const
009100110512     D   FromStackCtr                10i 0 const
009200110512
009300110512     D RSNM0100        ds                  qualified
009400110512     D   Count                       10i 0 inz(1)
009500110512     D   modqual                     10a   inz('*NONE')
009600110512     D   pgmqual                     10a   inz('*NONE')
009700110512     D   len                         10i 0 inz(10)
009800110512     D   ident                       10a   inz('*PGMBDY')
009900110512
010000110512     D QMHMOVPM        PR                  ExtPgm('QMHMOVPM')
010100110512     D   MsgKey                       4A   const
010200110512     D   MsgTypes                    40A   const
010300110512     D   NumMsgTypes                 10I 0 const
010400110512     D   ToStack                     10A   const
010500110512     D   ToStackCnt                  10I 0 const
010600110512     D   ErrorCode                    8A   const
010700110512
010800110512     D loadcmds        pr            10i 0
010900110512     D   cmd                      32702a   varying dim(MAX_CMD)
011000110512     D dosubs          pr            10i 0
011100110512     D   cmd                      32702a   varying
011200110512     D runcmds         pr             1n
011300110512     D   cmd                      32702a   varying dim(MAX_CMD)
011400110512     D   count                       10i 0 const
011500110512     D getFiscYear     PR             4a
011600110512     D getCalYear      PR             4a
011700110512     D getPriceDate    PR             6a
011800110512     D getSrcMbr       PR             1n
011900110512     D   SrcFile                     21a   const
012000110512     D   SrcMbr                      10a   const
012100110512     D   Text                        52a   varying options(*omit)
012200110512     D   Type                        10a   options(*omit)
012300110512     D   RtnLib                      10a   options(*omit)
012400110512     D replace         PR
012500110512     D   cmd                      32702a   varying
012600110512     D   old                         10a   varying const
012700110512     D   new                         52a   varying const
012800110512     D defaultcmds     pr            10i 0
012900110512     D   cmd                      32702a   varying dim(MAX_CMD)
013000110512     D liblist         pr            10i 0
013100110512     D   Libl                        10a   dim(250)
013200110512
013300110512     D SrcAttr         ds                  qualified
013400110512     D   RecLen                       5I 0 overlay(SrcAttr:125)
013500110512     D MAX_CMD         c                   const(100)
013600110512
013700110512     D SrcLib          s             10a
013800110512     D SrcObj          s             10a
013900110512     D SrcFile         s             21a
014000110512     D SrcMbr          s             10a
014100110512     D objname         s             10a
014200110512     D objlib          s             10a
014300110512
014400110512     D count           s             10i 0
014500110512     D cmd             s          32702a   varying dim(MAX_CMD)
014600110512     D x               s             10i 0
014700110512     D SrcText         s             52a   varying
014800110512     D msgkey          s              4a
014900110512     D msg             s            132a   varying
015000110512
015100110512      /free
015200110512          SrcLib  = %subst(peSrcFile:11:10);
015300110512          SrcObj  = %subst(peSrcFile:1:10);
015400110512          SrcFile = %trim(SrcLib) + '/' + %trim(SrcObj);
015500110512          objlib  = %subst(peObj:11:10);
015600110512          objname = %subst(peObj:1:10);
015700110512
015800110512          if (peMbr = '*OBJ');
015900110512             SrcMbr = ObjName;
016000110512          else;
016100110512             SrcMbr = peMbr;
016200110512          endif;
016300110512
016400110512          getSrcMbr( SrcFile: SrcMbr: SrcText: *OMIT: SrcLib);
016500110512          SrcFile = %trim(SrcLib) + '/' + %trim(SrcObj);
016600110512
016700110512          count = loadcmds(cmd);
016800110512          if (count = 0);
016900110512              msg = 'No compile instructions found. +
017000110512                     Default command used.';
017100110512              QMHSNDPM( 'CPF9897'
017200110512                      : 'QCPFMSG   *LIBL'
017300110512                      : msg
017400110512                      : %len(msg)
017500110512                      : '*COMP'
017600110512                      : '*PGMBDY'
017700110512                      : 1
017800110512                      : msgkey
017900110512                      : *ALLx'00' );
018000110512              count = defaultcmds(cmd);
018100110512          endif;
018200110512
018300110512          for x = 1 to count;
018400110512             dosubs(cmd(x));
018500110512          endfor;
018600110512
018700110512          if runcmds(cmd:count);
018800110512              msg = 'Commands in source code executed successfully.';
018900110512              QMHSNDPM( 'CPF9897'
019000110512                      : 'QCPFMSG   *LIBL'
019100110512                      : msg
019200110512                      : %len(msg)
019300110512                      : '*COMP'
019400110512                      : '*PGMBDY'
019500110512                      : 1
019600110512                      : msgkey
019700110512                      : *ALLx'00' );
019800110512          endif;
019900110512
020000110512          return;
020100110512      /end-free
020200110512
020300110512
020400110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
020500110512      * Load all of the build commands from the source member
020600110512      * into an array of commands.
020700110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
020800110512     P loadcmds        B
020900110512     D loadcmds        pi            10i 0
021000110512     D   cmd                      32702a   varying dim(MAX_CMD)
021100110512
021200110512     D QMHRCVPM        PR                  ExtPgm('QMHRCVPM')
021300110512     D   rcvvar                   32767A   options(*varsize)
021400110512     D   rcvvarlen                   10i 0 const
021500110512     D   format                       8a   const
021600110512     D   stack                       10a   const
021700110512     D   stackctr                    10i 0 const
021800110512     D   type                        10a   const
021900110512     D   msgkey                       4a   const
022000110512     D   wait                        10i 0 const
022100110512     D   action                      10a   const
022200110512     D   errorcode                    8a   const
022300110512
022400110512     D RCVM0100        ds                  qualified
022500110512     D   msgid                        7a   overlay(RCVM0100:13)
022600110512     D   msgkey                       4a   overlay(RCVM0100:22)
022700110512     D   msgdtalen                   10i 0 overlay(RCVM0100:45)
022800110512     D   msgdta                    8000a   overlay(RCVM0100:49)
022900110512
023000110512     D LINE            ds           256    qualified
023100110512     D   seq                          6a
023200110512     D   date                         6a
023300110512     D   data                       240a
023400110512
023500110512     D id1             ds
023600110512     D                                1a   inz('*')
023700110512     D                                1a   inz('>')
023800110512     D id2             ds
023900110512     D                                1a   inz('<')
024000110512     D                                1a   inz('*')
024100110512     D pos             s             10i 0
024200110512     D sublen          s             10i 0
024300110512     D x               s             10i 0
024400110512     D temp            s            240a   varying
024500110512     D len             s             10i 0
024600110512
024700110512      /free
024800110512
024900110512          open SOURCE;
025000110512
025100110512          // Remove the "Buffer length longer than record"
025200110512          // message from the job log.
025300110512
025400110512          QMHRCVPM( RCVM0100: %size(RCVM0100): 'RCVM0100'
025500110512                  : '*': 0: '*DIAG': *blanks
025600110512                  : 0: '*REMOVE': x'00000008');
025700110512
025800110512          // Scan through source for any commands to
025900110512          // build program with.
026000110512
026100110512          setll *start SOURCE;
026200110512          read SOURCE LINE;
026300110512
026400110512          dow not %eof(SOURCE);
026500110512
026600110512             // look for start identifier
026700110512
026800110512             pos = %scan(id1:%subst(Line.data:1:SrcAttr.RecLen));
026900110512             if (pos>0);
027000110512
027100110512                  // extract everything after start id
027200110512
027300110512                  pos += %len(id1);
027400110512                  sublen = SrcAttr.reclen
027500110512                         - %size(LINE.Seq)
027600110512                         - %size(LINE.Date)
027700110512                         - pos
027800110512                         + 1;
027900110512                  temp = %trim(%subst(line.data:pos:sublen));
028000110512
028100110512                  // if there's also an end id, strip if off.
028200110512
028300110512                  pos =%scan(id2: temp);
028400110512                  if (pos>1);
028500110512                     temp = %trimr(%subst(temp:1:pos-1));
028600110512                  endif;
028700110512
028800110512                  // If line is not blank, add to the list of commands,
028900110512                  // or to the end of the last command...
029000110512
029100110512                  if (%len(temp)>0 and temp<>*blanks);
029200110512
029300110512                      if (x>0 and %subst(cmd(x):%len(cmd(x)):1) = '-');
029400110512                         len = %len(cmd(x)) - 1;
029500110512                         %len(cmd(x)) = len;
029600110512                         if (%subst(cmd(x):len:1) = ' ');
029700110512                            cmd(x) = %trimr(cmd(x)) + ' ' + temp;
029800110512                         else;
029900110512                            cmd(x) = cmd(x) + temp;
030000110512                         endif;
030100110512                      else;
030200110512                         x = x + 1;
030300110512                         cmd(x) = temp;
030400110512                      endif;
030500110512
030600110512                  endif;
030700110512             endif;
030800110512
030900110512             read SOURCE LINE;
031000110512          enddo;
031100110512
031200110512          close SOURCE;
031300110512          return x;
031400110512      /end-free
031500110512     P                 E
031600110512
031700110512
031800110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
031900110512      * dosubs(): This makes any necessary substitutions in the
032000110512      *           command that's to be run.
032100110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
032200110512     P dosubs          B
032300110512     D dosubs          pi            10i 0
032400110512     D   cmd                      32702a   varying
032500110512
032600110512     D cmdname         s             10a
032700110512     D temp            s                   like(cmd)
032800110512     D DbgView         s                   like(peDbgView)
032900110512     D OpmView         s                   like(peDbgView)
033000110512     D pos             s             10i 0
033100110512      /free
033200110512
033300110512        temp =  %xlate( 'abcdefghijklmnopqrstuvwxyz'
033400110512                      : 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
033500110512                      : cmd );
033600110512
033700110512        pos = %scan(' ':temp);
033800110512        if (pos > 1);
033900110512           cmdname = %subst(temp:1:pos-1);
034000110512        endif;
034100110512
034200110512        //------------------------------------------------------------
034300110512        // The embedded SQL precompiler only supports DBGVIEW(*SOURCE)
034400110512        //  and DBGVIEW(*NONE) -- but it passes DBGVIEW(*ALL) to the
034500110512        //  underlying HLL compiler.
034600110512        //
034700110512        // This works around this by switching the debug view to
034800110512        // *SOURCE when using the SQL precompiler.
034900110512        //------------------------------------------------------------
035000110512
035100110512        DbgView = peDbgView;
035200110512        if (%subst(cmdname:1:9) = 'CRTSQLRPG'
035300110512             or %subst(cmdname:1:9) = 'CRTSQLCBL'
035400110512             or %subst(cmdname:1:7) = 'CRTSQLC'
035500110512             or cmdname = 'CRTSQLPLI');
035600110512            if (DbgView='*STMT' or DbgView='*NONE');
035700110512                DbgView='*NONE';
035800110512            else;
035900110512                DbgView='*SOURCE';
036000110512            endif;
036100110512        endif;
036200110512
036300110512
036400110512        //------------------------------------------------------------
036500110512        // WDSC requires option(*EVENTF) in order to return info
036600110512        //  about why a compiler could not compile a program.
036700110512        //
036800110512        // If *EVENTF is specified, but no OPTION() was found in
036900110512        // the commands listed in the source member, tack on the
037000110512        // OPTION(*EVENTF) parameter.
037100110512        //------------------------------------------------------------
037200110512
037300110512        if (peOption='*EVENTF');
037400110512            pos = %scan(' OPTION(': temp);
037500110512            if (pos = 0);
037600110512                if ( cmdname='CRTRPGMOD'
037700110512                     or cmdname='CRTRPGPGM'
037800110512                     or cmdname='CRTBNDRPG'
037900110512                     or cmdname='CRTSQLRPGI'
038000110512                     or cmdname='CRTCLMOD'
038100110512                     or cmdname='CRTCLPGM'
038200110512                     or cmdname='CRTBNDCL'
038300110512                     or cmdname='CRTCBLMOD'
038400110512                     or cmdname='CRTBNDCBL'
038500110512                     or cmdname='CRTCPPMOD'
038600110512                     or cmdname='CRTBNDCPP'
038700110512                     or cmdname='CRTCMOD'
038800110512                     or cmdname='CRTBNDC'
038900110512                     or cmdname='CRTPF'
039000110512                     or cmdname='CRTLF'
039100110512                     or cmdname='CRTDSPF'
039200110512                     or cmdname='CRTPRTF' );
039300110512                   cmd += ' OPTION(*EVENTF)';
039400110512                endif;
039500110512            endif;
039600110512        endif;
039700110512
039800110512        //------------------------------------------------------------
039900110512        //  OPM programs use OPTION(*SRCDBG) or OPTION(*LSTDBG)
040000110512        //      instead of DBGVIEW.
040100110512        //------------------------------------------------------------
040200110512        select;
040300110512        when DbgView = '*LIST' or DbgView='*ALL';
040400110512          OpmView = '*LSTDBG';
040500110512        when DbgView = '*SOURCE';
040600110512          OpmView = '*SRCDBG';
040700110512        other;
040800110512          OpmView = '*NOSRCDBG';
040900110512        endsl;
041000110512
041100110512
041200110512        //------------------------------------------------------------
041300110512        //  Replace the various variables in the commands with the
041400110512        //  proper values from this program.
041500110512        //
041600110512        //  Note: Longer variables should be replaced first, to
041700110512        //        avoid conflict.  For example, '&YYYY' contains
041800110512        //        the string '&YY', so if &YY was done first, the
041900110512        //        &YYYY would become 07YY and would never get the
042000110512        //        4-digit year.  So the longer ones must be done
042100110512        //        first.
042200110512        //------------------------------------------------------------
042300110512
042400110512        replace(cmd: '&PLDATE': getPriceDate()             );
042500110512        replace(cmd: '&FYYYY' : getFiscYear()              );
042600110512        replace(cmd: '&FYY'   : %subst(getFiscYear(): 3: 2));
042700110512        replace(cmd: '&YYYY'  : getCalYear()               );
042800110512        replace(cmd: '&YY'    : %subst(getCalYear(): 3: 2) );
042900110512        replace(cmd: '&ON'    : %trim(objname)             );
043000110512        replace(cmd: '&DV'    : %trim(dbgview)             );
043100110512        replace(cmd: '&OV'    : %trim(OpmView)             );
043200110512        replace(cmd: '&EV'    : %trim(peOption)            );
043300110512        replace(cmd: '&O'     : %trim(objlib)              );
043400110512        replace(cmd: '&X'     : SrcText                    );
043500110512        replace(cmd: '&R'     : %trim(peReplace)           );
043600110512        replace(cmd: '&F'     : %trim(srcobj)              );
043700110512        replace(cmd: '&L'     : %trim(srclib)              );
043800110512        replace(cmd: '&N'     : %trim(srcmbr)              );
043900110512
044000110512        return 0;
044100110512
044200110512        begsr *pssr;
044300110512            return -1;
044400110512        endsr;
044500110512      /end-free
044600110512     P                 E
044700110512
044800110512
044900110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
045000110512      * Get current fiscal year from the period calendar file
045100110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
045200110512     P getFiscYear     B
045300110512     D getFiscYear     PI             4a
045400110512
045500110512      /if defined(KLEMENT_SAUSAGE)
045600110512     D PERCAL1         ds                  likerec(PERCALF:*INPUT)
045700110512     D found           s              1n   inz(*OFF)
045800110512     D Year            s              4a   static
045900110512      /free
046000110512         if (Year<>*blanks);
046100110512             return Year;
046200110512         endif;
046300110512
046400110512         monitor;
046500110512            open PERCAL;
046600110512         on-error;
046700110512            return '0000';
046800110512         endmon;
046900110512
047000110512         setll (%dec(%date():*ISO)) PERCAL;
047100110512         read PERCAL PERCAL1;
047200110512         if not %eof;
047300110512            Year = %editc(PERCAL1.pnFYer:'X');
047400110512         endif;
047500110512         close PERCAL;
047600110512
047700110512         return Year;
047800110512      /end-free
047900110512      /else
048000110512     C                   return    *Blanks
048100110512      /endif
048200110512     P                 E
048300110512
048400110512
048500110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
048600110512      * Get current year from the system clock
048700110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
048800110512     P getCalYear      B
048900110512     D getCalYear      PI             4a
049000110512     D year            s              4a   static
049100110512      /free
049200110512        if (year<>*blanks);
049300110512            return year;
049400110512        endif;
049500110512        evalr year = %editc(%subdt(%date(): *YEARS): 'X');
049600110512        return year;
049700110512      /end-free
049800110512     P                 E
049900110512
050000110512
050100110512
050200110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
050300110512      * Get current price list date from PLFILE
050400110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
050500110512     P getPriceDate    B
050600110512     D getPriceDate    PI             6a
050700110512      /if defined(KLEMENT_SAUSAGE)
050800110512     D date            s              6a
050900110512     D PLFILE1         ds                  likerec(PLFILEF:*INPUT)
051000110512      /free
051100110512         monitor;
051200110512           open PLFILE;
051300110512         on-error;
051400110512           return '000000';
051500110512         endmon;
051600110512
051700110512         setll *start PLFILE;
051800110512         read PLFILE PLFILE1;
051900110512         if not %eof;
052000110512             date = %editc(PLFILE1.PLDATE:'X');
052100110512         endif;
052200110512         close PLFILE;
052300110512
052400110512         return date;
052500110512      /end-free
052600110512      /else
052700110512     C                   return    *blanks
052800110512      /endif
052900110512     P                 E
053000110512
053100110512
053200110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
053300110512      * Get Infomration about the source member
053400110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
053500110512     P getSrcMbr       B
053600110512     D getSrcMbr       PI             1n
053700110512     D   SrcFile                     21a   const
053800110512     D   SrcMbr                      10a   const
053900110512     D   Text                        52a   varying options(*omit)
054000110512     D   Type                        10a   options(*omit)
054100110512     D   RtnLib                      10a   options(*omit)
054200110512
054300110512     D QUSRMBRD        PR                  EXTPGM('QUSRMBRD')
054400110512     D   RcvVar                   65535A   options(*varsize)
054500110512     D   RcvVarLen                   10i 0 const
054600110512     D   Format                       8a   const
054700110512     D   QualFile                    20a   const
054800110512     D   MbrName                     10a   const
054900110512     D   Override                     1a   const
055000110512     D   ErrorCode                    8a
055100110512
055200110512     D MBRD0100        ds           135    qualified
055300110512     D   Lib                         10a   overlay(MBRD0100:19)
055400110512     D   Type                        10a   overlay(MBRD0100:49)
055500110512     D   Text                        50a   overlay(MBRD0100:85)
055600110512
055700110512     D ErrCode         ds                  qualified
055800110512     D   Prov                        10i 0 inz(%size(ErrCode))
055900110512     D   Avail                       10i 0 inz(0)
056000110512
056100110512     D pos             s             10i 0
056200110512     D lib             s             10a
056300110512     D obj             s             10a
056400110512     D Quote           s              1a   inz('''') static
056500110512     D Libl            s             10a   dim(250)
056600110512     D Found           s              1n   inz(*OFF)
056700110512      /free
056800110512
056900110512         // Separate the library from the object name
057000110512
057100110512         pos = %scan('/': srcFile);
057200110512         if (pos>1 and pos<%len(srcFile));
057300110512            lib = %subst(srcFile:1:pos-1);
057400110512            obj = %subst(srcFile:pos+1);
057500110512         else;
057600110512            lib = '*LIBL';
057700110512            obj = %triml(srcFile);
057800110512         endif;
057900110512
058000110512         // If the library name is '*LIBL' retrieve the
058100110512         // library list.
058200110512
058300110512         lib = %xlate('libl':'LIBL': lib);
058400110512         if (lib = '*LIBL');
058500110512             count = liblist(libl);
058600110512         else;
058700110512             count = 1;
058800110512             libl(1) = lib;
058900110512         endif;
059000110512
059100110512
059200110512         // Search each library in the library list until the
059300110512         // member is found.
059400110512
059500110512         found = *OFF;
059600110512
059700110512         for x = 1 to count;
059800110512
059900110512            ErrCode.Avail = 0;
060000110512            QUSRMBRD( MBRD0100
060100110512                    : %size(MBRD0100)
060200110512                    : 'MBRD0100'
060300110512                    : obj + libl(x)
060400110512                    : SrcMbr
060500110512                    : '0'
060600110512                    : ErrCode );
060700110512
060800110512            if (errCode.avail = 0);
060900110512                found = *ON;
061000110512                leave;
061100110512            endif;
061200110512
061300110512         endfor;
061400110512
061500110512         if (not found);
061600110512
061700110512            monitor;
061800110512               ErrCode.Prov = 0;
061900110512               QUSRMBRD( MBRD0100
062000110512                       : %size(MBRD0100)
062100110512                       : 'MBRD0100'
062200110512                       : obj + '*LIBL'
062300110512                       : SrcMbr
062400110512                       : '0'
062500110512                       : ErrCode );
062600110512                found = *ON;
062700110512            on-error;
062800110512                MBRD0100 = *blanks;
062900110512                QMHMOVPM( *BLANKS
063000110512                        : '*COMP     *DIAG     *INFO'
063100110512                        : 3
063200110512                        : '*PGMBDY'
063300110512                        : 1
063400110512                        : x'00000000');
063500110512                QMHRSNEM( *BLANKS
063600110512                        : x'00000000'
063700110512                        : RSNM0100
063800110512                        : %size(RSNM0100)
063900110512                        : 'RSNM0100'
064000110512                        : *NULL
064100110512                        : 0);
064200110512                return *OFF;
064300110512            endmon;
064400110512
064500110512         endif;
064600110512
064700110512         if (%addr(text) <> *null);
064800110512             Text = Quote + %trimr(MBRD0100.Text) + Quote;
064900110512         endif;
065000110512         if (%addr(Type) <> *null);
065100110512             Type = MBRD0100.Type;
065200110512         endif;
065300110512         if (%addr(RtnLib) <> *null);
065400110512             RtnLib = MBRD0100.Lib;
065500110512         endif;
065600110512
065700110512         return found;
065800110512      /end-free
065900110512     P                 E
066000110512
066100110512
066200110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
066300110512      * Replace(): replace old string with new string in cmd
066400110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
066500110512     P replace         B
066600110512     D replace         PI
066700110512     D   cmd                      32702a   varying
066800110512     D   old                         10a   varying const
066900110512     D   new                         52a   varying const
067000110512     D pos             s             10i 0
067100110512      /free
067200110512         pos = %scan(old:cmd);
067300110512         dow pos > 0;
067400110512             cmd = %replace(new: cmd: pos: %len(old));
067500110512             pos = %scan(old:cmd);
067600110512         enddo;
067700110512      /end-free
067800110512     P                 E
067900110512
068000110512
068100110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
068200110512      * Run the commands in the build command array.
068300110512      *
068400110512      *   a) This starts by writing/receiving the command
068500110512      *      as a RQS message so it will appear in the job log,
068600110512      *      and can be retrieved with F9=Retrieve.
068700110512      *
068800110512      *   b) The QCAPCMD API is used to run the command.  Note
068900110512      *      that QCAPCMD does allow S/36 commands if you're in
069000110512      *      the S/36 environment.  It also makes it possible
069100110512      *      to prompt the command (if special chars used)
069200110512      *
069300110512      *   c) Any errors are reported to this program's caller
069400110512      *      using QMHMOVPM / QMHRSNEM
069500110512      *
069600110512      * Note: The entire array is processed in one call to
069700110512      *       this procedure to preserve call-level semantics.
069800110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
069900110512     P runcmds         B
070000110512     D runcmds         pi             1n
070100110512     D   cmd                      32702a   varying dim(MAX_CMD)
070200110512     D   count                       10i 0 const
070300110512
070400110512     D QCAPCMD         PR                  ExtPgm('QCAPCMD')
070500110512     D   cmd                      32702a   const options(*varsize)
070600110512     D   cmdlen                      10i 0 const
070700110512     D   ctlblk                      20a   const
070800110512     D   ctlblklen                   10i 0 const
070900110512     D   ctlblkfmt                    8a   const
071000110512     D   updcmd                   32702a   options(*varsize)
071100110512     D   updcmdsize                  10i 0 const
071200110512     D   updcmdlen                   10i 0
071300110512     D   errorcode                    8a   const
071400110512
071500110512     D CPOP0100        ds                  qualified
071600110512     D   type                        10i 0 inz(2)
071700110512     D   dbcs                         1a   inz('0')
071800110512     D   prompt                       1a   inz('2')
071900110512     D   syntax                       1a   inz('0')
072000110512     D   rtvkey                       4a   inz(x'00000000')
072100110512     D   ccsid                       10i 0 inz(0)
072200110512     D                                5a   inz(x'0000000000')
072300110512
072400110512     D QCMDEXC         PR                  extpgm('QCMDEXC')
072500110512     D    cmd                     32702a   const
072600110512     D    len                        15p 5 const
072700110512
072800110512     D QMHRCVPM        PR                  ExtPgm('QMHRCVPM')
072900110512     D   rcvvar                   32767A   options(*varsize)
073000110512     D   rcvvarlen                   10i 0 const
073100110512     D   format                       8a   const
073200110512     D   stack                       10a   const
073300110512     D   stackctr                    10i 0 const
073400110512     D   type                        10a   const
073500110512     D   msgkey                       4a   const
073600110512     D   wait                        10i 0 const
073700110512     D   action                      10a   const
073800110512     D   errorcode                    8a   const
073900110512
074000110512     D RCVM0100        ds                  qualified
074100110512     D   msgid                        7a   overlay(RCVM0100:13)
074200110512     D   msgkey                       4a   overlay(RCVM0100:22)
074300110512     D   msgdtalen                   10i 0 overlay(RCVM0100:45)
074400110512     D   msgdta                    8000a   overlay(RCVM0100:49)
074500110512
074600110512     D err             s              1n   inz(*OFF)
074700110512     D msgkey          s              4a
074800110512     D stack           s             10a
074900110512     D msgtype         s             10a
075000110512     D retriev         s              1n   inz(*OFF)
075100110512     D updcmd          s          32702a
075200110512     D updcmdlen       s             10i 0
075300110512     D ignore          s              1n   inz(*OFF)
075400110512     D opt             s              4a
075500110512      /free
075600110512
075700110512        for x = 1 to count;
075800110512
075900110512             updcmdlen = 0;
076000110512
076100110512             if %len(cmd(x))<4 or cmd(x)=*blanks;
076200110512                iter;
076300110512             endif;
076400110512
076500110512             opt = %xlate('ignsql':'IGNSQL': %subst(cmd(x):1:4) );
076600110512
076700110512             ignore=*Off;
076800110512             if ( opt = 'IGN:' );
076900110512                ignore = *on;
077000110512                cmd(x) = %triml(%subst(cmd(x):5));
077100110512             endif;
077200110512
077300110512             if %len(cmd(x))=0 or cmd(x)=*blanks;
077400110512                iter;
077500110512             endif;
077600110512
077700110512             if (peAllowF9 = '*YES');
077800110512                 QMHSNDPM( *blanks
077900110512                         : *blanks
078000110512                         : cmd(x)
078100110512                         : %len(cmd(x))
078200110512                         : '*RQS'
078300110512                         : '*EXT'
078400110512                         : 0
078500110512                         : MsgKey
078600110512                         : *ALLX'00' );
078700110512
078800110512                 QMHRCVPM( RCVM0100
078900110512                         : %size(RCVM0100)
079000110512                         : 'RCVM0100'
079100110512                         : '*'
079200110512                         : 0
079300110512                         : '*RQS'
079400110512                         : msgKey
079500110512                         : 0
079600110512                         : '*OLD'
079700110512                         : x'00000000' );
079800110512                 CPOP0100.RtvKey = msgKey;
079900110512             else;
080000110512                 QMHSNDPM( 'CPF9897'
080100110512                         : 'QCPFMSG   *LIBL'
080200110512                         : cmd(x)
080300110512                         : %len(cmd(x))
080400110512                         : '*DIAG'
080500110512                         : '*EXT'
080600110512                         : 0
080700110512                         : MsgKey
080800110512                         : *ALLX'00' );
080900110512
081000110512             endif;
081100110512
081200110512             monitor;
081300110512                 QCAPCMD( cmd(x)
081400110512                        : %len(cmd(x))
081500110512                        : CPOP0100
081600110512                        : %size(CPOP0100)
081700110512                        : 'CPOP0100'
081800110512                        : updcmd
081900110512                        : %size(updcmd)
082000110512                        : updcmdlen
082100110512                        : x'00000000' );
082200110512                 err = *OFF;
082300110512             on-error;
082400110512                 err = *ON;
082500110512             endmon;
082600110512
082700110512             if (err=*OFF and updcmdlen > 0);
082800110512                 cmd(x) = %subst(updcmd:1:updcmdlen);
082900110512             endif;
083000110512
083100110512             if (err=*ON and ignore=*OFF);
083200110512                QMHMOVPM( *BLANKS
083300110512                        : '*COMP     *DIAG     *INFO'
083400110512                        : 3
083500110512                        : '*PGMBDY'
083600110512                        : 1
083700110512                        : x'00000000');
083800110512                QMHRSNEM( *BLANKS
083900110512                        : x'00000000'
084000110512                        : RSNM0100
084100110512                        : %size(RSNM0100)
084200110512                        : 'RSNM0100'
084300110512                        : *NULL
084400110512                        : 0);
084500110512             endif;
084600110512
084700110512             if (err and ignore=*OFF);
084800110512                 return *OFF;
084900110512             endif;
085000110512
085100110512         endfor;
085200110512
085300110512         return *ON;
085400110512      /end-free
085500110512     P                 e
085600110512
085700110512
085800110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
085900110512      * If there's no compile command in the source, we'll
086000110512      * try this one....
086100110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
086200110512     P defaultcmds     B
086300110512     D defaultcmds     pi            10i 0
086400110512     D   cmd                      32702a   varying dim(MAX_CMD)
086500110512     D type            s             10a
086600110512      /free
086700110512         getSrcMbr(srcfile: srcmbr: *omit: type: *omit);
086800110512         select;
086900110512         when type='RPGLE';
087000110512             cmd(1) = 'CRTBNDRPG PGM(&O/&ON) +
087100110512                                 SRCFILE(&L/&F) +
087200110512                                 SRCMBR(&N) +
087300110512                                 DBGVIEW(&DV) +
087400110512                                 REPLACE(&R) +
087500110512                                 TEXT(&X) +
087600110512                                 OPTION(&EV)';
087700110512         when type='SQLRPGLE';
087800110512             cmd(1) = 'CRTSQLRPGI OBJ(&O/&ON) +
087900110512                                  SRCFILE(&L/&F) +
088000110512                                  SRCMBR(&N) +
088100110512                                  DBGVIEW(&DV) +
088200110512                                  REPLACE(&R) +
088300110512                                  TEXT(&X) +
088400110512                                  OPTION(&EV)';
088500110512         when type='CLLE';
088600110512             cmd(1) = 'CRTBNDCL  PGM(&O/&ON) +
088700110512                                 SRCFILE(&L/&F) +
088800110512                                 SRCMBR(&N) +
088900110512                                 DBGVIEW(&DV) +
089000110512                                 REPLACE(&R) +
089100110512                                 TEXT(&X) +
089200110512                                 OPTION(&EV)';
089300110512         when type='CBLLE';
089400110512             cmd(1) = 'CRTBNDCBL PGM(&O/&ON) +
089500110512                                 SRCFILE(&L/&F) +
089600110512                                 SRCMBR(&N) +
089700110512                                 DBGVIEW(&DV) +
089800110512                                 REPLACE(&R) +
089900110512                                 TEXT(&X) +
090000110512                                 OPTION(&EV)';
090100110512         when type='SQLCBLLE';
090200110512             cmd(1) = 'CRTSQLCBLI OBJ(&O/&ON) +
090300110512                                  SRCFILE(&L/&F) +
090400110512                                  SRCMBR(&N) +
090500110512                                  DBGVIEW(&DV) +
090600110512                                  REPLACE(&R) +
090700110512                                  TEXT(&X) +
090800110512                                  OPTION(&EV)';
090900110512         when type='C' or type='CLE';
091000110512             cmd(1) = 'CRTBNDC   PGM(&O/&ON) +
091100110512                                 SRCFILE(&L/&F) +
091200110512                                 SRCMBR(&N) +
091300110512                                 DBGVIEW(&DV) +
091400110512                                 REPLACE(&R) +
091500110512                                 TEXT(&X) +
091600110512                                 OPTION(&EV)';
091700110512         when type='RPG';
091800110512             cmd(1) = 'CRTRPGPGM PGM(&O/&ON) +
091900110512                                 SRCFILE(&L/&F) +
092000110512                                 SRCMBR(&N) +
092100110512                                 OPTION(&OV &EV) +
092200110512                                 REPLACE(&R) +
092300110512                                 TEXT(&X)';
092400110512         when type='SQLRPG';
092500110512             cmd(1) = 'CRTSQLRPG PGM(&O/&ON) +
092600110512                                 SRCFILE(&L/&F) +
092700110512                                 SRCMBR(&N) +
092800110512                                 OPTION(&OV) +
092900110512                                 REPLACE(&R) +
093000110512                                 TEXT(&X)';
093100110512         when type='CLP';
093200110512             cmd(1) = 'CRTCLPGM  PGM(&O/&ON) +
093300110512                                 SRCFILE(&L/&F) +
093400110512                                 SRCMBR(&N) +
093500110512                                 REPLACE(&R) +
093600110512                                 TEXT(&X) +
093700110512                                 OPTION(&OV &EV)';
093800110512         when type='CMD';
093900110512             cmd(1) = 'CRTCMD    CMD(&O/&ON) +
094000110512                                 PGM(*LIBL/&ONCL) +
094100110512                                 MODE(*ALL) ALLOW(*ALL) +
094200110512                                 SRCFILE(&L/&F) +
094300110512                                 SRCMBR(&N) +
094400110512                                 REPLACE(&R) +
094500110512                                 TEXT(&X)';
094600110512         when type='RPG36';
094700110512             cmd(1) = 'CRTS36RPG PGM(&O/&ON) +
094800110512                                 SRCFILE(&L/&F) +
094900110512                                 SRCMBR(&N) +
095000110512                                 REPLACE(&R) +
095100110512                                 TEXT(&X)';
095200110512         when type='DSPF';
095300110512             cmd(1) = 'CRTDSPF   FILE(&O/&ON) +
095400110512                                 SRCFILE(&L/&F) +
095500110512                                 SRCMBR(&N) +
095600110512                                 REPLACE(&R) +
095700110512                                 OPTION(&EV) +
095800110512                                 TEXT(&X)';
095900110512         when type='PRTF';
096000110512             cmd(1) = 'CRTPRTF   FILE(&O/&ON) +
096100110512                                 SRCFILE(&L/&F) +
096200110512                                 SRCMBR(&N) +
096300110512                                 REPLACE(&R) +
096400110512                                 OPTION(&EV) +
096500110512                                 TEXT(&X)';
096600110512         when type='LF';
096700110512             cmd(1) = 'CRTLF     FILE(&O/&ON) +
096800110512                                 SRCFILE(&L/&F) +
096900110512                                 SRCMBR(&N) +
097000110512                                 OPTION(&EV) +
097100110512                                 TEXT(&X)';
097200110512         when type='PF';
097300110512             cmd(1) = 'CRTPF     FILE(&O/&ON) +
097400110512                                 SRCFILE(&L/&F) +
097500110512                                 SRCMBR(&N) +
097600110512                                 OPTION(&EV) +
097700110512                                 TEXT(&X)';
097800110512         other;
097900110512             cmd(1) = 'RECRT PGM(&O/&ON) MODOPT(*FULL)';
098000110512         endsl;
098100110512
098200110512         return 1;
098300110512      /end-free
098400110512     P                 E
098500110512
098600110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
098700110512      *  Load the current library list into an array.
098800110512      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
098900110512     P liblist         B
099000110512     D liblist         pi            10i 0
099100110512     D   Libl                        10a   dim(250)
099200110512
099300110512     D QUSRJOBI        PR                  ExtPgm('QUSRJOBI')
099400110512     D   RcvVar                   32767a   options(*varsize)
099500110512     D   RcvVarLen                   10i 0 const
099600110512     D   Format                       8a   const
099700110512     D   QualJob                     26a   const
099800110512     D   IntJobId                    16a   const
099900110512
100000110512     D JOBI0700        DS                  qualified
100100110512     D   type                         1a   overlay(JOBI0700:61)
100200110512     D   subtype                      1a   overlay(JOBI0700:62)
100300110512     D   numsys                      10i 0 overlay(JOBI0700:65)
100400110512     D   numprd                      10i 0 overlay(JOBI0700:69)
100500110512     D   numcur                      10i 0 overlay(JOBI0700:73)
100600110512     D   numusr                      10i 0 overlay(JOBI0700:77)
100700110512     D   libl                        11a   overlay(JOBI0700:81) dim(250)
100800110512
100900110512     D x               s             10i 0
101000110512     D Total           s             10i 0
101100110512
101200110512      /free
101300110512           QUSRJOBI( JOBI0700: %size(JOBI0700): 'JOBI0700'
101400110512                   : '*': *blanks);
101500110512
101600110512           total = JOBI0700.numsys
101700110512                 + JOBI0700.numprd
101800110512                 + JOBI0700.numcur
101900110512                 + JOBI0700.numusr;
102000110512
102100110512           for x = 1 to Total;
102200110512               Libl(x) = JOBI0700.libl(X);
102300110512           endfor;
102400110512
102500110512           return Total;
102600110512      /end-free
102700110512     P                 E
102800110512
