002900020617      ** ERRNO_H --  Header file for working with C-Runtime and
003000020617      **     UNIX-Type API error handling routines.
003100020617      **                                               SCK 04/25/01
003200020617      **
003300020617      **  To use this:
003400020617      **       1)  put a /COPY ERRNO_H in the D-specs of your program.
003500020617      **       2)  put a "/define ERRNO_LOAD_PROCEDURE", followed by a
003600020617      **               2nd "/COPY ERRNO_H" somewhere that procedures
003700020617      **               are allowed to be defined :)
003800020617      **       3)  bind to the QC2LE binding directory.
003900020617      **
004000020617      **
004100020617      /if not defined(ERRNO_LOAD_PROCEDURE)
004200020617
004300020617      *-------------------------------------------------------------------
004400020617      * error constant definitions
004500020617      *-------------------------------------------------------------------
004600020617
004700020617      * these values come originally from file QCLE/H member ERRNO
004800020617
004900020617      * domain error in math function
005000020617     D EDOM            C                   3001
005100020617      * range error in math function
005200020617     D ERANGE          C                   3002
005300020617      * truncation on I/O operation
005400020617     D ETRUNC          C                   3003
005500020617      * file has not been opened
005600020617     D ENOTOPEN        C                   3004
005700020617      * file not opened for read
005800020617     D ENOTREAD        C                   3005
005900020617      * file opened for record I/O
006000020617     D ERECIO          C                   3008
006100020617      * file not opened for write
006200020617     D ENOTWRITE       C                   3009
006300020617      * stdin cannot be opened
006400020617     D ESTDIN          C                   3010
006500020617      * stdout cannot be opened
006600020617     D ESTDOUT         C                   3011
006700020617      * stderr cannot be opened
006800020617     D ESTDERR         C                   3012
006900020617      * bad offset to seek to
007000020617     D EBADSEEK        C                   3013
007100020617      * invalid file name specified
007200020617     D EBADNAME        C                   3014
007300020617      * invalid file mode specified
007400020617     D EBADMODE        C                   3015
007500020617      * invalid position specifier
007600020617     D EBADPOS         C                   3017
007700020617      * no record at specified position
007800020617     D ENOPOS          C                   3018
007900020617      * no ftell if more than 1 member
008000020617     D ENUMMBRS        C                   3019
008100020617      * no ftell if too many records
008200020617     D ENUMRECS        C                   3020
008300020617      * invalid function pointer
008400020617     D EBADFUNC        C                   3022
008500020617      * record not found
008600020617     D ENOREC          C                   3026
008700020617      * message data invalid
008800020617     D EBADDATA        C                   3028
008900020617      * bad option on I/O function
009000020617     D EBADOPT         C                   3040
009100020617      * file not opened for update
009200020617     D ENOTUPD         C                   3041
009300020617      * file not opened for delete
009400020617     D ENOTDLT         C                   3042
009500020617      * padding occurred on write operation
009600020617     D EPAD            C                   3043
009700020617      * bad key length option
009800020617     D EBADKEYLN       C                   3044
009900020617      * illegal write after read
010000020617     D EPUTANDGET      C                   3080
010100020617      * illegal read after write
010200020617     D EGETANDPUT      C                   3081
010300020617      * I/O exception non-recoverable error
010400020617     D EIOERROR        C                   3101
010500020617      * I/O exception recoverable error
010600020617     D EIORECERR       C                   3102
010700020617
010800020617      * The following were taken from QSYSINC/SYS ERRNO:
010900020617
011000020617      *  Permission denied.
011100020617     D EACCES          C                   3401
011200020617      *  Not a directory.
011300020617     D ENOTDIR         C                   3403
011400020617      *  No space available.
011500020617     D ENOSPC          C                   3404
011600020617      *  Improper link.
011700020617     D EXDEV           C                   3405
011800020617      *  Operation would have caused the process
011900020617     D EWOULDBLOCK     C                   3406
012000020617      *  Operation would have caused the process
012100020617     D EAGAIN          C                   3406
012200020617      *  Interrupted function call.
012300020617     D EINTR           C                   3407
012400020617      *  The address used for an argument was no
012500020617     D EFAULT          C                   3408
012600020617      *  Operation timed out
012700020617     D ETIME           C                   3409
012800020617      *  No such device or address
012900020617     D ENXIO           C                   3415
013000020617      *  Socket closed
013100020617     D ECLOSED         C                   3417
013200020617      *  Address already in use.
013300020617     D EADDRINUSE      C                   3420
013400020617      *  Address not available.
013500020617     D EADDRNOTAVAIL   C                   3421
013600020617      *  The type of socket is not supported in
013700020617     D EAFNOSUPPORT    C                   3422
013800020617      *  Operation already in progress.
013900020617     D EALREADY        C                   3423
014000020617      *  Connection ended abnormally.
014100020617     D ECONNABORTED    C                   3424
014200020617      *  A remote host refused an attempted conn
014300020617     D ECONNREFUSED    C                   3425
014400020617      *  A connection with a remote socket was r
014500020617     D ECONNRESET      C                   3426
014600020617      *  Operation requires destination address.
014700020617     D EDESTADDRREQ    C                   3427
014800020617      *  A remote host is not available.
014900020617     D EHOSTDOWN       C                   3428
015000020617      *  A route to the remote host is not avail
015100020617     D EHOSTUNREACH    C                   3429
015200020617      *  Operation in progress.
015300020617     D EINPROGRESS     C                   3430
015400020617      *  A connection has already been establish
015500020617     D EISCONN         C                   3431
015600020617      *  Message size out of range.
015700020617     D EMSGSIZE        C                   3432
015800020617      *  The network is not currently available.
015900020617     D ENETDOWN        C                   3433
016000020617      *  A socket is connected to a host that is
016100020617     D ENETRESET       C                   3434
016200020617      *  Cannot reach the destination network.
016300020617     D ENETUNREACH     C                   3435
016400020617      *  There is not enough buffer space for th
016500020617     D ENOBUFS         C                   3436
016600020617      *  The protocol does not support the speci
016700020617     D ENOPROTOOPT     C                   3437
016800020617      *  Requested operation requires a connecti
016900020617     D ENOTCONN        C                   3438
017000020617      *  The specified descriptor does not refer
017100020617     D ENOTSOCK        C                   3439
017200020617      *  Operation not supported.
017300020617     D ENOTSUP         C                   3440
017400020617      *  Operation not supported.
017500020617     D EOPNOTSUPP      C                   3440
017600020617      *  The socket protocol family is not suppo
017700020617     D EPFNOSUPPORT    C                   3441
017800020617      *  No protocol of the specified type and d
017900020617     D EPROTONO...
018000020617     DSUPPORT          C                   3442
018100020617      *  The socket type or protocols are not co
018200020617     D EPROTOTYPE      C                   3443
018300020617      *  An error indication was sent by the pee
018400020617     D ERCVDERR        C                   3444
018500020617      *  Cannot send data after a shutdown.
018600020617     D ESHUTDOWN       C                   3445
018700020617      *  The specified socket type is not suppor
018800020617     D ESOCKTNO...
018900020617     D SUPPORT         C                   3446
019000020617      *  A remote host did not respond within th
019100020617     D ETIMEDOUT       C                   3447
019200020617      *  The protocol required to support the sp
019300020617     D EUNATCH         C                   3448
019400020617      *  Descriptor not valid.
019500020617     D EBADF           C                   3450
019600020617      *  Too many open files for this process.
019700020617     D EMFILE          C                   3452
019800020617      *  Too many open files in the system.
019900020617     D ENFILE          C                   3453
020000020617      *  Broken pipe.
020100020617     D EPIPE           C                   3455
020200020617      *  File exists.
020300020617     D EEXIST          C                   3457
020400020617      *  Resource deadlock avoided.
020500020617     D EDEADLK         C                   3459
020600020617      *  Storage allocation request failed.
020700020617     D ENOMEM          C                   3460
020800020617      *  The synchronization object no longer ex
020900020617     D EOWNERTERM      C                   3462
021000020617      * The synchronization object was destroyed
021100020617     D EDESTROYED      C                   3463
021200020617      *  Operation terminated.
021300020617     D ETERM           C                   3464
021400020617      *  Maximum link count for a file was excee
021500020617     D EMLINK          C                   3468
021600020617      *  Seek request not supported for object.
021700020617     D ESPIPE          C                   3469
021800020617      *  Function not implemented.
021900020617     D ENOSYS          C                   3470
022000020617      *  Specified target is a directory.
022100020617     D EISDIR          C                   3471
022200020617      *  Read-only file system.
022300020617     D EROFS           C                   3472
022400020617      *  Unknown system state.
022500020617     D EUNKNOWN        C                   3474
022600020617      *  Iterator is invalid.
022700020617     D EITERBAD        C                   3475
022800020617      *  A damaged object was encountered.
022900020617     D EDAMAGE         C                   3484
023000020617      *  A loop exists in the symbolic links.
023100020617     D ELOOP           C                   3485
023200020617      *  A path name is too long.
023300020617     D ENAMETOOLONG    C                   3486
023400020617      *  No locks available
023500020617     D ENOLCK          C                   3487
023600020617      *  Directory not empty.
023700020617     D ENOTEMPTY       C                   3488
023800020617      *  System resources not available to compl
023900020617     D ENOSYSRSC       C                   3489
024000020617      *  Conversion error.
024100020617     D ECONVERT        C                   3490
024200020617      *  Argument list too long.
024300020617     D E2BIG           C                   3491
024400020617      *  Conversion stopped due to input charact
024500020617     D EILSEQ          C                   3492
024600020617      * Object has soft damage.
024700020617     D ESOFTDAMAGE     C                   3497
024800020617      *  User not enrolled in system distributio
024900020617     D ENOTENROLL      C                   3498
025000020617      *  Object is suspended.
025100020617     D EOFFLINE        C                   3499
025200020617      * Object is a read only object.
025300020617     D EROOBJ          C                   3500
025400020617      * Area being read from or written to is lo
025500020617     D ELOCKED         C                   3506
025600020617      * Object too large.
025700020617     D EFBIG           C                   3507
025800020617      * The semaphore, shared memory, or message
025900020617     D EIDRM           C                   3509
026000020617      * The queue does not contain a message of
026100020617     D ENOMSG          C                   3510
026200020617      * File ID conversion of a directory failed
026300020617     D EFILECVT        C                   3511
026400020617      * A File ID could not be assigned when lin
026500020617     D EBADFID         C                   3512
026600020617      * A File ID could not be assigned when lin
026700020617     D ESTALE          C                   3513
026800020617      * No such process.
026900020617     D ESRCH           C                   3515
027000020617      * Process not enabled for signals.
027100020617     D ENOTSIGINIT     C                   3516
027200020617      * No child process.
027300020617     D ECHILD          C                   3517
027400020617      * The operation would have exceeded the ma
027500020617     D ETOOMANYREFS    C                   3523
027600020617      * Function not allowed.
027700020617     D ENOTSAFE        C                   3524
027800020617      * Object is too large to process.
027900020617     D EOVERFLOW       C                   3525
028000020617      * Journal damaged.
028100020617     D EJRNDAMAGE      C                   3526
028200020617      * Journal inactive.
028300020617     D EJRNINACTIVE    C                   3527
028400020617      * Journal space or system storage error.
028500020617     D EJRNRCVSPC      C                   3528
028600020617      * Journal is remote.
028700020617     D EJRNRMT         C                   3529
028800020617      * New journal receiver is needed.
028900020617     D ENEWJRNRCV      C                   3530
029000020617      * New journal is needed.
029100020617     D ENEWJRN         C                   3531
029200020617      * Object already journaled.
029300020617     D EJOURNALED      C                   3532
029400020617      * Entry too large to send.
029500020617     D EJRNENTTOOLONG  C                   3533
029600020617      * Object is a Datalink object.
029700020617     D EDATALINK       C                   3534
029800020617
029900020617      * The following values are defined by POSIX ISO/IEC 9945-1:1990
030000020617      *  (these were also taken from QCLE/H member ERRNO)
030100020617
030200020617      * invalid argument
030300020617     D EINVAL          C                   3021
030400020617      * input/output error
030500020617     D EIO             C                   3006
030600020617      * no such device
030700020617     D ENODEV          C                   3007
030800020617      * resource busy
030900020617     D EBUSY           C                   3029
031000020617      * no such file or library
031100020617     D ENOENT          C                   3025
031200020617      * operation not permitted
031300020617     D EPERM           C                   3027
031400020617
031500020617      *-------------------------------------------------------------------
031600020617      * prototype definitions
031700020617      *-------------------------------------------------------------------
031800020617     D @__errno        PR              *   ExtProc('__errno')
031900020617
032000020617     D strerror        PR              *   ExtProc('strerror')
032100020617     D    errnum                     10I 0 value
032200020617
032300020617     D perror          PR                  ExtProc('perror')
032400020617     D    comment                      *   value options(*string)
032500020617
032700020617     D errno           PR            10I 0
032800020617
033000020617     D die             PR             1N
033100020617     D    msg                       256A   const
033200020709
033300020709     D escerrno        PR             1N
033400020709     D    errnum                     10I 0 value
033500020617      /endif
033600020617
033700020617      *-------------------------------------------------------------------
033800020617      * procedure definitions:
033900020617      *-------------------------------------------------------------------
034000020617      /if defined(ERRNO_LOAD_PROCEDURE)
034100020709      ** Retrieve the C-language "errno" (error number)
034200020617     P errno           B
034300020617     D errno           PI            10I 0
034400020617     D p_errno         S               *
034500020617     D wwreturn        S             10I 0 based(p_errno)
034600020617     C                   eval      p_errno = @__errno
034700020617     c                   return    wwreturn
034800020617     P                 E
034900020617
035000020709      ** end program with a (user-defined) escape message
035100020617     P die             B
035200020617     D die             PI             1N
035300020617     D    msg                       256A   const
035400020617
035500020617     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
035600020617     D   MessageID                    7A   Const
035700020617     D   QualMsgF                    20A   Const
035800020617     D   MsgData                    256A   Const
035900020617     D   MsgDtaLen                   10I 0 Const
036000020617     D   MsgType                     10A   Const
036100020617     D   CallStkEnt                  10A   Const
036200020617     D   CallStkCnt                  10I 0 Const
036300020617     D   MessageKey                   4A
036400020617     D   ErrorCode                    1A
036500020617
036600020617     D dsEC            DS
036700020617     D  dsECBytesP             1      4I 0 inz(%size(dsEC))
036800020617     D  dsECBytesA             5      8I 0 inz(0)
036900020617     D  dsECMsgID              9     15
037000020617     D  dsECReserv            16     16
037100020617     D  dsECMsgDta            17    256
037200020617
037300020617     D MsgLen          S             10I 0
037400020617     D TheKey          S              4A
037500020617
037600020617     c     ' '           checkr    msg           MsgLen
037700020617     c                   if        MsgLen<1
037800020617     c                   return    *off
037900020617     c                   endif
038000020617
038100020617     c                   callp     QMHSNDPM('CPF9897': 'QCPFMSG   *LIBL':
038200020617     c                               Msg: MsgLen: '*ESCAPE':
038300020617     c                               '*': 3: TheKey: dsEC)
038400020617
038500020617     c                   return    *off
038600020617     P                 E
038700020709
038800020709
038900020709      ** End program with an escape message that corresponds to
039000020709      **  the value of "errno" above.
039100020709     P EscErrno        B
039200020709     D EscErrno        PI             1N
039300020709     D   errnum                      10i 0 value
039400020709
039500020709     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
039600020709     D   MessageID                    7A   Const
039700020709     D   QualMsgF                    20A   Const
039800020709     D   MsgData                      1A   Const
039900020709     D   MsgDtaLen                   10I 0 Const
040000020709     D   MsgType                     10A   Const
040100020709     D   CallStkEnt                  10A   Const
040200020709     D   CallStkCnt                  10I 0 Const
040300020709     D   MessageKey                   4A
040600020709     D   ErrorCode                    1A
040700020709
040800020709     D dsEC            DS
040900020709     D  dsECBytesP             1      4I 0 inz(%size(dsEC))
041000020709     D  dsECBytesA             5      8I 0 inz(0)
041100020709     D  dsECMsgID              9     15
041200020709     D  dsECReserv            16     16
041300020709     D  dsECMsgDta            17    256
041400020709
041500020709     D TheKey          S              4A
041600020709     D MsgID           S              7A
041700020709
041800020709     c                   move      errnum        MsgID
041900020709     c                   movel     'CPE'         MsgID
042000020709
042100020709     c                   callp     QMHSNDPM(MsgID: 'QCPFMSG   *LIBL':
042200020709     c                               ' ': 0: '*ESCAPE':
042300020709     c                               '*': 3: TheKey: dsEC)
042400020709
042500020709     c                   return    *off
042600020709     P                 E
042700020617      /endif
042800020617
042900020617      /define ERRNO_H
