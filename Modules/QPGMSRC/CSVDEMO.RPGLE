000100110629      * Demonstration of Reading a CSV file and generating
000102110629      * a sample report.
000104110629      *                 Scott Klement, November 25, 2008
000106110629      *
000108110629      * To compile:
000110110629      *  - Ensure that you have already built CSVR4. See
000112110629      *      the CSVR4 member for details.
000114110629      *  - Run the following command:
000116110629      *>     CRTBNDRPG CSVDEMO SRCFILE(QPGMSRC) DBGVIEW(*LIST)
000118110629      *
000120110629      *
000122110629      * NOTE: This program expects a CSV file named
000124110629      *       /home/klemscot/addrtest.csv to be found
000126110629      *       in the IFS.  That file should be formatted
000128110629      *       with four fields, an account number, name
000130110629      *       address, city and state.  Here's an example
000132110629      *       of a record that you might place in that file:
000134110629      *
000136110629      *       1001,"Scott Klement","123 Sesame St","Milwaukee","WI"
000138110629      *
000140110629     H DFTACTGRP(*NO) ACTGRP('KLEMENT') BNDDIR('CSV')
000142110629
000144110629     FQSYSPRT   O    F  132        PRINTER oflind(Overflow)
000146110629
000148110629      /copy modules/qpgmsrc,CSV_H
000150110629
000152110629     D acct            s              4s 0
000154110629     D temp            s              4a   varying
000156110629     D name            s             30a   varying
000158110629     D addr            s             30a   varying
000160110629     D city            s             15a   varying
000162110629     D state           s              2a   varying
000164110629
000166110629     D csvfile         s                   like(CSV_HANDLE)
000168110629     D fc              s             10i 0
000170110629     D fld             s            132a   varying
000172110629     D prt             ds           132
000174110629
000176110629      /free
000178110629
000180110629          csvfile = csv_open('/home/klemscot/addrtest.csv');
000182110629          except heading;
000184110629
000186110629          dow csv_loadrec(csvfile);
000188110629
000190110629             CSV_getfld(csvfile: temp:  %size(temp));
000192110629             CSV_getfld(csvfile: name:  %size(name));
000194110629             CSV_getfld(csvfile: addr:  %size(addr));
000196110629             CSV_getfld(csvfile: city:  %size(city));
000198110629             CSV_getfld(csvfile: state: %size(state));
000200110629             acct = %dec( temp: 4: 0);
000202110629
000204110629             if (OverFlow);
000206110629                except heading;
000208110629                Overflow = *OFF;
000210110629             endif;
000212110629
000214110629             except rec;
000216110629
000218110629          enddo;
000220110629
000222110629          csv_close(csvfile);
000224110629          *inlr = *on;
000226110629
000228110629      /end-free
000230110629
000232110629     OQSYSPRT   E            heading        1  3
000234110629     O                                           +0 'Acct'
000236110629     O                                           +2 'Name           '
000238110629     O                                           +0 '               '
000240110629     O                                           +2 'Street Address '
000242110629     O                                           +0 '               '
000244110629     O                                           +2 'City           '
000246110629     O                                           +2 'St'
000248110629     O          E            heading        1
000250110629     O                                           +0 '----'
000252110629     O                                           +2 '---------------'
000254110629     O                                           +0 '---------------'
000256110629     O                                           +2 '---------------'
000258110629     O                                           +0 '---------------'
000260110629     O                                           +2 '---------------'
000262110629     O                                           +2 '--'
000264110629     O          E            rec            1
000266110629     O                       acct                +0
000268110629     O                       name                +2
000270110629     O                       addr                +2
000272110629     O                       city                +2
000274110629     O                       state               +2
000276110629
