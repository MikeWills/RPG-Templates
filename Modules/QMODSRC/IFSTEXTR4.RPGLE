000100020624      ** Service program to assist in creating TEXT files in the IFS
000200020624      **
000300020714      **  To compile:
000400110512      ** *>  CRTRPGMOD IFSTEXTR4 SRCFILE(IFSEBOOK/QRPGLESRC) DBGVIEW(*LIST)
000500110512      ** *>  CRTSRVPGM IFSTEXTR4 TEXT('IFS Text service program') -
000600031030      **                EXPORT(*SRCFILE) SRCFILE(IFSEBOOK/QSRVSRC)
000700020624
000800020624     H NOMAIN OPTION(*NOSHOWCPY: *SRCSTMT)
000900020624
001000070914     D/copy qcopysrc,ifsio_h
001100070914     D/copy qsrvsrc,ifstext_h
001200020624
001300020624      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
001400020624      *  The concept here is very simple:
001500020624      *     1) Write the data passed to us into the stream file.
001600020624      *     2) Add the end of line characters.
001700020624      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
001800020624     P writeline       B                   export
001900020624     D writeline       PI            10I 0
002000020624     D   fd                          10I 0 value
002100020624     D   text                          *   value
002200020624     D   len                         10I 0 value
002300020624
002400020624     D rc1             S             10I 0
002500020624     D rc2             S             10I 0
002600020624     D eol             S              2A
002700020624
002800020624     C* write the text provided
002900020624     c                   if        len > 0
003000020624     c                   eval      rc1 = write(fd: text: len)
003100020624     c                   if        rc1 < 1
003200020624     c                   return    rc1
003300020624     c                   endif
003400020624     c                   endif
003500020624
003600020624     C* then add the end-of-line chars
003700020624     c                   eval      eol = x'0d25'
003800020624     c                   eval      rc2 = write(fd: %addr(eol): 2)
003900020624     c                   if        rc2 < 1
004000020624     c                   return    rc2
004100020624     c                   endif
004200020624
004300020624     c                   return    rc1 + rc2
004400020624     P                 E
004500020624
004600020624
004700020624      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
004800020624      *  This one's a bit more complicated.
004900020624      *     a) We don't know how long the text will go before
005000020624      *         an end-of-line sequence is encountered.
005100020624      *     b) We could just read one byte at a time until we found
005200020624      *         the EOL sequence, but that would run very slowly
005300020624      *         since it's inefficient to transfer chunks of data
005400020624      *         that small from disk.
005500020624      *
005600020624      *  So...  we keep a "read buffer".  We load chunks of data
005700020624      *  from disk into the buffer, then get one character at a
005800020624      *  time from that buffer.
005900020624      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
006000020624     P readline        B                   export
006100020624     D readline        PI            10I 0
006200020624     D   fd                          10I 0 value
006300020624     D   text                          *   value
006400020624     D   maxlen                      10I 0 value
006500020624
006600020624     D rdbuf           S           1024A   static
006700020624     D rdpos           S             10I 0 static
006800020624     D rdlen           S             10I 0 static
006900020624
007000020624     D p_retstr        S               *
007100020624     D RetStr          S          32766A   based(p_retstr)
007200020624     D len             S             10I 0
007300020624
007400020624     c                   eval      len = 0
007500020624     c                   eval      p_retstr = text
007600020625     c                   eval      %subst(RetStr:1:MaxLen) = *blanks
007700020714
007800020624     c                   dow       1 = 1
007900020624
008000020624     C* Load the buffer
008100020624     c                   if        rdpos>=rdlen
008200020624     c                   eval      rdpos = 0
008300020624     c                   eval      rdlen=read(fd:%addr(rdbuf):%size(rdbuf))
008400020624     c                   if        rdlen < 1
008500020624     c                   return    -1
008600020624     c                   endif
008700020624     c                   endif
008800020624
008900020624     C* Is this the end of the line?
009000020624     c                   eval      rdpos = rdpos + 1
009100020624     c                   if        %subst(rdbuf:rdpos:1) = x'25'
009200020624     c                   return    len
009300020624     c                   endif
009400020624
009500020624     C* Otherwise, add it to the text string.
009600020624     c                   if        %subst(rdbuf:rdpos:1) <> x'0d'
009700020624     c                               and len<maxlen
009800020624     c                   eval      len = len + 1
009900020624     c                   eval      %subst(retstr:len:1) =
010000020624     c                               %subst(rdbuf:rdpos:1)
010100020624     c                   endif
010200020624
010300020624     c                   enddo
010400020624
010500020624     c                   return    len
010600020624     P                 E
