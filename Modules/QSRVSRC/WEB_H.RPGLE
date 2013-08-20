000100091216       // **********************************************************************
000200091216       // Copybook for
000300091216     D ReadStandardIn  PR                  extproc('QtmhRdStin')
000400091216     D    result                       *   value
000500091216     D    resultsize                 10I 0 const
000600091216     D    resultlen                  10I 0
000700091216     D    ErrorCode                8000A   options(*varsize)
000800091216
000900091216     D WriteStandardOut...
001000091216     D                 PR                  extproc('QtmhWrStout')
001100091216     D   DtaVar                   32767A   options(*varsize) const
001200091216     D   DtaVarLen                   10I 0 const
001300091216     D   ErrorCode                 8000A   options(*varsize)
001400091216
001500091216     D WriteStandardOutPointer...
001600091216     D                 PR                  extproc('QtmhWrStout')
001700091216     D   DtaVar                        *   value
001800091216     D   DtaVarLen                   10I 0 const
001900091216     D   ErrorCode                 8000A   options(*varsize)
002000091216
002100091216     D CgiParse        PR                  extproc('QzhbCgiParse')
002200091216     D   szCmd                         *   value options(*string)
002300091216     D   Format                       8A   const
002400091216     D   rtnBuffer                32767A   options(*varsize)
002500091216     D   nLenRecvBuf                 10I 0 const
002600091216     D   nBytesRead                  10I 0
002700091216     D   ErrorCode                 8000A   options(*varsize)
002800091216
002900091216     D ConvertToDb     PR                  ExtProc('QtmhCvtDb')
003000091216     D   QualFile                    20A   const
003100091216     D   InpString                32767A   const options(*varsize)
003200091216     D   InpStringLen                10I 0 const
003300091216     D   RespVar                  32767A   options(*varsize)
003400091216     D   RespVarSize                 10I 0 const
003500091216     D   DataAvail                   10I 0
003600091216     D   RespCode                    10I 0
003700091217     D   ErrorCode                 8000A   options(*varsize)
003800091216
003900091222     D putenv          PR            10I 0 extProc('putenv')
004000091222     D  pEnvVarValue                   *
004100091222     D                                     VALUE OPTIONS(*STRING:*TRIM)
004200091222
004300091222     D getenv          PR              *   extProc('getenv')
004400091222     D  pEnvVar                        *
004500091222     D                                     VALUE OPTIONS(*STRING:*TRIM)
004600091217
004700091222
004800091217     D*--------------------------------------------------
004900091217     D* Procedure name: WriteToStdOut
005000091217     D* Purpose:
005100091217     D* Returns:
005200091217     D* Parameter:      buffer
005300091217     D*--------------------------------------------------
005400091217     D WriteToStdOut   PR
005500091217     D  buffer                    32767A   varying
005600091217     D                                     const
005700091222
005800091222
005900091222     D*--------------------------------------------------
006000091222     D* Procedure name: CgiParseInz
006100091222     D* Purpose:
006200091222     D* Returns:
006300091222     D* Parameter:      buffer
006400091222     D*--------------------------------------------------
006500091222     D CgiParseInz     PR            10I 0
006600091222
006700091222
006800091222     D*--------------------------------------------------
006900091222     D* Procedure name: CgiParseGet
007000091222     D* Purpose:
007100091222     D* Returns:
007200091222     D* Parameter:      buffer
007300091222     D*--------------------------------------------------
007400091222     D CgiParseGet     PR          4096A
007500091222     D   varName                    120A   Const Varying
007600091222     D   nIndex                      10I 0 Const OPTIONS(*NOPASS)
007700091222
007800091222
007900091222     D*--------------------------------------------------
008000091222     D* Procedure name: CgiParseGetCount
008100091222     D* Purpose:
008200091222     D* Returns:
008300091222     D* Parameter:      buffer
008400091222     D*--------------------------------------------------
008500091222     D CgiParseGetCount...
008600091222     D                 PR            10I 0
008700091222     D   varName                    120A   Const Varying
008800091217
008900091216       // Fields required for module
009000091217     D ErrCodeWeb      DS                  qualified
009100091216     D   BytesProv                   10I 0 inz(0)
009200091216     D   BytesAvail                  10I 0
009300091216
009400091216     D KEY_AUTO_EXT    C                   const(3)
009500091216     D AutoExt         DS                  qualified
009600091216     D   NbrRec                      10I 0 inz(1)
009700091216     D   Key                         10I 0 inz(KEY_AUTO_EXT)
009800091216     D   Len                         10I 0 inz(%size(AutoExt.Data))
009900091216     D   Data                         1A   inz(*ON)
010000091216
