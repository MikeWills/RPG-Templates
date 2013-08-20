000100110428      ** Header file for calling the "Regular Expression" functions
000200110428      **   provided by the ILE C Runtime Library from an RPG IV
000300110428      **   program.                 Scott Klement, 2001-05-04
000400110428      **                       Converted to qualified DS 2003-11-29
000500110428      **
000600110428     D/if defined(REGEX_H)
000700110428     D/eof
000800110428     D/endif
000900110428     D/define REGEX_H
001000110428
001100110428
001200110428      **------------------------------------------------------------
001300110428      * cflags for regcomp()
001400110428      **------------------------------------------------------------
001500110428     D REG_BASIC       C                   CONST(0)
001600110428     D REG_EXTENDED    C                   CONST(1)
001700110428     D REG_ICASE       C                   CONST(2)
001800110428     D REG_NEWLINE     C                   CONST(4)
001900110428     D REG_NOSUB       C                   CONST(8)
002000110428
002100110428
002200110428      **------------------------------------------------------------
002300110428      * eflags for regexec()
002400110428      **------------------------------------------------------------
002500110428     D REG_NOTBOL      C                   CONST(256)
002600110428     D REG_NOTEOL      C                   CONST(512)
002700110428
002800110428
002900110428      **------------------------------------------------------------
003000110428      *  errors returned
003100110428      **------------------------------------------------------------
003200110428     D REG_NOMATCH     C                   CONST(1)
003300110428     D REG_BADPAT      C                   CONST(2)
003400110428     D REG_ECOLLATE    C                   CONST(3)
003500110428     D REG_ECTYPE      C                   CONST(4)
003600110428     D REG_EESCAPE     C                   CONST(5)
003700110428     D REG_ESUBREG     C                   CONST(6)
003800110428     D REG_EBRACK      C                   CONST(7)
003900110428     D REG_EPAREN      C                   CONST(8)
004000110428     D REG_EBRACE      C                   CONST(9)
004100110428     D REG_BADBR       C                   CONST(10)
004200110428     D REG_ERANGE      C                   CONST(11)
004300110428     D REG_ESPACE      C                   CONST(12)
004400110428     D REG_BADRPT      C                   CONST(13)
004500110428     D REG_ECHAR       C                   CONST(14)
004600110428     D REG_EBOL        C                   CONST(15)
004700110428     D REG_EEOL        C                   CONST(16)
004800110428     D REG_ECOMP       C                   CONST(17)
004900110428     D REG_EEXEC       C                   CONST(18)
005000110428
005100110428
005200110428      **------------------------------------------------------------
005300110428      *  Structure of a compiled regular expression:
005400110428      *
005500110428      *     #define __REG_SUBEXP_MAX       9
005600110428      *     typedef struct {
005700110428      *         size_t        re_nsub;
005800110428      *         void          *re_comp;
005900110428      *         int           re_cflags;
006000110428      *         size_t        re_erroff;
006100110428      *         size_t        re_len;
006200110428      *         _LC_colval_t  re_ucoll[2];
006300110428      *         void          *re_lsub[__REG_SUBEXP_MAX+1];
006400110428      *         void          *re_esub[__REG_SUBEXP_MAX+1];
006500110428      *         unsigned char re_map[256];
006600110428      *         mbstate_t     re_shift;
006700110428      *         short         re_dbcs;
006800110428      *     } regex_t;
006900110428      **------------------------------------------------------------
007000110428     D REG_SUBEXP_MAX  C                   10
007100110428     D regex_t         DS                  qualified
007200110428     D                                     align based(prototype_only)
007300110428     D   re_nsub                     10I 0
007400110428     D   re_comp                       *
007500110428     D   re_cflags                   10I 0
007600110428     D   re_erroff                   10I 0
007700110428     D   re_len                      10I 0
007800110428     D   re_ucoll                    10I 0 dim(2)
007900110428     D   re_lsub                       *   DIM(REG_SUBEXP_MAX)
008000110428     D   re_esub                       *   DIM(REG_SUBEXP_MAX)
008100110428     D   re_map                     256A
008200110428     D   re_shift                     5I 0
008300110428     D   re_dbcs                      5I 0
008400110428
008500110428
008600110428      **------------------------------------------------------------
008700110428      *  structure used to report matches found by regexec()
008800110428      *
008900110428      *     typedef struct {
009000110428      *         _off_t     rm_so; /* offset of substring             */
009100110428      *         mbstate_t  rm_ss; /* shift state at start of subst   */
009200110428      *         _off_t     rm_eo; /* offset of next char after subst */
009300110428      *         mbstate_t  rm_es; /* shift state at end of subst     */
009400110428      *     } regmatch_t;
009500110428      *
009600110428      * NOTE: It's important to remember that C starts numbering
009700110428      *    string positions with '0' and RPG starts with '1'.
009800110428      *    Thus, rm_so+1 is the first char in substring, rm_eo is
009900110428      *    the last char in the substring in RPG.
010000110428      **------------------------------------------------------------
010100110428     D regmatch_t      DS                  qualified
010200110428     D                                     align based(prototype_only)
010300110428     D   rm_so                       10I 0
010400110428     D   rm_ss                        5I 0
010500110428     D   rm_eo                       10I 0
010600110428     D   rm_es                        5I 0
010700110428
010800110428
010900110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
011000110428      * regcomp() -- Compile a Regular Expression ("RE")
011100110428      *
011200110428      *     int regcomp(regex_t *preg, const char *pattern,
011300110428      *              int cflags);
011400110428      *
011500110428      * where:
011600110428      *       preg (output) = the compiled regular expression.
011700110428      *    pattern (input)  = the RE to be compiled.
011800110428      *     cflags (input)  = the sum of the cflag constants
011900110428      *                       (listed above) for this RE.
012000110428      *
012100110428      * Returns 0 = success, otherwise an error number.
012200110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
012300110428     D regcomp         PR            10I 0 extproc('regcomp')
012400110428     D   preg                              like(regex_t)
012500110428     D   pattern                       *   value options(*string)
012600110428     D   cflags                      10I 0 value
012700110428
012800110428
012900110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
013000110428      * regexec() -- Execute a compiled Regular Expression ("RE")
013100110428      *
013200110428      *     int regexec(const regex_t *preg, const char *string,
013300110428      *              size_t nmatch, regmatch_t *pmatch, int eflags);
013400110428      *
013500110428      * where:
013600110428      *       preg (input)  = the compiled regular expression
013700110428      *                       (the output of regcomp())
013800110428      *     string (input)  = string to run the RE upon
013900110428      *     nmatch (input)  = the number of matches to return.
014000110428      *     pmatch (output) = array of regmatch_t DS's
014100110428      *                       showing what matches were found.
014200110428      *     eflags (input)  = the sum of the flags (constants
014300110428      *                       provided above) modifying the RE
014400110428      *
014500110428      * Returns 0 = success, otherwise an error number.
014600110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
014700110428     D regexec         PR            10I 0 extproc('regexec')
014800110428     D   preg                              like(regex_t) const
014900110428     D   string                        *   value options(*string)
015000110428     D   nmatch                      10U 0 value
015100110428     D   pmatch                            like(regmatch_t) dim(100)
015200110428     D                                     options(*varsize)
015300110428     D   eflags                      10I 0 value
015400110428
015500110428
015600110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
015700110428      * regerror() -- return error information from regcomp/regexec
015800110428      *
015900110428      *   size_t regerror(int errcode, const regex_t *preg,
016000110428      *              char *errbuf, size_t errbuf_size);
016100110428      *
016200110428      *  where:
016300110428      *    errcode (input)  = the error code to return info on
016400110428      *                      (obtained as the return value from
016500110428      *                      either regcomp() or regexec())
016600110428      *       preg (input)  = the (compiled) RE to return the
016700110428      *                      error for.
016800110428      *     errbuf (output) = buffer containing human-readable
016900110428      *                      error message.
017000110428      * errbuf_size (input) = size of errbuf (max length of msg
017100110428      *                      that will be returned)
017200110428      *
017300110428      * returns:  length of buffer needed to get entire error msg
017400110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
017500110428     D regerror        PR            10U 0 extproc('regerror')
017600110428     D   errcode                     10I 0 value
017700110428     D   preg                              like(regex_t) const
017800110428     D   errbuf                        *   value
017900110428     D   errbuf_size                 10I 0 value
018000110428
018100110428
018200110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
018300110428      * regfree() -- free memory locked by Regular Expression
018400110428      *
018500110428      *    void regfree(regex_t *preg);
018600110428      *
018700110428      *   where:
018800110428      *        preg (input) = regular expression to free mem for.
018900110428      *
019000110428      *   NOTE:  regcomp() will always allocate extra memory
019100110428      *        to be pointed to by the various pointers in
019200110428      *        the regex_t structure.  If you don't call this,
019300110428      *        that memory will never be returned to the system!
019400110428      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
019500110428     D regfree         PR                  extproc('regfree')
019600110428     D   preg                              like(regex_t)
019700110428
