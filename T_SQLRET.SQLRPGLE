      /copy modules/qcopysrc,hspec_h
       //*************************************************************************
       // Program . . . . . MPRTCE
       //
       // Created on  . . . 08/16/2011
       //         by  . . . Michael N. Wills
       //
       // Description . . . File MPR604L is run through Open Query file to
       //                   select 1 dept and is sorted by Name, Hours Type,
       //                   Date
       //                   Code updated from MPRTC1 to free-format and
       //                   redesigned to work with Employee Payroll Portal.
       //
       //******************************************************************
       //   TIMECARD EDIT FOR AFTER DEPARTMENTAL ENTRY - CHECK:           *
       //      (MOST ERRORS ARE "TERMINAL", UNLESS LABELED "WARNING")     *
       //  1. DEPARTMENT NUMBER AGAINST GEN10                             *
       //  2. THAT ALL OVERTIME HOURS HAVE A JOB NUMBER SPECIFIED         *
       //  3. VACATION & SICK MUST BE IN WHOLE or HALF HOURS              *
       //  4. 8 HRS+ VACATION TAKEN WHILE FLOATING HOLIDAY STILL...WARNING*
       //  5. 8 HRS+ POL.HOL. TAKEN WHILE FLOATING HOLIDAY STILL...WARNING*
       //  6. PROJECT# IS ONLY FIVE DIGITS (HTE HAS AS 6 CHARACTER)       *
       //  7. PROJECT NUMBER IN VALID RANGE FOR THE DEPARTMENT            *
       //  8. JOB NUMBER IS IN VALID RANGE FOR THE DEPARTMENT             *
       //  9. PROJECT NUMBER IS IN PROJECT MASTER FILE                    *
       // 10. JOB NUMBER IS IN JOB MASTER FILE                            *
       // 11. FLOATING HOLIDAY MUST BE = 8.000 HOURS ** ONLY **           *
       // 12. LOST TIME OVER 16 HRS/PP = NO ACCRUALS THAT P.P......WARNING*
       // XXXXOVER 40 HOURS ENTERED FOR ONE DAY (SUMMARY)          WARNING*
       // XXXXJOB # 066 (LEC "SWAP HOURS") IN MULTIPLES OF TWO.....WARNING*
       // 15. MILITARY LEAVE NOT OVER 17 DAYS FOR THE YEAR                *
       // 16. IF SCHEDULED HOURS CODE IS P3, COMP MUST BE '35' NOT '07'   *
       // XXXXHOUR- - - - - - - - - - -O DEPT 42200 (MARIE'S EDIT ONLY)   *
       // 18. CHECK ENTIRE G/L ACCOUNT CODING (ACCT EXISTS FOR DEPT)      *
       // 19. HOUSING - ALL HOURS EXCEPT 06 AND 07 MUST HAVE A PROJECT #  * 6/23/00 OR A DEPT# 6/09
       // XXXXHOUSING - 06 AND 07 CANNOT HAVE A PROJECT #                 *
       // *****************************************************************
       //
       // To Compile:
       // *> CRTSQLRPGI OBJ(&O/MPRTCE) SRCFILE(&L/QPGMSRC) SRCMBR(MPRTCE) -
       // *>   DBGVIEW(*SOURCE)
       // *> DLTSPLF FILE(MPRTCE) SPLNBR(*LAST)
       //
       // CHANGE LOG:
       // Date       | Name            | Description
       // -----------------------------------------------------------------------
       //            |                 |
       //            |                 |
       //            |                 |
       //*************************************************************************
       // Files
     FGLDEPTP   IF   E           K DISK                                         Check valid coding
     FGLTDEPTP  IF   E           K DISK    prefix(T)                            Get Fund for Dept
     FMPR541AP  IF   E           K DISK    prefix(A)                            Accr. mast no Inacti
     FMPR600ML  IF   E           K DISK    rename(PR600AF:MPRML1)               Year's Military Leav
     FPR020AP   IF   E           K DISK                                         Hours Type Acct#
     FPR021AP   IF   E           K DISK    prefix(B)                            Spend from Acr Type
     FPJJOBMP   IF   E           K DISK                                         Job Master
     FPJMASTP   IF   E           K DISK                                         Project Master
     FPJVLID1   IF   E           K DISK                                         Valid Proj for Dept
     FMPRTCSP   IF   E           K DISK                                         Timesheet signatures
     FPR101AP   IF   E           K DISK                                         Pay period dates

       //*************************************************************************
       // Named Constants
     D DIGITS          C                   Const(' 0123456789')
     D ZERO_DATE       S               D
      /copy modules/qcopysrc,status_h

       // Named Indicators
     D indicatorPtr    S               *   Inz(%Addr(*IN))
     D                 DS                  Based(IndicatorPtr)
     D floatingHoliday...
     D                 S               N
     D Vacation8Hours  S               N
      /copy modules/qcopysrc,sql_h

       //*************************************************************************
       // File Fields
     D MPR604L_Rec   E DS                  extname(MPR604L) qualified
     D GLDEPTP_Rec     DS                  likerec(GLDEPTP1:*input)
     D GLTDEPTP_Rec    DS                  likerec(GLTDEPP1:*input)
     D PR020AP_Rec     DS                  likerec(PR020AF:*input)
     D PR021AP_Rec     DS                  likerec(PR021AF:*input)
     D PR101AP_Rec     DS                  likerec(PR100AF:*input)
     D MPR541AP_Rec    DS                  likerec(PR541AF:*input)
     D MPR600ML_Rec    DS                  likerec(MPRML1:*input)
     D PJJOBMP_Rec     DS                  likerec(PJJOBMP1:*input)
     D PJMASTP_Rec     DS                  likerec(PJMASTP1:*input)
     D PJVLID1_Rec     DS                  likerec(PJVLID11:*input)
     D MPRTCSP_Rec     DS                  likerec(MPRTCSP1:*input)

       //*************************************************************************
       // Misc
     D MessageList     DS                  qualified
     D  Message                      50A   varying
     D  Date                         10A
     D  WarningError                   N
     D  TerminalError                  N
     D index           S              3I 0
     D dept            S              5P 0
     D totalHours      S              8P 3
     D
     D                 DS
     D timesheetJob            1      3
     D timesheetDiv            4      5
     D timesheetAcct           6      8
     D timesheetParse          1     50
     D militaryLeaveDays...
     D                 S              3P 0
     D rowCount        S             10I 0
     D pMessages       DS                  likeds(MessageList) dim(100)

       //*************************************************************************
       // External Program Procedures

       // Internal Subprocedures
     D Init            PR
     D Main            PR
     D ValidateTimesheet...
     D                 PR
     D ValidateHoursCode...
     D                 PR
     D  hoursCode                     2A
     D  hoursTotal                    7P 3
     D ValidateEmployee...
     D                 PR
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
     D MPRTCE          PR                  extpgm('MPRTCE')
     D  pSsn                          9A
     D  pYear                         4P 0
     D MPRTCE          PI
     D  pSsn                          9A
     D  pYear                         4P 0
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

       ZERO_DATE = %date('0001-01-01');
       //pgm = 'MRPTCE';

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
     D savePrSsn       S                   like(MPR604L_Rec.PrSsn)
     D savePrHrt       S                   like(MPR604L_Rec.PrHrt)
     D hoursTotal      S              7P 3
     D
     D i               S              2P 0
      /free

       if (OpenCursor() = SQL_SUCCESS);
         dow (FetchNext() = SQL_SUCCESS);

           if (savePrHrt <> MPR604L_Rec.PrHrt and savePrHrt <> ' ');
             ValidateHoursCode(savePrHrt: hoursTotal);
             hoursTotal = 0;
           endif;

           savePrHrt = MPR604L_Rec.PrHrt;
           hoursTotal += MPR604L_Rec.PrHrsQ;
           totalHours += MPR604L_Rec.PrHrsQ;
           ValidateTimesheet();

         enddo;

         ValidateHoursCode(savePrHrt: hoursTotal);
         ValidateEmployee();

       endif;

       CloseCursor();

       exec sql
         set result sets for return to client array
           :pmessages for :rowcount rows;

       return;
      /end-free
     P Main            E


     P*--------------------------------------------------
     P* Procedure name: ValidateTimesheet
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ValidateTimesheet...
     P                 B
     D ValidateTimesheet...
     D                 PI

     D projectNumericTest...
     D                 S              6P 0
     D account         S              6P 0
     D hoursNoDecimal  S              7P 0
     D ppBeginDate     S               D
     D ppEndDate       S               D
     D tempDate        S               D
     D tsDate          S               D

      /free

       timesheetParse = MPR604L_Rec.prHrAn;
       tsDate = %date((MPR604L_Rec.PRDHDY * 10000) +
                      (MPR604L_Rec.PRDHDM * 100) +
                      (MPR604L_Rec.PRDHDD):*ymd);

       // ********************************
       // Check that there is digits in the dept and job
       if (%check(DIGITS: timesheetDiv) <> 0 OR
           %check(DIGITS: timesheetAcct) <> 0);
         AddMessage('Department number does not exist':tsDate:false:true);
         return;
       endif;

       if (%check(DIGITS: timesheetJob) <> 0);
         AddMessage('Job number does not exist':tsDate: false: true);
         return;
       endif;

       // ********************************
       // 1) CHECK DEPARTMENT NUMBER (NEED TO GET HOME DEPT IF BLANK)
       if (MPR604L_Rec.PrDiv = 0) and (MPR604L_Rec.PrAct = 0);
         dept = (MPR604L_Rec.HomDiv * 1000) + MPR604L_Rec.HomAct;
       else;
         dept = (MPR604L_Rec.PrDiv * 1000) + MPR604L_Rec.PrAct;
       endif;

       chain (dept) GLTDEPP1 GLTDEPTP_Rec;

       if (not %found());
         AddMessage('Department number does not exist':tsDate:false:true);
       endif;

       // ********************************
       // 2) OVERTIME HOURS NEED A JOB NUMBER SUPPLIED
       if (MPR604L_Rec.PrHrT = 'OT') or (MPR604L_Rec.PrHrT = '20');
         if (%subst(MPR604L_Rec.PrHrAn:1:3) = '') or
            (%int(%subst(MPR604L_Rec.PrHrAn:1:3)) = 0);
           AddMessage('Overtime requires a job number':tsDate:false:true);
         endif;
       endif;

       // ********************************
       // 3) VACATION AND SICK MUST BE IN WHOLE or 1/2 Hours
       if (MPR604L_Rec.PrHrT = '02') or (MPR604L_Rec.PrHrT = '03') or
          (MPR604L_Rec.PrHrT = '04') or (MPR604L_Rec.PrHrT = '05');
         hoursNoDecimal = MPR604L_Rec.PrHrsQ * 1000;
         if (%rem(hoursNoDecimal:500) <> 0);
           AddMessage('Vac/Sick: Whole or 1/2 hour increments only':
                      tsDate:false:true);
         endif;
       endif;

       // ********************************
       // 4) Check floating holiday at end of employee
       //    (move "Y" to FloatHol if it was used this pay period)
       if (MPR604L_Rec.PrHrT = '09');
         floatingHoliday = true;
       endif;

       if (MPR604L_Rec.PrHrT = '04') or (MPR604L_Rec.PrHrT = '05') or
          (MPR604L_Rec.PrHrT = '10');
         if (MPR604L_Rec.PrHrsQ >= 8);
           Vacation8Hours = true;
         endif;
       endif;

       // ********************************
       // 6) INSURE A NON-BLANK PROJECT NUMBER CONTAINS ONLY NUMBERS
       //    IN THE LEFT FIVE POSITIONS (6TH POS. ALWAYS BLANK)
       if (MPR604L_Rec.PrProj <> ' ');
         // Check numeric
         monitor;
           projectNumericTest = %int(MPR604L_Rec.PrProj);
         on-error PGM_ALPHA_NUMERIC_ERROR;
           AddMessage('Project number does not exist':tsDate:false:true);
         endmon;

         // Check length
         if (%len(%trim(MPR604L_Rec.PrProj)) <> 5);
           AddMessage('Project number does not exist':tsDate:false:true);
           return;
         endif;
       endif;

       // ********************************
       // 8) SEE IF PROJECT NUMBER IS IN THE MASTER FILE
       if (MPR604L_Rec.PrProj <> ' ');
         chain (%int(MPR604L_Rec.PrProj)) PJMASTP1;
         if (not %found());
           AddMessage('Project number does not exist':tsDate:false:true);
         endif;
       endif;

       // ********************************
       // 10) SEE IF JOB NUMBER IS IN THE MASTER FILE
       if (%subst(MPR604L_Rec.PrHrAn:1:3) <> '');
         if (%int(%subst(MPR604L_Rec.PrHrAn:1:3)) <> 0);
           chain (%int(%subst(MPR604L_Rec.PrHrAn:1:3))) PJJOBMP1;
           if (not %found());
             AddMessage('Job number does not exist':tsDate:false:true);
           endif;
         endif;
       endif;

       // ********************************
       // 11) FLOATING HOLIDAY TAKEN CAN BE = 8.000 HOURS ONLY
       if (MPR604L_Rec.PrHrT = '09') and (MPR604L_Rec.PrHrsQ <> 8);
         AddMessage('Floating Holiday 8 hours only':tsDate:false:true);
       endif;

       // ********************************
       // 19) Check to see if there is any time entered outside of the pay period
       chain ('BW') PR100AF PR101AP_Rec;
       ppBeginDate = %date(((PR101AP_Rec.prPpSY * 10000) + (PR101AP_Rec.prPpSM *
                           100) + PR101AP_Rec.prPpSD): *ymd);
       ppEndDate = %date(((PR101AP_Rec.prPpEY * 10000) + (PR101AP_Rec.prPpEM *
                           100) + PR101AP_Rec.prPpED): *ymd);
       tempDate = %date(((MPR604L_Rec.prDHdY * 10000) + (MPR604L_Rec.prDHdM *
                           100) + MPR604L_Rec.prDHdD): *ymd);
       if (tempDate < ppBeginDate OR tempDate > ppEndDate);
         AddMessage('Timesheet has time outside of pay period':
                    tsDate:true:false);
       endif;

       return;

      /end-free
     P ValidateTimesheet...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: ValidateHoursCode
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ValidateHoursCode...
     P                 B
     D ValidateHoursCode...
     D                 PI
     D  hoursCode                     2A
     D  hoursTotal                    7P 3

     D availableHours  S              9P 3

      /free

       // If hours type is an accrual, check if the employee has that accrual
       //  and the balance
       chain (hoursCode) PR021AP PR021AP_Rec;

       if (%found() and PR021AP_Rec.BPrAsHc = 'S');
         chain (%int(pSsn): PR021AP_Rec.BPrAtCd) PR541AF;
         if (not %found());
           AddMessage('No accrual ' + PR021AP_Rec.BPrAtCd + ' for ' +
                      %char(hoursTotal) + ' hours.':ZERO_DATE:false:true);
         else;
           availableHours = aPrAcBl + aPrCyAh + aPrAcPn;
           if availableHours < hoursTotal;
             AddMessage('Over acrrual balance for '+ %char(hoursTotal) +
                        'hours.':ZERO_DATE:true:false);
           endif;
         endif;
       endif;

       return;

      /end-free
     P ValidateHoursCode...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: ValidateEmployee
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ValidateEmployee...
     P                 B
     D ValidateEmployee...
     D                 PI

      /free

       // See if the employee still has their floating holiday
       if (Vacation8Hours and not floatingHoliday);
         chain (%int(pSsn): 'FH ': 'FH') PR541AF;
         if (%found() AND APRCYAH > 0);
           AddMessage('Still have Floating Holiday':ZERO_DATE:true:false);
         endif;
       endif;

       // Check to see if the employee signed AFTER the supervisor
       chain (%int(pSsn)) MPRTCSP MPRTCSP_Rec;
       if (%found());
         if (MPRTCSP_Rec.tcSuSd <> %date('0001-01-01'));
           if ((MPRTCSP_Rec.tcEmSd = MPRTCSP_Rec.tcSuSd) AND
               (MPRTCSP_Rec.tcEmSt > MPRTCSP_Rec.tcSuSt)) OR
               (MPRTCSP_Rec.tcEmSd > MPRTCSP_Rec.tcSuSd);
             AddMessage('Employee has signed after supervisor':
                        ZERO_DATE:true:false);
           endif;
         endif;
       endif;

       // Check if the timesheet has changed since the employee signed.
       monitor;
       if (totalHours <> MPRTCSP_Rec.tcTotH) and
          (tcEmSd <> %date('0001-01-01'));
         AddMessage('Hours do not match what was signed.':
                    ZERO_DATE:true:false);
       endif;
       on-error *all;
       endmon;

       return;

      /end-free
     P ValidateEmployee...
     P                 E


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

       ssnNum = %int(pSsn);

       exec sql
         declare c1 cursor for
           select *
             from mpr604l
             where prssn = :ssnnum
             order by prhrt, prdhdy, prdhdm, prdhdd;
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
         fetch c1 into :mpr604l_rec;
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