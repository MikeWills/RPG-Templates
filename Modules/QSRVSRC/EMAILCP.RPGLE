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
001200090120     D SendMail        PR              N
001300090120     D  fromAddress                 100A   const varying
001400090120     D  toAddress                 32767A   const varying
001500090120     D  ccAddress                 32767A   const varying
001600090120     D  bccAddress                32767A   const varying
001700090120     D  subject                   32767A   const varying
001800090120     D  body                      32767A   const varying
001900061227
002000090928     D*--------------------------------------------------
002100090928     D* Procedure name: ParseEmailAddresses
002200090928     D* Purpose:        When a program passes multiple email addresses, this
002300090928     D*                          program will break them apart.
002400090928     D* Returns:        Array of Email Addresses
002500090928     D* Parameter:      ToParse => List of email addresses to parse seperated
002600090928     D*                          by a semi-colon.
002700090928     D*--------------------------------------------------
002800090928     D ParseEmailAddresses...
002900090928     D                 PR         32700A
003000090928     D  toParse                   32767A   CONST
003100090928
003200110428     D*--------------------------------------------------
003300110428     D* Procedure name: IsValidEmailAddress
003400110428     D* Purpose:        Validate via Regex that the email address is valid
003500110428     D* Returns:        True is Valid
003600110428     D* Parameter:      emailAddress
003700110428     D*--------------------------------------------------
003800110428     D IsValidEmailAddress...
003900110428     D                 PR              N
004000110428     D  emailAddress              32767A   VARYING
004100110428     D                                     CONST
