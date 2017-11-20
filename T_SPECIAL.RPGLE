      /copy modules/qcopysrc,hspec_h
       //*************************************************************************
       // Program . . . . .  T_SPECIAL
       //
       // Created on  . . .
       //         by  . . .
       //
       // Description . . . Special File Program Template
       //
       // To Compile:
       // *> CRTBNDRPG PGM(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N) -
       // *>           DBGVIEW(*SOURCE) 
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
     D  newPage               40     40N

       //*************************************************************************
       // Misc Fields
     D

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
     D OptionOpen      PR
     D OptionClose     PR
     D OptionForceEof  PR
     D OptionRead      PR
     D OptionWrite     PR
     D OptionDelete    PR
     D OptionUpdate    PR

       // External Subprocedures
       ///copy modules/qsrvsrc,string_h

       //*************************************************************************
       // Entry Parms
     D T_SPECIAL       PR                  extpgm('T_SPECIAL')
     D  option                        1A
     D  status                        1A
     D  error                         5P 0
     D  area                      65535A   varying
     D  displayFile                  10A
     D  recordName                   10A
     D* additional parms as needed
     D T_SPECIAL       PI
     D  option                        1A
     D  status                        1A
     D  error                         5P 0
     D  area                      65535A   varying
     D  displayFile                  10A
     D  recordName                   10A
     D* additional parms as needed
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

       //pgm = 'T_SPECIAL';
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

       select;
         // Open the file
         when (option = 'O');
           OptionOpen();

         // Close the file
         when (option = 'C');
           OptionClose();

         // Force the end of file
         when (option = 'F');
           OptionForceEof();

         // Read a record and place it in the area defined by the area parameter
         when (option = 'R');
           OptionRead();

         // The ILE RPG program has placed a record in the area defined by the
         //  area parameter; the record is to be written out.
         when (option = 'W');
           OptionWrite();

         // Delete the record
         when (option = 'D');
           OptionDelete();

         // The record is an update of the last record read
         when (option = 'U');
           OptionUpdate();

       endsl;

       return;

      /end-free
     P Main            E


     P*--------------------------------------------------
     P* Procedure name: OptionOpen
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionOpen      B
     D OptionOpen      PI

      /free



       return;

      /end-free
     P OptionOpen      E


     P*--------------------------------------------------
     P* Procedure name: OptionClose
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionClose     B
     D OptionClose     PI

      /free



       return;

      /end-free
     P OptionClose     E


     P*--------------------------------------------------
     P* Procedure name: OptionForceEof
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionForceEof  B
     D OptionForceEof  PI

      /free



       return;

      /end-free
     P OptionForceEof  E


     P*--------------------------------------------------
     P* Procedure name: OptionRead
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionRead      B
     D OptionRead      PI

      /free



       return;

      /end-free
     P OptionRead      E


     P*--------------------------------------------------
     P* Procedure name: OptionWrite
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionWrite     B
     D OptionWrite     PI

      /free



       return;

      /end-free
     P OptionWrite     E


     P*--------------------------------------------------
     P* Procedure name: OptionDelete
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionDelete    B
     D OptionDelete    PI

      /free



       return;

      /end-free
     P OptionDelete    E


     P*--------------------------------------------------
     P* Procedure name: OptionUpdate
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P OptionUpdate    B
     D OptionUpdate    PI

      /free



       return;

      /end-free
     P OptionUpdate    E


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
 