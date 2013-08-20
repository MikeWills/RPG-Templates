000100090120     H NoMain BNDDIR('MODULES')
000200061012       //*************************************************************************
000300061012       // Program . . . . . F.EMAIL
000400061012       //
000500061012       // Created on  . . . 10/12/2006
000600061012       //         by  . . . Michael N. Wills
000700061012       //
000800061012       // Description . . .
000900110512       //
001000110512       // To Compile:
001100110512       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N)
001200110512       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
001300110516       // *> DLTSPLF FILE(&ON) SPLNBR(*LAST)
001400061012       //
001500061012       // CHANGE LOG:
001600061012       // Date       | Name            | Description
001700061012       // -----------------------------------------------------------------------
001800061012       //            |                 |
001900061012       //            |                 |
002000061012       //            |                 |
002100061012       //*************************************************************************
002200061012       // Prototypes
002300110512      /copy qsrvsrc,email_h
002400110513      /copy qsrvsrc,cmd_h
002500110428      /copy qcopysrc,regex_h
002600110428     D FatalError      PR
002700110428     D    rc                         10I 0 value
002800110428     D    reg                              likeds(regex_t)
002900110428
003000061012       // **********************************************************************
003100061012       // Global Definitions
003200061012
003300061012     P*--------------------------------------------------
003400061012     P* Procedure name: SendEmail
003500061012     P* Purpose:        Send Email at Real-Time
003600061012     P* Returns:        Was the Email Successful?
003700061012     P* Parameter:      fromAddress
003800061012     P* Parameter:      toAddress
003900061012     P* Parameter:      ccAddress
004000061012     P* Parameter:      subject
004100061012     P* Parameter:      body
004200061012     P*--------------------------------------------------
004300090120     P SendMail        B                   EXPORT
004400090120     D SendMail        PI              N
004500090120     D  fromAddress                 100A   const varying
004600090120     D  toAddress                 32767A   const varying
004700090120     D  ccAddress                 32767A   const varying
004800090120     D  bccAddress                32767A   const varying
004900090120     D  subject                   32767A   const varying
005000090120     D  body                      32767A   const varying
005100061227
005200061227     D* Local fields
005300090413     D cmd             S          32767A   varying
005400061012
005500061012      /free
005600061012
005700090120         ExecClCmd('ADDLIBLE LIB(MAILTOOL) POSITION(*LAST)');
005800090120
005900090930         cmd = 'MAILTOOL TOADDR(' + %trim(toAddress) + ') ' +
006000090120               'FROMADDR(''' + %trim(fromAddress) + ''') ' +
006100090120               'CCADDR(' + %trim(ccAddress) + ') ' +
006200090120               'BCCADDR(' + %trim(bccAddress) + ') ' +
006300090120               'SUBJECT(''' + %trim(subject) + ''') ' +
006400100419               'MESSAGE(''' + %trim(body) + ''') ' +
006500100616               'SENDWITH(*MAILTOOL) MAILRTR(''192.168.50.240'') ' +
006600100415               'USERTR(*ONLY) MXLOOKUP(*YES)';
006700100415
006800090120         ExecClCmd(cmd);
006900061012
007000061012         return *ON;
007100061012
007200061012      /end-free
007300120214     P SendMail        E
007400120214
007500120214
007600120214     P*--------------------------------------------------
007700120214     P* Procedure name: SendEmail
007800120214     P* Purpose:        Send Email at Real-Time
007900120214     P* Returns:        Was the Email Successful?
008000120214     P* Parameter:      fromAddress
008100120214     P* Parameter:      toAddress
008200120214     P* Parameter:      ccAddress
008300120214     P* Parameter:      subject
008400120214     P* Parameter:      body
008500120214     P*--------------------------------------------------
008600120214     P SendMailAttachment...
008700120214     P                 B                   EXPORT
008800120214     D SendMailAttachment...
008900120214     D                 PI              N
009000120214     D  fromAddress                 100A   const varying
009100120214     D  toAddress                 32767A   const varying
009200120214     D  ccAddress                 32767A   const varying
009300120214     D  bccAddress                32767A   const varying
009400120214     D  subject                   32767A   const varying
009500120214     D  body                      32767A   const varying
009600120214     D  attachment                 1024A   const varying
009700120214
009800120214     D* Local fields
009900120214     D cmd             S          32767A   varying
010000120214
010100120214      /free
010200120214
010300120214         ExecClCmd('ADDLIBLE LIB(MAILTOOL) POSITION(*LAST)');
010400120214
010500120214         cmd = 'MAILTOOL TOADDR(' + %trim(toAddress) + ') ' +
010600120214               'FROMADDR(''' + %trim(fromAddress) + ''') ' +
010700120214               'CCADDR(' + %trim(ccAddress) + ') ' +
010800120214               'BCCADDR(' + %trim(bccAddress) + ') ' +
010900120214               'SUBJECT(''' + %trim(subject) + ''') ' +
011000120214               'MESSAGE(''' + %trim(body) + ''') ' +
011100120214               'ATTACH(''' + %trim(attachment) + ''') ' +
011200120214               'SENDWITH(*MAILTOOL) MAILRTR(''192.168.50.240'') ' +
011300120214               'USERTR(*ONLY) MXLOOKUP(*YES)';
011400120214
011500120214         ExecClCmd(cmd);
011600120214
011700120214         return *ON;
011800120214
011900120214      /end-free
012000120214     P SendMailAttachment...
012100120214     P                 E
012200090120
012300090928
012400090928     P*--------------------------------------------------
012500090928     P* Procedure name: ParseEmailAddresses
012600090928     P* Purpose:        When a program passes multiple email addresses, this
012700090928     P*                          program will break them apart.
012800090928     P* Returns:        Array of Email Addresses
012900090928     P* Parameter:      ToParse => List of email addresses to parse seperated
013000090928     P*                          by a semi-colon.
013100090928     P*--------------------------------------------------
013200090928     P ParseEmailAddresses...
013300090928     P                 B                   EXPORT
013400090928     D ParseEmailAddresses...
013500090928     D                 PI         32700A
013600090928     D  toParse                   32767A   CONST
013700090928
013800090928     D* Local fields
013900090928     D x               S              5P 0 Inz(1)
014000090928     D b               S              5P 0 Inz(0)
014100090928     D e               S              5P 0 Inz(0)
014200090928     D dim             S              3P 0 Inz(0)
014300090928     D retField        DS
014400090928     D  email                       100A   DIM(327)
014500090928
014600090928      /free
014700090928
014800090928        b = x;
014900090928
015000090928        dow x < %len(toParse);
015100090928
015200090928          if %subst(toParse:x) = ' ';
015300090928            leave;
015400090928          endif;
015500090928
015600090928          if %subst(toParse:x:1) = ';';
015700090928            dim += 1;
015800090928            email(dim) = %trim(%subst(toParse:b:(x - b)));
015900090928            b = x + 1;
016000090928          endif;
016100090928
016200090928          x += 1;
016300090928
016400090928        enddo;
016500090928
016600090928        dim += 1;
016700090928        email(dim) = %trim(%subst(toParse:b:(x - b)));
016800090928
016900090928        return retField;
017000090928
017100090928      /end-free
017200090928     P ParseEmailAddresses...
017300090928     P                 E
017400110428
017500110428
017600110428     P*--------------------------------------------------
017700110428     P* Procedure name: IsValidEmailAddress
017800110428     P* Purpose:        Validate via Regex that the email address is valid
017900110428     P*                 Taken from:
018000110428     P*       http://systeminetwork.com/article/validate-e-mail-address-regular-expression
018100110428     P* Returns:        True is Valid
018200110428     P* Parameter:      emailAddress
018300110428     P*--------------------------------------------------
018400110428     P IsValidEmailAddress...
018500110428     P                 B                   EXPORT
018600110428     D IsValidEmailAddress...
018700110428     D                 PI              N
018800110428     D  emailAddress              32767A   VARYING
018900110428     D                                     CONST
019000110428
019100110428     D* Local fields
019200110428     D valid           S               N
019300110428
019400110428     D compiled        s              1N   inz(*OFF)
019500110428     D pattern         s             50A   varying
019600110428     D reg             ds                  likeds(regex_t)
019700110428     D match           ds                  likeds(regmatch_t)
019800110428     D rc              s             10I 0
019900110428
020000110428      /free
020100110428
020200110428        // --------------------------------------------------
020300110428        //  If called with no parameters, clean everything
020400110428        //  up and exit the program.
020500110428        // --------------------------------------------------
020600110428
020700110428        if (%parms = 0);
020800110428           regfree(reg);
020900110428           compiled = *Off;
021000110428           *inlr = *on;
021100110428           return;
021200110428        endif;
021300110428
021400110428
021500110428        // --------------------------------------------------
021600110428        // Compile the regular expression
021700110428        //  (This is only done once, on the first call.)
021800110428        //
021900110428        //  For more info about this E-mail address expresion
022000110428        //  see:
022100110428        //    http://www.regular-expressions.info/email.html
022200110428        // --------------------------------------------------
022300110428
022400110428        if (not Compiled);
022500110428            pattern = '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$';
022600110428            rc = regcomp( reg
022700110428                        : pattern
022800110428                        : REG_EXTENDED + REG_ICASE + REG_NOSUB );
022900110428            if rc <> 0;
023000110428               FatalError(rc:reg);
023100110428            endif;
023200110428            compiled = *on;
023300110428        endif;
023400110428
023500110428
023600110428        // --------------------------------------------------
023700110428        //  Check the e-mail address against the regular
023800110428        //  expression.
023900110428        // --------------------------------------------------
024000110428
024100110428        if (regexec( reg
024200110428                   : %trim(emailAddress)
024300110428                   : 0
024400110428                   : match
024500110428                   : 0 ) = 0);
024600110428           valid = *on;
024700110428        else;
024800110428           valid = *off;
024900110428        endif;
025000110428
025100110428        return valid;
025200110428
025300110428      /end-free
025400110428     P IsValidEmailAddress...
025500110428     P                 E
025600110428
025700110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
025800110428      * FatalError():  Send exception message with error from
025900110428      *                regular expression routines.
026000110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
026100110428     P FatalError      B
026200110428     D FatalError      PI
026300110428     D    rc                         10I 0 value
026400110428     D    reg                              likeds(regex_t)
026500110428
026600110428     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
026700110428     D   MessageID                    7A   Const
026800110428     D   QualMsgF                    20A   Const
026900110428     D   MsgData                    512A   Const
027000110428     D   MsgDtaLen                   10I 0 Const
027100110428     D   MsgType                     10A   Const
027200110428     D   CallStkEnt                  10A   Const
027300110428     D   CallStkCnt                  10I 0 Const
027400110428     D   MessageKey                   4A
027500110428     D   ErrorCode                 8192A   options(*varsize)
027600110428
027700110428     D ErrorCode       DS                  qualified
027800110428     D  BytesProv              1      4I 0 inz(0)
027900110428     D  BytesAvail             5      8I 0 inz(0)
028000110428
028100110428     D MsgKey          S              4A
028200110428     D Data            s            512A   varying
028300110428     D Buf             s            512A
028400110428
028500110428      /free
028600110428
028700110428         regerror(rc: reg: %addr(Buf): %size(buf));
028800110428         Data = %str(%addr(buf));
028900110428
029000110428         QMHSNDPM( 'CPF9897'
029100110428                 : 'QCPFMSG   *LIBL'
029200110428                 : Data
029300110428                 : %len(Data)
029400110428                 : '*ESCAPE'
029500110428                 : '*PGMBDY'
029600110428                 : 1
029700110428                 : MsgKey
029800110428                 : ErrorCode );
029900110428
030000110428      /end-free
030100110428     P                 E
