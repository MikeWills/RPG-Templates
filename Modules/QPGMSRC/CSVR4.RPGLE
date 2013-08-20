000100110629      * CSVR4 -- service program for working with Comma Separated
000102110629      *          Values (CSV) files, and other delimited files
000104110629      *
000106110629      *     To compile:
000108110629      *     - First, make sure the CSVR4.rpgle, CSV_H.rpgle, and
000110110629      *         BUFIO_H.rpgle files from the ZIP file have been
000112110629      *         uploaded to a QRPGLESRC in your library list.
000114110629      *     - Make sure the CSVR4.bnd file from the ZIP file has
000116110629      *         been uploaded to a QSRVSRC file in your library list.
000118110629      *     - Run the following commands:
000120110629      *>        CRTRPGMOD CSVR4 SRCFILE(*LIBL/QPGMSRC) DBGVIEW(*LIST)
000122110629      *>        CRTSRVPGM CSVR4 MODULE(CSVR4) EXPORT(*SRCFILE) -
000124110629      *>                  SRCFILE(*LIBL/QSRVSRC)
000126110629      *     - (First time only) run the following commands:
000128110629      *> ign:   CRTBNDDIR CSV
000130110629      *> ign:   ADDBNDDIRE CSV OBJ((*LIBL/CSVR4 *SRVPGM))
000132110629      *
000134110629     /*-                                                                            +
000136110629      * Copyright (c) 2008 Scott C. Klement                                         +
000138110629      * All rights reserved.                                                        +
000140110629      *                                                                             +
000142110629      * Redistribution and use in source and binary forms, with or without          +
000144110629      * modification, are permitted provided that the following conditions          +
000146110629      * are met:                                                                    +
000148110629      * 1. Redistributions of source code must retain the above copyright           +
000150110629      *    notice, this list of conditions and the following disclaimer.            +
000152110629      * 2. Redistributions in binary form must reproduce the above copyright        +
000154110629      *    notice, this list of conditions and the following disclaimer in the      +
000156110629      *    documentation and/or other materials provided with the distribution.     +
000158110629      *                                                                             +
000160110629      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
000162110629      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
000164110629      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
000166110629      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
000168110629      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
000170110629      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
000172110629      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
000174110629      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
000176110629      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
000178110629      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
000180110629      * SUCH DAMAGE.                                                                +
000182110629      *                                                                             +
000184110629      */                                                                            +
000186110629      *                                                                             +
000188110629     H NOMAIN OPTION(*SRCSTMT: *NOSHOWCPY) BNDDIR('QC2LE')
000190110629
000192110629      /copy modules/qpgmsrc,bufio_h
000194110629      /copy modules/qpgmsrc,csv_h
000197110629
000198110629     D VARPREF         C                   2
000200110629     D LINEFEED        C                   X'25'
000202110629     D CARRTN          C                   X'0D'
000204110629
000206110629     D CSVFILE_t       ds                  qualified
000208110629     D    fp                           *           inz(*NULL)
000210110629     D    buf                     65502A   varying inz('')
000212110629     D    bufpos                     10I 0         inz(0)
000214110629     D    flddel                      1A           inz(',')
000216110629     D    strdel1                     1A           inz('"')
000218110629     D    strdel2                     1A           inz('''')
000220110629
000222110629     D ReportError     PR
000224110629     D   peMsg                      256a   varying const
000226110629     D                                     options(*varsize:*nopass:*omit)
000228110629
000230110629
000232110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000234110629      * CSV_open(): open a delimited text file
000236110629      *
000238110629      *    peFilename = (input) IFS pathname to file to open
000240110629      *     peStrDel1 = (input/omit) String delimiter
000242110629      *                  if *OMIT, a double-quote character is used
000244110629      *     peStrDel2 = (input/omit) Secondary string delimiter
000246110629      *                  if *OMIT, a single-quote character is used
000248110629      *      peFldDel = (input/omit) Field delimiter
000250110629      *                  if *OMIT, a comma is used
000252110629      *
000254110629      * returns a CSV_HANDLE used to track the opened file
000256110629      *        or an *ESCAPE message upon error
000258110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000260110629     P CSV_open        B                   export
000262110629     D CSV_open        PI                  like(CSV_HANDLE)
000264110629     D   peFilename                5000A   varying const options(*varsize)
000266110629     D   peStrDel1                    1A   const options(*omit:*nopass)
000268110629     D   peStrDel2                    1A   const options(*omit:*nopass)
000270110629     D   peFldDel                     1A   const options(*omit:*nopass)
000272110629
000274110629     D myCSV           ds                  likeds(CSVFILE_t)
000276110629     D                                     inz(*LIKEDS)
000278110629     D CSV             ds                  likeds(CSVFILE_t)
000280110629     D                                     based(p_CSV)
000282110629
000284110629      /free
000286110629         if (%parms>=2 and %addr(peStrDel1)<>*NULL);
000288110629            myCSV.StrDel1 = peStrDel1;
000290110629         endif;
000292110629         if (%parms>=3 and %addr(peStrDel2)<>*NULL);
000294110629            myCSV.StrDel2 = peStrDel2;
000296110629         endif;
000298110629         if (%parms>=4 and %addr(peFldDel)<>*NULL);
000300110629            myCSV.FldDel = peFldDel;
000302110629         endif;
000304110629
000306110629         myCSV.fp = fopen(%trim(peFilename): 'r');
000308110629         if (myCSV.fp = *NULL);
000310110629            ReportError();
000312110629         endif;
000314110629
000316110629         myCSV.buf = '';
000318110629
000320110629         monitor;
000322110629            p_CSV = %alloc(%size(CSV));
000324110629         on-error;
000326110629            ReportError('Unable to allocate memory.');
000328110629         endmon;
000330110629
000332110629         CSV = myCSV;
000334110629         csv_rewindrec(p_CSV);
000336110629         return p_CSV;
000338110629      /end-free
000340110629     P                 E
000342110629
000343110629
000346110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000348110629      * CSV_loadrec(): Load a record from a delimited file into memory
000350110629      *
000352110629      *     peHandle = (i/o) handle to file returned by CSV_open()
000354110629      *
000356110629      * Returns *ON if successful, *OFF upon failure or EOF
000358110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000360110629     P CSV_loadrec     B                   export
000362110629     D CSV_loadrec     PI             1N
000364110629     D   peHandle                          like(CSV_HANDLE) value
000366110629
000368110629     D CSV             DS                  likeds(CSVFILE_t)
000370110629     D                                     based(peHandle)
000372110629
000374110629     D p_buf           s               *
000376110629     D len             s             10I 0
000378110629
000380110629      /free
000382110629
000384110629         %len(CSV.buf) = %size(CSV.buf) - VARPREF;
000386110629
000388110629         p_buf = fgets( %addr(CSV.buf) + VARPREF
000390110629                      : %size(CSV.buf) - VARPREF
000392110629                      : CSV.fp );
000394110629
000396110629         if (p_buf = *NULL);
000398110629            return *OFF;
000400110629         endif;
000402110629
000404110629         len = %len(%str(p_buf));
000406110629         %len(CSV.buf) = len;
000408110629
000410110629         if (%subst(CSV.buf : len : 1) = LINEFEED );
000412110629            len = len - 1;
000414110629            %len(CSV.buf) = len;
000416110629         endif;
000418110629
000420110629         if (%subst(CSV.buf : len : 1) = CARRTN );
000422110629            len = len - 1;
000424110629            %len(CSV.buf) = len;
000426110629         endif;
000428110629
000430110629         csv_rewindrec(peHandle);
000432110629
000434110629         return *ON;
000436110629      /end-free
000438110629     P                 E
000440110629
000442110629
000444110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000446110629      * CSV_rewindfile():  Move file cursor back to the start
000448110629      *                    (so you can re-read from the beginning)
000450110629      *
000452110629      *   peHandle = (i/o) handle to file returned by CSV_open
000454110629      *
000456110629      * Returns *ON if successful, *OFF otherwise.
000458110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000460110629     P CSV_rewindfile  B                   EXPORT
000462110629     D CSV_rewindfile  PI             1N
000464110629     D   peHandle                          like(CSV_HANDLE) value
000466110629
000468110629     D CSV             DS                  likeds(CSVFILE_t)
000470110629     D                                     based(peHandle)
000472110629      /free
000474110629         if fseek( CSV.fp: 0: 0 ) = -1;
000476110629            ReportError();
000478110629            return *OFF;
000480110629         else;
000482110629            csv_rewindrec(peHandle);
000484110629            return *ON;
000486110629         endif;
000488110629      /end-free
000490110629     P                 E
000492110629
000494110629
000496110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000498110629      * CSV_getfld(): Get the next field from a delimited file record
000500110629      *
000502110629      *  peHandle = (i/o)  handle to file opened by CSV_open()
000504110629      * peFldData = (output) data read from file
000506110629      * peVarSize = (input) size, in bytes, of the peFldData
000508110629      *                     variable that you passed (including
000510110629      *                     the two bytes for the length)
000512110629      *
000514110629      * Returns *ON if data was read, *OFF otherwise
000516110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000518110629     P CSV_getfld      B                   export
000520110629     D CSV_getfld      PI             1N
000522110629     D   peHandle                          like(CSV_HANDLE) value
000524110629     D   peFldData                65502A   varying options(*varsize)
000526110629     D   peVarSize                   10I 0 value
000528110629
000530110629     D UNQUOTED        C                   0
000532110629     D QUOTED          C                   1
000534110629     D ENDQUOTE        C                   2
000536110629
000538110629     D CSV             DS                  likeds(CSVFILE_t)
000540110629     D                                     based(peHandle)
000542110629
000544110629     D state           s             10i 0 inz(UNQUOTED)
000546110629     D max             s             10I 0
000548110629     D len             s             10I 0
000550110629     D start           s             10I 0
000552110629     D pos             s             10I 0
000554110629     D char            s              1A   based(p_char)
000556110629     D qchar           s              1A
000558110629
000560110629      /free
000562110629
000564110629         max = peVarSize - VARPREF;
000566110629         len = %len(CSV.buf) - 1;
000568110629         start = CSV.bufpos;
000570110629         %len(peFldData) = 0;
000572110629
000574110629         if (start > len);
000576110629             return *OFF;
000578110629         endif;
000580110629
000582110629         for pos = start to len;
000584110629
000586110629             p_char = %addr(CSV.buf) + VARPREF + pos;
000588110629
000590110629             select;
000592110629             when state = UNQUOTED;
000594110629
000596110629                select;
000598110629                when char = CSV.flddel;
000600110629                   leave;
000602110629                when char = CSV.strdel1
000604110629                  or char = CSV.strDel2;
000606110629                   state = QUOTED;
000608110629                   qchar = char;
000610110629                when %len(peFldData) < max;
000612110629                   peFldData += char;
000614110629                endsl;
000616110629
000618110629             when state = QUOTED;
000620110629
000622110629                 select;
000624110629                 when char = qchar;
000626110629                    state = ENDQUOTE;
000628110629                 when %len(peFldData) < max;
000630110629                    peFldData += char;
000632110629                 endsl;
000634110629
000636110629             when state = ENDQUOTE;
000638110629
000640110629                select;
000642110629                when char = qchar;
000644110629                    state = QUOTED;
000646110629                    if (%len(peFldData) < max);
000648110629                       peFldData += char;
000650110629                    endif;
000652110629                when char = CSV.flddel;
000654110629                    leave;
000656110629                when char = CSV.strdel1
000658110629                  or char = CSV.strDel2;
000660110629                    state = QUOTED;
000662110629                    qchar = char;
000664110629                when %len(peFldData) < max;
000666110629                    state = UNQUOTED;
000668110629                    peFldData += char;
000670110629                endsl;
000672110629
000674110629             endsl;
000676110629
000678110629         endfor;
000680110629
000682110629         CSV.bufpos = pos + 1;
000684110629         return *ON;
000686110629      /end-free
000688110629     P                 E
000690110629
000692110629
000694110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000696110629      * CSV_rewindrec():  Move field cursor back to the start
000698110629      *                  (so you can re-read fields from this record)
000700110629      *
000702110629      *   peHandle = (i/o) handle to file returned by CSV_open
000704110629      *
000706110629      * Returns *ON if successful, *OFF otherwise.
000708110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000710110629     P CSV_rewindrec   B                   EXPORT
000712110629     D CSV_rewindrec   PI             1N
000714110629     D   peHandle                          like(CSV_HANDLE) value
000716110629
000718110629     D CSV             DS                  likeds(CSVFILE_t)
000720110629     D                                     based(peHandle)
000722110629      /free
000724110629         CSV.bufpos = 0;
000726110629         return *ON;
000728110629      /end-free
000730110629     P                 E
000732110629
000734110629
000736110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000738110629      * CSV_close(): Close Delimited File
000740110629      *
000742110629      *  peHandle = (i/o) handle to file opened by CSV_open()
000744110629      *                   this is set to *NULL if when file is
000746110629      *                   closed successfully.
000748110629      *
000750110629      * Returns an *ESCAPE message upon failure
000752110629      *         otherwise, returns nothing.
000754110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000756110629     P CSV_close       B                   export
000758110629     D CSV_close       PI
000760110629     D   peHandle                          like(CSV_HANDLE)
000762110629     D CSV             DS                  likeds(CSVFILE_t)
000764110629     D                                     based(p_CSV)
000766110629
000768110629      /free
000770110629
000772110629         p_CSV = peHandle;
000774110629         if (fclose(CSV.fp) <> 0);
000776110629            ReportError();
000778110629         endif;
000780110629         dealloc p_CSV;
000782110629         peHandle = *null;
000784110629
000786110629      /end-free
000788110629     P                 E
000790110629
000792110629
000794110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000796110629      * ReportError():  Send an escape message explaining any errors
000798110629      *                 that occurred.
000800110629      *
000802110629      *    peMsg = (input/optional) if passed, this message will
000804110629      *                 be sent as CPF9897 to calling application.
000806110629      *                 if not passed, CPExxxx will be sent, where
000808110629      *                 xxxx is the ILE C errno value.
000810110629      *
000812110629      * Calling this subproc terminates the service program.
000814110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000816110629     P ReportError     B
000818110629     D ReportError     PI
000820110629     D   peMsg                      256a   varying const
000822110629     D                                     options(*varsize:*nopass:*omit)
000824110629
000826110629     D my_errno_func   PR              *   ExtProc('__errno')
000828110629     D my_errno        s             10I 0 based(p_my_errno)
000830110629
000832110629     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
000834110629     D   MessageID                    7A   Const
000836110629     D   QualMsgF                    20A   Const
000838110629     D   MsgData                  32767A   Const options(*varsize)
000840110629     D   MsgDtaLen                   10I 0 Const
000842110629     D   MsgType                     10A   Const
000844110629     D   CallStkEnt                  10A   Const
000846110629     D   CallStkCnt                  10I 0 Const
000848110629     D   MessageKey                   4A
000850110629     D   ErrorCode                32767A   options(*varsize)
000852110629
000854110629     D ErrorCode       DS                  qualified
000856110629     D  BytesProv                    10I 0 inz(0)
000858110629     D  BytesAvail                   10I 0 inz(0)
000860110629
000862110629     D MsgKey          S              4A
000864110629     D MsgID           s              7A
000866110629     D MsgDta          s            256a   varying
000868110629
000870110629      /free
000872110629
000874110629         if  %parms>=1 and %addr(peMsg)<>*null;
000876110629            MsgId = 'CPF9897';
000878110629            MsgDta = peMsg;
000880110629         else;
000882110629            p_my_errno = my_errno_func();
000884110629            MsgID = 'CPE' + %editc( %dec(my_errno:4:0) : 'X' );
000886110629            %len(MsgDta) = 0;
000888110629         endif;
000890110629
000892110629         QMHSNDPM( MsgID
000894110629                 : 'QCPFMSG   *LIBL'
000896110629                 : MsgDta
000898110629                 : %len(MsgDta)
000900110629                 : '*ESCAPE'
000902110629                 : '*PGMBDY'
000904110629                 : 1
000906110629                 : MsgKey
000908110629                 : ErrorCode         );
000910110629
000912110629      /end-free
000914110629     P                 E
000916110629
