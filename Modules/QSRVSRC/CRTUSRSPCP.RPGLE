000100100409      /TITLE Huvudprogram
000200100409     H NOMAIN
000300100409      */COPY modules/qsrvsrc,CrtUsrSpcP
000400100409      /TITLE CrtUsrSpc: Create User Space for OS/400 API's
000500100409      ****************************************************************
000600100409      *
000700100409      * CrtUsrSpc: Create User Space for OS/400 API's
000800100409      *
000900100409      ****************************************************************
001000100409      *
001100100409     P  CrtUsrSpc      B                   EXPORT
001200100409      *
001300100409      * --- Procedure Interface Definition
001400100409      *
001500100409     D  CrtUsrSpc      PI             1
001600100409     D  UsrSpcName                   20
001700100409      *
001800100409      * --- Local Variables
001900100409      *
002000100409     D  ReturnCode     S              1
002100100409     D  ObjName        S             10    INZ(' ')
002200100409     D  ObjLib         S             10    INZ(' ')
002300100409     D  UserSpace      S             20    INZ(' ')
002400100409     D  ExtraAtr       S             10    INZ(' ')
002500100409     D  UserInit       S              1    INZ(' ')
002600100409     D  UserAuth       S             10    INZ('*EXCLUDE  ')
002700100409     D  UserText       S             50    INZ(' ')
002800100409     D  OS400_Cmd      S            160    INZ(' ')
002900100409     D  Cmd_Length     S             15P 5 INZ(0)
003000100409     D  True           S              1    INZ( *ON  )
003100100409     D  False          S              1    INZ( *OFF )
003200100409      *
003300100409     D BinaryField     DS
003400100409     D  UserSize               1      4B 0 INZ(50000)
003500100409      *
003600100409      * Remove "User Space"
003700100409      *
003800100409     C                   EVAL      ObjName    = %SUBST(UsrSpcName :  1 : 10 )
003900100409     C                   EVAL      ObjLib     = %SUBST(UsrSpcName : 11 : 10 )
004000100409      *
004100100409     C                   EVAL      OS400_Cmd  = 'DLTUSRSPC '                   +
004200100409     C                                          'USRSPC('                      +
004300100409     C                                          %TRIM( ObjLib  )               +
004400100409     C                                          '/'                            +
004500100409     C                                          %TRIM( ObjName )               +
004600100409     C                                          ')'
004700100409     C                   EVAL      Cmd_Length = %SIZE(OS400_Cmd)
004800100409     C                   CALL      'QCMDEXC'                            89
004900100409     C                   PARM                    OS400_Cmd
005000100409     C                   PARM                    Cmd_Length
005100100409      *
005200100409      * Create "User Space"
005300100409      *
005400100409     C                   CALL      'QUSCRTUS'
005500100409     C                   PARM                    UsrSpcName
005600100409     C                   PARM                    ExtraAtr
005700100409     C                   PARM                    UserSize
005800100409     C                   PARM                    UserInit
005900100409     C                   PARM                    UserAuth
006000100409     C                   PARM                    UserText
006100100409      *
006200100409      * ReturnCode
006300100409      *
006400100409     C                   EVAL      ReturnCode = %ERROR
006500100409     C*
006600100409     C                   RETURN    ReturnCode
006700100409      *
006800100409     P  CrtUsrSpc      E
006900100409      *
007000100409      ******************************************************************
007100100409     C/TITLE
007200100409
