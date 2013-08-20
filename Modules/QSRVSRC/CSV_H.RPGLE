000100110620       // **********************************************************************
000101110620       // Copybook for CSV
000112110620
000113110620     D*--------------------------------------------------
000114110620     D* Procedure name: LoadCsvString
000115110620     D* Purpose:        Gets the next field in the line
000116110620     D* Returns:
000117110620     D* Parameter:      csvString
000119110620     D* Parameter:      csvDelimiter
000120110620     D*--------------------------------------------------
000121110620     D LoadCsvString   PR
000122110620     D  csvString                 65535A   const varying
000124110620     D  csvDelimiter                  1A   CONST
000125110620     D                                     OPTIONS(*NOPASS)
000126110620
000127110620     D*--------------------------------------------------
000128110620     D* Procedure name: GetNextField
000129110620     D* Purpose:        Get the next field in the string
000130110620     D* Returns:
000131110620     D*--------------------------------------------------
000132110620     D GetNextField    PR         32767A   VARYING
000133110620
