      /copy modules/qcopysrc,hspec_h
       //*************************************************************************
       // Program . . . . . T_SCRN
       //
       // Created on  . . .
       //         by  . . .
       //
       // Description . . .
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
     FT_DSPF_SFLCF   E             WORKSTN sfile(SFL01:rrn01)
       //*************************************************************************
       // Named Constants
     D
      /copy modules/qcopysrc,status_h

       // Named Indicators
     D indicatorPtr    S               *   Inz(%Addr(*IN))
     D                 DS                  Based(IndicatorPtr)
      /copy modules/qcopysrc,scrn_h
     D continueProcessing...
     D                 S               N   inz(*on)
     D changeMade      S               N

       // Subfile  Fields
     D rrn01           S              4P 0 inz(0)

       //*************************************************************************
       // Misc Fields
     D

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
     D SubfileFilled   PR              N
     D ProcessSubfile  PR
     D Add             PR
     D Change          PR
     D Remove          PR
     D Display         PR
     D ProcessScreen   PR
     D  action                        1A   const
     D ClearScreen     PR
     D IsValidData     PR              N
     D MoveToScreen    PR
     D MoveFromScreen  PR
     D ResetIndicators...
     D                 PR

       // External Subprocedures
       ///copy modules/qsrvsrc,string_h

       //*************************************************************************
       // Entry Parms
     D T_SUBF          PR                  extpgm('T_SUBF')
     D T_SUBF          PI
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

       pgm = 'T_SUBF';
       changeMade = *on;

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

       dow (not F3) and (not F12);

         sflDsp = SubfileFilled();

         write OVR01;
         exfmt CTL01;
         ResetIndicators();

         // *** INSERT CODE HERE ***

       enddo;

       return;

      /end-free
     P Main            E


     P*--------------------------------------------------
     P* Procedure name: SubfileFilled
     P* Purpose: Fill the subfile
     P* Returns:
     P*--------------------------------------------------
     P SubfileFilled   B
     D SubfileFilled   PI              N

     D isFilled        S               N

      /free

       isFilled = *on;

       if (not changeMade);
         hCsrLoc = hCsrRrn;
         if (rrn01 > 0);
           return *on;
         else;
           return *off;
         endif;
       endif;

       sflClear = *on;
       write CTL01;
       sflClear = *off;
       rrn01 = 0;
       hCsrLoc = 1;

       setll *loval FILE;
       read FILE;

       dow (not %eof()) and (rrn01 < 9999);

         // *** INSERT CODE HERE ***

         rrn01 += 1;
         write SFL01;

         read FILE;

       enddo;

       if (rrn01 < 1);
         isFilled = *off;
       endif;

       return isFilled;

      /end-free
     P SubfileFilled   E


     P*--------------------------------------------------
     P* Procedure name: ProcessSubfile
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ProcessSubfile  B
     D ProcessSubfile  PI

      /free

       monitor;

         readc SFL01;

         dow (not %eof());

           // *** INSERT CODE HERE ***

           sel = ' ';
           update SFL01;

           readc SFL01;

         enddo;

       on-error *all;
         // add error-handling code if needed
       endmon;

       return;

      /end-free
     P ProcessSubfile  E


     P*--------------------------------------------------
     P* Procedure name: Add
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P Add             B
     D Add             PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P Add             E


     P*--------------------------------------------------
     P* Procedure name: Change
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P Change          B
     D Change          PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P Change          E


     P*--------------------------------------------------
     P* Procedure name:  Remove
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P Remove          B
     D Remove          PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P Remove          E


     P*--------------------------------------------------
     P* Procedure name: Display
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P Display         B
     D Display         PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P Display         E


     P*--------------------------------------------------
     P* Procedure name: ProcessScreen
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ProcessScreen   B
     D ProcessScreen   PI
     D  action                        1A   const

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P ProcessScreen   E


     P*--------------------------------------------------
     P* Procedure name: ClearScreen
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ClearScreen     B
     D ClearScreen     PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P ClearScreen     E


     P*--------------------------------------------------
     P* Procedure name: IsValidData
     P* Purpose: Validate the data on the screen
     P* Returns: True or False
     P*--------------------------------------------------
     P IsValidData     B
     D IsValidData     PI              N

     D isValid         S               N

      /free

       isValid = *on;

       // *** INSERT CODE HERE ***

       return isValid;

      /end-free
     P IsValidData     E


     P*--------------------------------------------------
     P* Procedure name: MoveToScreen
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P MoveToScreen    B
     D MoveToScreen    PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P MoveToScreen    E


     P*--------------------------------------------------
     P* Procedure name: MoveFromScreen
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P MoveFromScreen  B
     D MoveFromScreen  PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P MoveFromScreen  E


     P*--------------------------------------------------
     P* Procedure name: ResetIndicators
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ResetIndicators...
     P                 B
     D ResetIndicators...
     D                 PI

      /free

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P ResetIndicators...
     P                 E


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
 