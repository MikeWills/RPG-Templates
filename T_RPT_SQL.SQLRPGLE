      /copy modules/qcopysrc,hspec_h
       //*************************************************************************
       // Program . . . . . T_RPT_SQL
       //
       // Created on  . . . 09/17/2008
       //         by  . . . Michael N. Wills
       //
       // Description . . . SQL Report Template
       //
       // To Compile:
       // *> CRTSQLRPGI OBJ(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N) -
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

       // Printer/Display Files
     FT_PRTF    O    E             PRINTER oflind(*in40)
       //*************************************************************************
       // Named Constants
     D
      /copy modules/qcopysrc,status_h

       // Named Indicators
     D indicatorPtr    S               *   Inz(%Addr(*IN))
     D                 DS                  Based(IndicatorPtr)
     D  newPage               40     40N

       // SQL Fields
     D sqlStatement    S           2048A   varying
     D SqlResult       DS                  qualified
      /copy modules/qcopysrc,sql_h

       //*************************************************************************
       // Misc Fields
     D

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
     D PrintHeader     PR
     D BuildSqlStatement...
     D                 PR
     D OpenCursor      PR             5A
     D FetchNext       PR             5A
     D CloseCursor     PR             5A

       // External Subprocedures
       ///copy modules/qsrvsrc,string_h

       //*************************************************************************
       // Entry Parms
     D T_RPT_SQL       PR                  extpgm('T_RPT_SQL')
     D T_RPT_SQL       PI
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

       //pgm = 'T_RPT_SQL';
       newPage = *on;

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

      /free

       BuildSqlStatement();

       if (OpenCursor() = SQL_SUCCESS);
         dow (FetchNext() = SQL_SUCCESS);

           // TODO: INSERT CODE HERE

         enddo;
       endif;

       CloseCursor();

       return;

      /end-free
     P Main            E


     P*--------------------------------------------------
     P* Procedure name: PrintHeader
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P PrintHeader     B
     D PrintHeader     PI

      /free
       if (newPage);
         write HEADER;
         newPage = *off;
       endif;
       return;
      /end-free
     P PrintHeader     E


     P*--------------------------------------------------
     P* Procedure name: BuildSqlStatement
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P BuildSqlStatement...
     P                 B
     D BuildSqlStatement...
     D                 PI

      /free

       gSqlStatement = ' ';

       return;

      /end-free
     P BuildSqlStatement...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: OpenCursor
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OpenCursor      B
     D OpenCursor      PI             5A

      /free
       exec sql
         close c1;
       exec sql
         prepare sel from :gsqlstatement;

       if sqlStt = SQL_SUCCESS;
         exec sql
           declare c1 cursor for sel;
         exec sql
           open c1;
       endif;

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
         fetch c1 into :gresultds;
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

 