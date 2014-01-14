      /copy modules/qcopysrc,hspec_h
       //*************************************************************************
       // Program . . . . . T_RPT
       //
       // Created on  . . .
       //         by  . . .
       //
       // Description . . . Non-SQL Report Template
       //
       // To Compile:
       // *> CRTBNDRPG PGM(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N) DBGVIEW(*SOURCE)
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
     FT_PRTF    O    E             PRINTER OFLIND(*IN40)
       //*************************************************************************
       // Named Constants
     D
      /copy modules/qcopysrc,status_h

       // Named Indicators
     D indicatorPtr    S               *   Inz(%Addr(*IN))
     D                 DS                  Based(IndicatorPtr)
     D  newPage               40     40N

       //*************************************************************************
       // Misc Fields
     D

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
     D PrintHeader     PR

       // External Subprocedures
       ///copy modules/qsrvsrc,string_h

       //*************************************************************************
       // Entry Parms
     D T_RPT           PR                  extpgm('T_RPT')
     D T_RPT           PI
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

       //pgm = 'T_RPT';
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

       read FILE;

       dow (not %eof());

         // TODO: INSERT CODE HERE

         read FILE;

       enddo;

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
 