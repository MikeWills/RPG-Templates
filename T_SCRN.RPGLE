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
       // *> CRTBNDRPG PGM(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N)
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
     FT_DSPF    CF   E             WORKSTN
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

       //*************************************************************************
       // Misc Fields
     D

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
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
     D T_SCRN          PR                  extpgm('T_SCRN')
     D T_SCRN          PI
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

       pgm = 'T_SCRN';

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

       // *** INSERT CODE HERE ***

       return;

      /end-free
     P Main            E


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
 