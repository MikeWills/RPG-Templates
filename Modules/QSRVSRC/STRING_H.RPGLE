000100060627       // **********************************************************************
000200060627       // Copybook for misc commands
000300060627
000400060627     D*--------------------------------------------------
000500060627     D* Procedure name: CenterText
000600060627     D* Purpose:        Center the text in a given string to for a given length
000700060627     D* Returns:        The centered string
000800060627     D* Parameter:      stringIn => The String to center
000900060627     D* Parameter:      fieldLength => The length of the field that the str...
001000060627     D*                          ing will be centered in
001100060627     D*--------------------------------------------------
001200060627     D CenterText      PR         32767A
001300060627     D  stringIn                  32767A   CONST
001400070626     D*                                    OPTIONS(*VARSIZE)
001500060627     D  fieldLength                   5P 0 CONST
001600080111
001700080111     D*--------------------------------------------------
001800080111     D* Procedure name: ConvertToUpperCase
001900080111     D* Purpose:        Convert all characters to upper case
002000080111     D* Returns:
002100080111     D* Parameter:      stringIn
002200080111     D* Parameter:      lengthToConvert
002300080111     D*--------------------------------------------------
002400080111     D ConvertToUpperCase...
002500080111     D                 PR         32767A   VARYING
002600080111     D  stringIn                  32767A   VARYING
002700080111     D                                     CONST
002800080111     D  lengthToConvert...
002900080111     D                                5P 0 CONST
003000080111     D                                     OPTIONS(*NOPASS)
003100080111
003200080111     D*--------------------------------------------------
003300080111     D* Procedure name: ConvertToLowerCase
003400080111     D* Purpose:        Convert all characters to upper case
003500080111     D* Returns:
003600080111     D* Parameter:      stringIn
003700080111     D* Parameter:      lengthToConvert
003800080111     D*--------------------------------------------------
003900080111     D ConvertToLowerCase...
004000080111     D                 PR         32767A   VARYING
004100080111     D  stringIn                  32767A   VARYING
004200080111     D                                     CONST
004300080111     D  lengthToConvert...
004400080111     D                                5P 0 CONST
004500080111     D                                     OPTIONS(*NOPASS)
004600080111
004700080124     D*--------------------------------------------------
004800080124     D* Procedure name: WordWrap
004900080124     D* Purpose:        Break the lines at the word so that you don't cut i...
005000080124     D*                          n the middle of a word
005100080124     D* Returns:
005200080124     D* Parameter:      lineIn
005300080124     D* Parameter:      breakAtLength
005400080124     D*--------------------------------------------------
005500080125     D WordWrap        PR          4096A   dim(255)
005600080125     D  stringIn                  32767A   varying const options(*varsize)
005700080125     D  trimLength                    5P 0 const
005800080124
005900080125     D retWordWrap     S           4096A   dim(255)
006000080125
006100090611     D*--------------------------------------------------
006200090611     D* Procedure name: SanitizeString
006300090611     D* Purpose:        Clean up any rouge characters in a string
006400090611     D* Returns:
006500090611     D* Parameter:      stringIn
006600090611     D*--------------------------------------------------
006700090611     D SanitizeString  PR         32767A   VARYING
006800090611     D  stringIn                  32767A   VARYING
006900090611     D                                     CONST
007000091109
007100091109     D*--------------------------------------------------
007200091109     D* Procedure name: FindReplace
007300091109     D* Purpose:
007400091109     D* Returns:
007500091109     D* Parameter:      string
007600091109     D* Parameter:      findString
007700091109     D*--------------------------------------------------
007800100827     D FindReplace     PR         32767A   VARYING
007900100827     D  source                    32767A   VARYING
008000100827     D                                     CONST
008100100827     D  find                        255A   VARYING
008200100827     D                                     VALUE
008300100827     D  replace                     255A   VARYING
008400100827     D                                     VALUE
008500100805
008600100805     D*--------------------------------------------------
008700100805     D* Procedure name: FindReplace
008800100805     D* Purpose:
008900100805     D* Returns:
009000100805     D* Parameter:      string
009100100805     D* Parameter:      number decimal places
009200100805     D*--------------------------------------------------
009300100805     D RtrimZeros      PR            25
009400100805     D  cStringIn                    25    Value
009500100805     D  nDecPlaces                    2  0 Value
009600110512
009700110512     D*--------------------------------------------------
009800110512     D* Procedure name: RightAlign
009900110512     D* Purpose:
010000110512     D* Returns:
010100110512     D* Parameter:      textIn
010200110512     D*--------------------------------------------------
010300110512     D RightAlign      PR         32767A   VARYING
010400110512     D  textIn                    32767A   VARYING
010500110512     D                                     CONST
010600110512     D  length                        5I 0 CONST
