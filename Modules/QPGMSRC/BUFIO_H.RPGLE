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
000152110629      /if defined(STDIO_H)
000154110629      /eof
000156110629      /endif
000158110629      /define STDIO_H
000161110629
000162110629      *-----------------------------------------------------------------
000164110629      * Data types
000166110629      *-----------------------------------------------------------------
000168110629     D pFILE           S               *   based(prototype_only)
000171110629
000172110629      *-----------------------------------------------------------------
000174110629      * fopen():  Open File for buffered reading/writing
000176110629      *
000178110629      *   filename = (input) path to file in the IFS
000180110629      *       mode = (input) various open mode flags.  (see manual)
000182110629      *
000184110629      *  returns *NULL upon error, or a pointer to a FILE structure
000186110629      *-----------------------------------------------------------------
000188110629     D fopen           PR                  ExtProc('_C_IFS_fopen')
000190110629     D                                     like(pFILE)
000192110629     D   filename                      *   value options(*string)
000194110629     D   mode                          *   value options(*string)
000199110629
000200110629      *-----------------------------------------------------------------
000202110629      * fgets(): read a string
000204110629      *
000206110629      *    string = (output) string read (null-terminated)
000208110629      *      size = (input) maximum size that can be stored in string
000210110629      *    stream = (input) FILE structure to read data from
000212110629      *
000214110629      * returns a pointer to the string read from the file
000216110629      *      or *NULL upon EOF or error.
000218110629      *-----------------------------------------------------------------
000220110629     D fgets           PR              *   ExtProc('_C_IFS_fgets')
000222110629     D   string                        *   value
000224110629     D   size                        10I 0 value
000226110629     D   stream                            like(pFILE) value
000229110629
000230110629      *-----------------------------------------------------------------
000232110629      * fputs(): Write string
000234110629      *
000236110629      *    string = (input) string to write to file
000238110629      *    stream = (input) FILE structure designating the file to
000240110629      *                write to.
000242110629      *
000244110629      *  returns a non-negative value if successful
000246110629      *       or -1 upon error
000248110629      *-----------------------------------------------------------------
000250110629     D fputs           PR            10I 0 ExtProc('_C_IFS_fputs')
000252110629     D   string                        *   value options(*string)
000254110629     D   stream                            like(pFILE) value
000257110629
000258110629      *-----------------------------------------------------------------
000260110629      * fread(): Read items
000262110629      *
000264110629      *    data = (input) data items to read
000266110629      *    size = (input) size of each data item
000268110629      *   count = (input) number of data items
000270110629      *  stream = (input) pointer to FILE structure to read from
000272110629      *
000274110629      * returns the number of full items read, a short count
000276110629      *         indicates an error.
000278110629      *-----------------------------------------------------------------
000280110629     D fread           PR            10U 0 ExtProc('_C_IFS_fread')
000282110629     D   data                          *   value
000284110629     D   size                        10U 0 value
000286110629     D   count                       10U 0 value
000288110629     D   stream                            like(pFILE) value
000291110629
000292110629      *-----------------------------------------------------------------
000294110629      * fwrite(): Write items
000296110629      *
000298110629      *    data = (input) data items to write
000300110629      *    size = (input) size of each data item
000302110629      *   count = (input) number of data items
000304110629      *  stream = (input) pointer to FILE structure to write to
000306110629      *
000308110629      * returns the number of full items written.  A short count
000310110629      *         indicates an error.
000312110629      *-----------------------------------------------------------------
000314110629     D fwrite          PR            10U 0 ExtProc('_C_IFS_fwrite')
000316110629     D   data                          *   value
000318110629     D   size                        10U 0 value
000320110629     D   count                       10U 0 value
000322110629     D   stream                            like(pFILE) value
000325110629
000326110629      *-----------------------------------------------------------------
000328110629      * fflush():  Flush a stream
000330110629      *
000332110629      *    stream = (input) pointer to FILE structure to flush
000334110629      *
000336110629      * returns 0 if successful, -1 otherwise
000338110629      *-----------------------------------------------------------------
000340110629     D fflush          PR            10U 0 ExtProc('_C_IFS_fflush')
000342110629     D   stream                            like(pFILE) value
000345110629
000346110629      *-----------------------------------------------------------------
000348110629      * fclose(): Close File
000350110629      *
000352110629      *    stream = (input) pointer to FILE structure to close
000354110629      *-----------------------------------------------------------------
000356110629     D fclose          PR            10I 0 ExtProc('_C_IFS_fclose')
000358110629     D   stream                            like(pFILE) value
000360110629
000362110629      *-----------------------------------------------------------------
000364110629      * fseek(): Reposition a file
000366110629      *
000368110629      *    stream = (input) pointer to FILE structure to reposition
000370110629      *    offset = (input) offset from "whence" in bytes
000372110629      *    whence = (input) position to begin offset at, can be
000374110629      *                SEEK_SET, SEEK_END or SEEK_CUR
000376110629      *
000378110629      * returns 0 if successful, -1 otherwise
000380110629      *-----------------------------------------------------------------
000382110629     D fseek           PR            10I 0 ExtProc('_C_IFS_fseek')
000384110629     D   stream                            like(pFILE) value
000386110629     D   offset                      10I 0 value
000388110629     D   whence                      10I 0 value
000390110629
000392110629      *-----------------------------------------------------------------
000394110629      * ftell(): Get Current position
000396110629      *
000398110629      *    stream = (input) pointer to FILE structure
000400110629      *
000402110629      * returns the file position, or -1 upon error
000404110629      *-----------------------------------------------------------------
000406110629     D ftell           PR            10I 0 ExtProc('_C_IFS_ftell')
000408110629     D   stream                            like(pFILE) value
000410110629
000412110629      *-----------------------------------------------------------------
000414110629      * fdopen():  Upgrade a file descriptor to a buffered stream
000416110629      *
000418110629      *      fildes = (input) file descriptor to upgrade
000420110629      *        mode = (input) mode, equivalent to the mode specified
000422110629      *                   on the fopen() API, except that it must be
000424110629      *                   compatible with the flags that were used on
000426110629      *                   the open() API.
000428110629      *
000430110629      *  Returns a new pointer to a buffered stream I/O file
000432110629      *       or *NULL upon error.
000434110629      *-----------------------------------------------------------------
000436110629     D fdopen          pr              *   extproc('fdopen')
000438110629     D   fildes                      10I 0 value
000440110629     D   mode                          *   value options(*string)
000442110629
