000100091217       // **********************************************************************
000200091217       // Copybook for
000300091217     D CreateUserSpace...
000400091217     D                 PR                  ExtPgm('QUSCRTUS')
000500091217     D   usrspc                      20A   const
000600091217     D   attr                        10A   const
000700091217     D   size                        10I 0 const
000800091217     D   initval                      1A   const
000900091217     D   pubauth                     10A   const
001000091217     D   text                        50A   const
001100091217     D   replace                     10A   const options(*nopass)
001200091217     D   ErrorCode                 8000A   options(*varsize: *nopass)
001300091217
001400091217     D ChangeUserSpaceAttrib...
001500091217     D                 PR                  ExtPgm('QUSCUSAT')
001600091217     D   RtnLib                      10A
001700091217     D   UsrSpc                      20A   const
001800091217     D   Attrib                   65535A   const options(*varsize)
001900091217     D   ErrorCode                 8000A   options(*varsize)
002000091217
002100091217     D RetrieveUserSpaceAttrib...
002200091217     D                 PR                  ExtPgm('QUSRUSAT')
002300091217     D  retData                    1024A   options(*varsize)
002400091217     D  len                          10I 0 const
002500091217     D  format                        8A   const
002600091217     D  usrspc                       20A   const
002700091217     D  ErrorCode                  8000A   options(*varsize)
002800091217
002900091217     D DeleteUserSpace...
003000091217     D                 PR                  ExtPgm('QUSDLTUS')
003100091217     D   usrspc                      20A   const
003200091217     D   ErrorCode                 8000A   options(*varsize)
003300091217
003400091217     D GetUserSpacePointer...
003500091217     D                 PR                  ExtPgm('QUSPTRUS')
003600091217     D   usrspc                      20A   const
003700091217     D   pointer                       *
003800091217     D   ErrorCode                 8000A   options(*varsize:*nopass)
003900091217
004000091217       // Fields required for module
004100091217     D ErrCodeUsrSpc   DS                  qualified
004200091217     D   BytesProv                   10I 0 inz(0)
004300091217     D   BytesAvail                  10I 0
004400091217
004500091217     D usAttrib        DS
004600091217     D  bytesReturned                10I 0
004700091217     D  bytesAvailable...
004800091217     D                               10I 0
004900091217     D  spaceSize                    10I 0
005000091217     D  automaticalyExtend...
005100091217     D                                1A
005200091217     D  initialValue                  1A
005300091217     D  userSpaceLib                 10A
005400091217
