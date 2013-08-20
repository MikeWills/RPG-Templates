000100110513    /* ********************************************************************** */
000200110513    /* Compiler Options:                                                      */
000300110513    /*   COMPILE OPTIONS HERE                                                 */
000400110513    /*                                                                        */
000500110516    /* Program . . . . . SENDEMAIL                                            */
000600110516    /*   Calls . . . . . SENDEMAIL                                            */
000700110513    /*                                                                        */
000800110513    /* Created on  . . .                                                      */
000900110513    /*         by  . . .                                                      */
001000110513    /*                                                                        */
001100110513    /* Description . . .                                                      */
001200110513    /*                                                                        */
001300110513    /* To Compile:                                                            */
001400110513    /* *> CRTCMD CMD(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N) PGM(LIB/PGM)       <*  */
001500110516    /* *> DLTSPLF FILE(&ON) SPLNBR(*LAST)                                 <*  */
001600110513    /*                                                                        */
001700110513    /* CHANGE LOG:                                                            */
001800110513    /* Date       | Name            | Description                             */
001900110513    /* ---------------------------------------------------------------------- */
002000110513    /*            |                 |                                         */
002100110513    /*            |                 |                                         */
002200110513    /*            |                 |                                         */
002300110513    /* ************************************************************************/
002400110516             CMD        PROMPT(SENDEMAIL)
002500061016
002600070620             PARM       KWD(FROM) TYPE(*CHAR) LEN(100) MIN(1) VARY(*YES *INT2) PROMPT('From +
002700070620                          Address: ')
002800070620             PARM       KWD(TO) TYPE(*CHAR) LEN(32767) MIN(1) VARY(*YES *INT2) PROMPT('To +
002900070620                          Address:')
003000070620             PARM       KWD(CC) TYPE(*CHAR) LEN(32767) VARY(*YES *INT2) PROMPT('CC Address:')
003100070620             PARM       KWD(BCC) TYPE(*CHAR) LEN(32767) VARY(*YES *INT2) PROMPT('BCC Address:')
003200070620             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(32767) MIN(1) VARY(*YES *INT2) +
003300070620                          PROMPT('Subject:')
003400070620             PARM       KWD(MESSAGE) TYPE(*CHAR) LEN(32767) MIN(1) VARY(*YES *INT2) +
003500070620                          PROMPT('Message:')
