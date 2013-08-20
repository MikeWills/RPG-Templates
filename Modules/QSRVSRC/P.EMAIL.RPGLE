000100
000200061012     D*--------------------------------------------------
000300061012     D* Procedure name: SendEmail
000400061012     D* Purpose:        Send Email at Real-Time
000500061012     D* Returns:        Was the Email Successful?
000600061012     D* Parameter:      fromAddress
000700061012     D* Parameter:      toAddress
000800061012     D* Parameter:      ccAddress
000900061012     D* Parameter:      subject
001000061012     D* Parameter:      body
001100061012     D*--------------------------------------------------
001200070619     D SendEmail       PR              N
001201070619     D  fromAddress                 100A   CONST
001202070619     D  toAddress                 32767A   CONST
001203070619     D  ccAddress                 32767A   CONST
001204070619     D  bccAddress                32767A   CONST
001205070619     D  subject                   32767A   CONST
001206070619     D  body                      32767A   CONST
001900061012
002000061012     P*--------------------------------------------------
002100061012     P* Procedure name: SendBatchEmail
002200061012     P* Purpose:        Send Email in batch
002300061012     P* Returns:        Was the Email Successful?
002400061012     P* Parameter:      fromAddress
002500061012     P* Parameter:      toAddress
002600061012     P* Parameter:      ccAddress
002700061012     P* Parameter:      subject
002800061012     P* Parameter:      body
002900061012     P*--------------------------------------------------
003000061013     D SendBatchEmail  PR
003100070619     D  fromAddress                 100A   CONST
003200070619     D  toAddress                 32767A   CONST
003300070619     D  ccAddress                 32767A   CONST
003400070619     D  bccAddress                32767A   CONST
003500070619     D  subject                   32767A   CONST
003600070619     D  body                      32767A   CONST
003700061013
003800061227     D*--------------------------------------------------
003900061227     D* Procedure name: ParseEmailAddresses
004000061227     D* Purpose:        When a program passes multiple email addresses, this
004100061227     D*                          program will break them apart.
004200061227     D* Returns:        Array of Email Addresses
004300061227     D* Parameter:      ToParse => List of email addresses to parse seperated
004400061227     D*                          by a semi-colon.
004500061227     D*--------------------------------------------------
004600061227     D ParseEmailAddresses...
004700061227     D                 PR         32700A
004800061227     D  ToParse                   32767A   CONST
004900061227
