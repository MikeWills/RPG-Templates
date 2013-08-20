000100110629      * Generic CSV file dumper.  This program is primarily intended
000102110629      * for testing that CSVR4 is working correctly.  It reads a CSV
000104110629      * file and dumps each field to a spooled file.
000106110629      *                              Scott Klement, November 25, 2008
000108110629      *
000110110629      *  To compile:
000112110629      *    - ensure that you have already build CSVR4
000114110629      *    - then compile with:
000116110629      *>      CRTBNDRPG CSVTEST DBGVIEW(*LIST)
000118110629      *
000120110629     H DFTACTGRP(*NO) ACTGRP('KLEMENT') BNDDIR('CSV')
000122110629
000124110629     FQSYSPRT   O    F  132        PRINTER
000126110629
000128110629      /copy modules/qpgmsrc,CSV_H
000130110629
000132110629     D csvfile         s                   like(CSV_HANDLE)
000134110629     D rec             s             10i 0
000136110629     D fc              s             10i 0
000138110629     D fld             s            132a   varying
000140110629     D prt             ds           132
000142110629
000144110629      /free
000146110629
000148110629          csvfile = csv_open('/home/klemscot/testme.csv');
000150110629          rec = 0;
000152110629
000154110629          dow csv_loadrec(csvfile);
000156110629
000158110629              rec += 1;
000160110629              prt = '-------- RECORD ' + %char(rec) + ' --------';
000162110629              write QSYSPRT prt;
000164110629              fc = 0;
000166110629
000168110629              dow csv_getfld(csvfile: fld: %size(fld));
000170110629                 fc += 1;
000172110629                 prt = %char(fc) + ': ' + fld;
000174110629                 write QSYSPRT prt;
000176110629              enddo;
000178110629
000180110629          enddo;
000182110629
000184110629          csv_close(csvfile);
000186110629          *inlr = *on;
000188110629
000190110629      /end-free
000192110629
