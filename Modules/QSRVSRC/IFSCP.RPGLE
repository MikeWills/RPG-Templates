000100110106       // **********************************************************************
000200110106       // Copybook for IFS
000300110106
000400110106     D fileDescription...
000500110106     D                 S             10I 0
000600110106     D fileResponce    S             10I 0
000700110107     D CRLF            C                   const(x'0d25')
000800110106
000900110106     D*--------------------------------------------------
001000110106     D* Procedure name: Init
001100110106     D* Purpose:        Initialize the file and prepare for writting the file
001200110106     D* Returns:
001300110106     D* Parameter:      path
001400110106     D* Parameter:      file
001500110106     D* Parameter:      options => Pass options on how to open the file
001600110106     D* Parameter:      overwrite
001700110106     D*--------------------------------------------------
001800110106     D InitFile        PR            10I 0
001900110106     D  path                        512A   VARYING
002000110106     D                                     CONST
002100110106     D  mode                          3A   CONST
002200110106     D  flags                         3A   CONST
002300110106     D  overwrite                      N   CONST
002400110106     D                                     OPTIONS(*NOPASS)
002500110106
002600110106
002700110106     D*--------------------------------------------------
002800110106     D* Procedure name: CloseFile
002900110106     D* Purpose:
003000110106     D* Returns:
003100110106     D*--------------------------------------------------
003200110106     D CloseFile       PR
003300110107     D  fileDesc                     10I 0 VALUE
003400110106
003500110106
003600110106     D*--------------------------------------------------
003700110106     D* Procedure name: WriteBuffer
003800110106     D* Purpose:
003900110106     D* Returns:        Number of bytes written
004000110106     D* Parameter:      buffer
004100110106     D*--------------------------------------------------
004200110106     D WriteBuffer     PR            10I 0
004300110107     D  fileDesc                     10I 0 VALUE
004400110106     D  buffer                         *   VALUE
004500110106
004600110106
004700110106     D*--------------------------------------------------
004800110106     D* Procedure name: ReadBuffer
004900110106     D* Purpose:
005000110106     D* Returns:
005100110106     D* Parameter:      buffer
005200110106     D*--------------------------------------------------
005300110106     D ReadBuffer      PR            10I 0
005400110107     D  fileDesc                     10I 0 VALUE
005500110106     D  buffer                         *   VALUE
005600110106
005700110106     D*--------------------------------------------------
005800110106     D* Procedure name: DeleteFile
005900110106     D* Purpose:
006000110106     D* Returns:        Success = *on
006100110106     D* Parameter:      path
006200110106     D*--------------------------------------------------
006300110106     D DeleteFile      PR            10I 0
006400110106     D  path                        512A   VARYING
006500110106     D                                     CONST
006600110106
