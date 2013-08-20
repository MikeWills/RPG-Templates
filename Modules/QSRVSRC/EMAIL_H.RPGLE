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
001800120214     D  body                      32767A   const varying
001900120214
002000120214
002100120214     P*--------------------------------------------------
002200120214     P* Procedure name: SendEmail
002300120214     P* Purpose:        Send Email at Real-Time
002400120214     P* Returns:        Was the Email Successful?
002500120214     P* Parameter:      fromAddress
002600120214     P* Parameter:      toAddress
002700120214     P* Parameter:      ccAddress
002800120214     P* Parameter:      subject
002900120214     P* Parameter:      body
003000120214     P* Parameter:      attachment
003100120214     P*--------------------------------------------------
003200120214     D SendMailAttachment...
003300120214     D                 PR              N
003400120214     D  fromAddress                 100A   const varying
003500120214     D  toAddress                 32767A   const varying
003600120214     D  ccAddress                 32767A   const varying
003700120214     D  bccAddress                32767A   const varying
003800120214     D  subject                   32767A   const varying
003900120214     D  body                      32767A   const varying
004000120214     D  attachment                 1024A   const varying
004100061227
004200090928     D*--------------------------------------------------
004300090928     D* Procedure name: ParseEmailAddresses
004400090928     D* Purpose:        When a program passes multiple email addresses, this
004500090928     D*                          program will break them apart.
004600090928     D* Returns:        Array of Email Addresses
004700090928     D* Parameter:      ToParse => List of email addresses to parse seperated
004800090928     D*                          by a semi-colon.
004900090928     D*--------------------------------------------------
005000090928     D ParseEmailAddresses...
005100090928     D                 PR         32700A
005200090928     D  toParse                   32767A   CONST
005300090928
005400110428     D*--------------------------------------------------
005500110428     D* Procedure name: IsValidEmailAddress
005600110428     D* Purpose:        Validate via Regex that the email address is valid
005700110428     D* Returns:        True is Valid
005800110428     D* Parameter:      emailAddress
005900110428     D*--------------------------------------------------
006000110428     D IsValidEmailAddress...
006100110428     D                 PR              N
006200110428     D  emailAddress              32767A   VARYING
006300110428     D                                     CONST
