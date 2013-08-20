000100110629     /*-                                                                            +
000102110629      * Copyright (c) 2008 Scott C. Klement                                         +
000104110629      * All rights reserved.                                                        +
000106110629      *                                                                             +
000108110629      * Redistribution and use in source and binary forms, with or without          +
000110110629      * modification, are permitted provided that the following conditions          +
000112110629      * are met:                                                                    +
000114110629      * 1. Redistributions of source code must retain the above copyright           +
000116110629      *    notice, this list of conditions and the following disclaimer.            +
000118110629      * 2. Redistributions in binary form must reproduce the above copyright        +
000120110629      *    notice, this list of conditions and the following disclaimer in the      +
000122110629      *    documentation and/or other materials provided with the distribution.     +
000124110629      *                                                                             +
000126110629      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
000128110629      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
000130110629      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
000132110629      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
000134110629      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
000136110629      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
000138110629      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
000140110629      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
000142110629      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
000144110629      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
000146110629      * SUCH DAMAGE.                                                                +
000148110629      *                                                                             +
000150110629      */                                                                            +
000152110629      /if defined(CSV_H_DEFINED)
000154110629      /eof
000156110629      /endif
000158110629      /define CSV_H_DEFINED
000160110629
000162110629     D CSV_HANDLE      S               *   based(TEMPLATE)
000164110629
000166110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000168110629      * CSV_open(): open a delimited text file
000170110629      *
000172110629      *    peFilename = (input) IFS pathname to file to open
000174110629      *      peStrDel = (input/omit) String delimiter
000176110629      *                  if *OMIT, a double-quote character is used
000178110629      *      peFldDel = (input/omit) Field delimiter
000180110629      *                  if *OMIT, a comma is used
000182110629      *
000184110629      * returns a CSV_HANDLE used to track the opened file
000186110629      *        or an *ESCAPE message upon error
000188110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000190110629     D CSV_open        PR                  like(CSV_HANDLE)
000192110629     D   peFilename                5000A   varying const options(*varsize)
000194110629     D   peStrDel1                    1A   const options(*omit:*nopass)
000196110629     D   peStrDel2                    1A   const options(*omit:*nopass)
000198110629     D   peFldDel                     1A   const options(*omit:*nopass)
000200110629
000204110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000206110629      * CSV_loadrec(): Load a record from a delimited file into memory
000208110629      *
000210110629      *     peHandle = (i/o) handle to file returned by CSV_open()
000212110629      *
000214110629      * Returns *ON if successful, *OFF upon failure or EOF
000216110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000218110629     D CSV_loadrec     PR             1N   extproc(*CL:'CSV_LOADREC')
000220110629     D   peHandle                          like(CSV_HANDLE) value
000224110629
000226110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000228110629      * CSV_rewindfile():  Move file cursor back to the start
000230110629      *                    (so you can re-read from the beginning)
000232110629      *
000234110629      *   peHandle = (i/o) handle to file returned by CSV_open
000236110629      *
000238110629      * Returns *ON if successful, *OFF otherwise.
000240110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000242110629     D CSV_rewindfile  PR             1N   extproc(*CL:'CSV_REWINDFILE')
000244110629     D   peHandle                          like(CSV_HANDLE) value
000246110629
000250110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000252110629      * CSV_rewindrec():  Move field cursor back to the start
000254110629      *                  (so you can re-read fields from this record)
000256110629      *
000258110629      *   peHandle = (i/o) handle to file returned by CSV_open
000260110629      *
000262110629      * Returns *ON if successful, *OFF otherwise.
000264110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000266110629     D CSV_rewindrec   PR             1N   extproc(*CL:'CSV_REWINDREC')
000268110629     D   peHandle                          like(CSV_HANDLE) value
000270110629
000274110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000276110629      * CSV_getfld(): Get the next field from a delimited file record
000278110629      *
000280110629      *  peHandle = (i/o)  handle to file opened by CSV_open()
000282110629      * peFldData = (output) data read from file
000284110629      * peVarSize = (input) size, in bytes, of the peFldData
000286110629      *                     variable that you passed (including
000288110629      *                     the two bytes for the length)
000290110629      *
000292110629      * Returns *ON if data was read, *OFF otherwise
000294110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000296110629     D CSV_getfld      PR             1N   extproc(*CL:'CSV_GETFLD')
000298110629     D   peHandle                          like(CSV_HANDLE) value
000300110629     D   peFldData                65502A   varying options(*varsize)
000302110629     D   peVarSize                   10I 0 value
000304110629
000308110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000310110629      * CSV_close(): Close Delimited File
000312110629      *
000314110629      *  peHandle = (i/o) handle to file opened by CSV_open()
000316110629      *                   this is set to *NULL if when file is
000318110629      *                   closed successfully.
000320110629      *
000322110629      * Returns an *ESCAPE message upon failure
000324110629      *         otherwise, returns nothing.
000326110629      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
000328110629     D CSV_close       PR
000330110629     D   peHandle                          like(CSV_HANDLE)
000332110629
