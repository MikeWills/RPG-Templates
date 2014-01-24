      /copy modules/qcopysrc,hspec_h
       //*************************************************************************
       // Program . . . . . T_SQLRET
       //
       // Created on  . . . 
       //         by  . . . 
       //
       // Description . . . Template for returning an SQL result set. 
       //
       // To Compile:
       // *> CRTSQLRPGI OBJ(&O/&ON) SRCFILE(&L/QPGMSRC) SRCMBR(&N) -
       // *>            DBGVIEW(*SOURCE)
       // *> DLTSPLF FILE(&N) SPLNBR(*LAST)
       //
       // CHANGE LOG:
       // Date       | Name            | Description
       // -----------------------------------------------------------------------
       //            |                 |
       //            |                 |
       //            |                 |
       //*************************************************************************
       // Files
     F

       //*************************************************************************
       // Named Constants
     D    
      /copy modules/qcopysrc,status_h

       // Named Indicators
     D indicatorPtr    S               *   Inz(%Addr(*IN))
     D                 DS                  Based(IndicatorPtr)
      /copy modules/qcopysrc,sql_h

       //*************************************************************************
       // File Fields
     D 

       //*************************************************************************
       // Misc
     D MessageList     DS                  qualified
     D  Message                      50A   varying
     D  Date                         10A
     D  WarningError                   N
     D  TerminalError                  N
     D index           S              3I 0
     D rowCount        S             10I 0
     D pMessages       DS                  likeds(MessageList) dim(100)

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
     D AddMessage      PR
     D  message                      50A   varying const
     D  date                           D
     D  warningError                   N   const
     D  terminalError                  N   const
     D OpenCursor      PR             5A
     D FetchNext       PR             5A
     D CloseCursor     PR             5A

       // External Subprocedures
      /copy modules/qsrvsrc,cmd_h

       //*************************************************************************
       // Entry Parms
     D T_SQLRET        PR                  extpgm('T_SQLRET')
     D T_SQLRET        PI
       //*************************************************************************
      /free
       Init();
       Main();
       *inlr = *on;
      /end-free

     P*--------------------------------------------------
     P* Procedure name: Init
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P Init            B
     D Init            PI
      /free

       exec sql
         set option naming = *sys, commit = *none, usrprf = *user,
                    dynusrprf = *user, datfmt = *iso, closqlcsr = *endmod;
       //pgm = 'T_SQLRET';

       return;
      /end-free
     P Init            E


     P*--------------------------------------------------
     P* Procedure name: Main
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P Main            B
     D Main            PI

     D i               S              2P 0
      /free

       if (OpenCursor() = SQL_SUCCESS);
         dow (FetchNext() = SQL_SUCCESS);

           // TODO: Insert your code here

         enddo;

       endif;

       CloseCursor();

       exec sql
         set result sets for return to client array
           :pmessages for :rowcount rows;

       return;
      /end-free
     P Main            E


     P*--------------------------------------------------
     P* Procedure name: AddMessage
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P AddMessage      B
     D AddMessage      PI
     D  message                      50A   varying const
     D  date                           D
     D  warningError                   N   const
     D  terminalError                  N   const
      /free
       index += 1;
       pMessages(index).Message = message;
       pMessages(index).Date = %char(date:*iso);
       pMessages(index).TerminalError = terminalError;
       pMessages(index).WarningError = warningError;
       rowCount += 1;
       return;
      /end-free
     P AddMessage      E


     P*--------------------------------------------------
     P* Procedure name: OpenCursor
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OpenCursor      B
     D OpenCursor      PI             5A

     D ssnNum          S              9P 0

      /free
       exec sql
         close c1;

       exec sql
         declare c1 cursor for
           select *
             from file;
       exec sql
         open c1;

       return sqlStt;

      /end-free
     P OpenCursor      E


     P*--------------------------------------------------
     P* Procedure name: FetchNext
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P FetchNext       B
     D FetchNext       PI             5A
      /free
       exec sql
         fetch c1 into :rec;
       return sqlstt;
      /end-free
     P FetchNext       E


     P*--------------------------------------------------
     P* Procedure name: CloseCusor
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P CloseCursor     B
     D CloseCursor     PI             5A
      /free
       exec sql
         close c1;
       return sqlstt;
      /end-free
     P CloseCursor     E


     P*--------------------------------------------------
     P* Procedure name: Template
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P*Template        B
     D*Template        PI
      *
      */free
      *
      *
      *
      * return;
      *
      */end-free
     P*Template        E 