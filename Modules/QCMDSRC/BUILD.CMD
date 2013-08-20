000100110512/*   *> CRTCMD CMD(&O/&ON) PGM(MODULES/BUILDR4) -   <* +
000101110512 *   *>        MODE(*ALL) ALLOW(*ALL) -             <* +
000102110512 *   *>        TEXT(&X)                             <* +
000103110512 *                                                     */
000104110512             CMD        PROMPT('Build an object from source')
000105110512
000106110512             PARM       KWD(OBJ) TYPE(FILE1) MIN(1) PROMPT('Object Name')
000107110512
000108110512             PARM       KWD(SRCFILE) TYPE(FILE2) PROMPT('Source File')
000109110512
000110110512             PARM       KWD(SRCMBR) TYPE(*NAME) DFT(*OBJ) SPCVAL((*OBJ)) PROMPT('Source +
000111110512                          member') EXPR(*YES)
000112110512
000113110512             PARM       KWD(DBGVIEW) TYPE(*CHAR) LEN(7) RSTD(*YES) DFT(*LIST) VALUES(*LIST +
000114110512                          *SOURCE *STMT *NONE) PROMPT('Debug View') EXPR(*YES)
000115110512
000116110512             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) DFT(*YES) VALUES(*YES *NO) +
000117110512                          EXPR(*YES) PROMPT('Replace object')
000118110512
000119110512             PARM       KWD(ALWF9) TYPE(*CHAR) LEN(4) RSTD(*YES) DFT(*NO) VALUES(*YES *NO) +
000120110512                          EXPR(*YES) PROMPT('Allow F9=Retrieve on commands')
000121110512
000122110512             PARM       KWD(OPTION) TYPE(*CHAR) LEN(10) RSTD(*YES) VALUES(*NOEVENTF *EVENTF) +
000123110512                          EXPR(*YES) PMTCTL(*PMTRQS) PROMPT('Compiler Options')
000124110512
000125110512
000126110512 FILE1:      QUAL       TYPE(*NAME) EXPR(*YES)
000127110512             QUAL       TYPE(*NAME) DFT(*CURLIB) EXPR(*YES) SPCVAL((*CURLIB)) PROMPT('Library')
000128110512
000129110512 FILE2:      QUAL       TYPE(*NAME) DFT(QRPGLESRC) EXPR(*YES)
000130110512             QUAL       TYPE(*NAME) DFT(*LIBL) EXPR(*YES) SPCVAL((*LIBL) (*CURLIB)) +
000131110512                          PROMPT('Library')
000132110512
