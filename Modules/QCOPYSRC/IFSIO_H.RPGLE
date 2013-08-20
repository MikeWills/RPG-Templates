000100020616     D**********************************************************************
000200020616     D* This code prevents this member from being /copy into the same
000300020616     D* program twice.   This allows you to /copy this file into your
000400020616     D* own /copy members, without worry about conflicting with programs
000500020616     D* that also /copy this.
000600020616     D**********************************************************************
000700020611     D/if defined(IFSIO_H)
000800020611     D/eof
000900020611     D/endif
001000020611
001100020611     D/define IFSIO_H
001200020616
001300020616     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
001400020617     D*:  DEFINITIONS EXPLAINED IN CHAPTER 2:
001500020616     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
001600020611
001700020611     D**********************************************************************
001800020611     D*  Flags for use in open()
001900020611     D*
002000020611     D* More than one can be used -- add them together.
002100020611     D**********************************************************************
002200020611     D*                                            Reading Only
002300020611     D O_RDONLY        C                   1
002400020611     D*                                            Writing Only
002500020611     D O_WRONLY        C                   2
002600020611     D*                                            Reading & Writing
002700020611     D O_RDWR          C                   4
002800020611     D*                                            Create File if not exist
002900020630     D O_CREAT         C                   8
003000020611     D*                                            Exclusively create
003100020611     D O_EXCL          C                   16
003200030829     D*                                            Assign a CCSID
003300030829     D O_CCSID         C                   32
003400020611     D*                                            Truncate File to 0 bytes
003500020611     D O_TRUNC         C                   64
003600020611     D*                                            Append to File
003700020611     D O_APPEND        C                   256
003800030829     D*                                            Synchronous write
003900030829     D O_SYNC          C                   1024
004000030829     D*                                            Sync write, data only
004100030829     D O_DSYNC         C                   2048
004200030829     D*                                            Sync read
004300030829     D O_RSYNC         C                   4096
004400030829     D*                                            No controlling terminal
004500030829     D O_NOCTTY        C                   32768
004600030829     D*                                            Share with readers only
004700030829     D O_SHARE_RDONLY  C                   65536
004800030829     D*                                            Share with writers only
004900030829     D O_SHARE_WRONLY  C                   131072
005000030829     D*                                            Share with read & write
005100030829     D O_SHARE_RDWR    C                   262144
005200030829     D*                                            Share with nobody.
005300030829     D O_SHARE_NONE    C                   524288
005400030829     D*                                            Assign a code page
005500020611     D O_CODEPAGE      C                   8388608
006100020611     D*                                            Open in text-mode
006200020611     D O_TEXTDATA      C                   16777216
006300030829     D*                                            Allow text translation
006400030829     D*                                            on newly created file.
006500030829     D* Note: O_TEXT_CREAT requires all of the following flags to work:
006600030829     D*           O_CREAT+O_TEXTDATA+(O_CODEPAGE or O_CCSID)
006700030829     D O_TEXT_CREAT    C                   33554432
006800030829     D*                                            Inherit mode from dir
006900030829     D O_INHERITMODE   C                   134217728
007000030829     D*                                            Large file access
007100030829     D*                                            (for >2GB files)
007200030829     D O_LARGEFILE     C                   536870912
007300020611
007400030829
007500020611     D**********************************************************************
007600020611     D*      Mode Flags.
007700020611     D*         basically, the mode parm of open(), creat(), chmod(),etc
007800020611     D*         uses 9 least significant bits to determine the
007900020611     D*         file's mode. (peoples access rights to the file)
008000020611     D*
008100020611     D*           user:       owner    group    other
008200020611     D*           access:     R W X    R W X    R W X
008300020611     D*           bit:        8 7 6    5 4 3    2 1 0
008400020611     D*
008500020611     D* (This is accomplished by adding the flags below to get the mode)
008600020611     D**********************************************************************
008700020611     D*                                         owner authority
008800020611     D S_IRUSR         C                   256
008900020611     D S_IWUSR         C                   128
009000020611     D S_IXUSR         C                   64
009100020611     D S_IRWXU         C                   448
009200020611     D*                                         group authority
009300020611     D S_IRGRP         C                   32
009400020611     D S_IWGRP         C                   16
009500020611     D S_IXGRP         C                   8
009600020611     D S_IRWXG         C                   56
009700020611     D*                                         other people
009800020611     D S_IROTH         C                   4
009900020611     D S_IWOTH         C                   2
010000020611     D S_IXOTH         C                   1
010100020611     D S_IRWXO         C                   7
010200020611
010300020611
010400020611      *---------------------------------------------------------------------
010500020611      * open() -- Open File
010600020611      *
010700020611      * int open(const char *path, int oflag, . . .);
010800020611      *
010900020611      *     path = path name of file to open
011000020611      *    oflag = open flags
011100020611      *     mode = file mode, aka permissions.  (Reqd with O_CREAT flag)
011200020611      * codepage = code page to assign to file  (Reqd with O_CODEPAGE flag)
011300020611      *
011400020611      * Returns the file descriptor of the opened file
011500020611      *         or -1 if an error occurred
011600020611      *---------------------------------------------------------------------
011700020611     D open            PR            10I 0 extproc('open')
011800020611     D   path                          *   value options(*string)
011900020611     D   oflag                       10I 0 value
012000020611     D   mode                        10U 0 value options(*nopass)
012100020611     D   codepage                    10U 0 value options(*nopass)
012200020611
012300020611
012400020611      *---------------------------------------------------------------------
012500020611      * write() -- Write to stream file
012600020611      *
012700020701      * int write(int fildes, const void *buf, size_t nbyte);
012800020611      *
012900020611      *   fildes = file descriptor to write to
013000020611      *      buf = pointer to data to be written
013100020611      *    nbyte = number of bytes to write
013200020611      *
013300020611      * Returns the number of bytes written
013400020611      *         or a -1 if an error occurred
013500020611      *---------------------------------------------------------------------
013600020611     D write           PR            10I 0 extproc('write')
013700020611     D   fildes                      10I 0 value
013800020611     D   buf                           *   value
013900020611     D   nbyte                       10U 0 value
014000020611
014100020611
014200020611      *---------------------------------------------------------------------
014300020611      * read() -- Read from stream file
014400020611      *
014500020701      * int read(int fildes, void *buf, size_t nbyte);
014600020611      *
014700020611      *   fildes = file descriptor to read from
014800020611      *      buf = pointer to memory to read into
014900020611      *    nbyte = maximum number of bytes to read
015000020611      *
015100020611      * Returns the number of bytes read
015200020611      *         or a -1 if an error occurred
015300020611      *---------------------------------------------------------------------
015400020611     D read            PR            10I 0 extproc('read')
015500020611     D   fildes                      10I 0 value
015600020611     D   buf                           *   value
015700020611     D   nbyte                       10U 0 value
015800020611
015900020611
016000020611      *---------------------------------------------------------------------
016100020611      * close() -- Close file descriptor
016200020611      *
016300020611      * int close(int fildes);
016400020611      *
016500020611      *   fildes = file descriptor to close
016600020611      *
016700020611      * Returns 0 if successful
016800020611      *         or a -1 if an error occurred
016900020611      *---------------------------------------------------------------------
017000020701      /if not defined(CLOSE_PROTOTYPE)
017100020611     D close           PR            10I 0 extproc('close')
017200020611     D   fildes                      10I 0 value
017300020701      /define CLOSE_PROTOTYPE
017400020701      /endif
017500020616
017600020616     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
017700020617     D*:  DEFINITIONS EXPLAINED IN CHAPTER 3:
017800020616     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
017900020617
018000020622      **********************************************************************
018100020622      * Access mode flags for access()
018200020622      *
018300020622      *   F_OK = File Exists
018400020622      *   R_OK = Read Access
018500020622      *   W_OK = Write Access
018600020622      *   X_OK = Execute or Search
018700020622      **********************************************************************
018800020617     D F_OK            C                   0
018900020617     D R_OK            C                   4
019000020617     D W_OK            C                   2
019100020622     D X_OK            C                   1
019200020622
019300020622
019400020622      *--------------------------------------------------------------------
019500020622      * Determine file accessibility
019600020622      *
019700020622      * int access(const char *path, int amode)
019800020622      *
019900020622      *--------------------------------------------------------------------
020000020622     D access          PR            10I 0 ExtProc('access')
020100020622     D   Path                          *   Value Options(*string)
020200020622     D   amode                       10I 0 Value
020300020617
020400020622      *--------------------------------------------------------------------
020500020622      * Change file permissions
020600020622      *
020700020622      * int chmod(const char *path, mode_t mode)
020800020622      *--------------------------------------------------------------------
020900020617     D chmod           PR            10I 0 ExtProc('chmod')
021000020617     D   path                          *   Value options(*string)
021100020617     D   mode                        10U 0 Value
021200020622
021300020622
021400020622      *--------------------------------------------------------------------
021500020623      * Rename a file or directory.
021600020622      *
021700020623      * int rename(const char *old, const char *new);
021800020622      *--------------------------------------------------------------------
021900020623     D rename          PR            10I 0 ExtProc('Qp0lRenameKeep')
022000020623     D   old                           *   Value options(*string)
022100020623     D   new                           *   Value options(*string)
022200020623
022300020623
022400020623      *--------------------------------------------------------------------
022500020623      * Remove Link to File.  (deletes 1 reference to a file.  If this
022600020623      *   is the last reference, the file itself is deleted.  See
022700020623      *   Chapter 3 for more info)
022800020623      *
022900020623      * int unlink(const char *path)
023000020623      *--------------------------------------------------------------------
023100020623     D unlink          PR            10I 0 ExtProc('unlink')
023200020623     D   path                          *   Value options(*string)
023300020622
023400020622
023500020622      **********************************************************************
023600020622      * File Information Structure (stat)
023700020622      *
023800020622      * struct stat {
023900020622      *  mode_t         st_mode;       /* File mode                       */
024000020622      *  ino_t          st_ino;        /* File serial number              */
024100020622      *  nlink_t        st_nlink;      /* Number of links                 */
024200020622      *  uid_t          st_uid;        /* User ID of the owner of file    */
024300020622      *  gid_t          st_gid;        /* Group ID of the group of file   */
024400020622      *  off_t          st_size;       /* For regular files, the file
024500020622      *                                 * size in bytes                   */
024600020622      *  time_t         st_atime;      /* Time of last access             */
024700020622      *  time_t         st_mtime;      /* Time of last data modification  */
024800020622      *  time_t         st_ctime;      /* Time of last file status change */
024900020622      *  dev_t          st_dev;        /* ID of device containing file    */
025000020622      *  size_t         st_blksize;    /* Size of a block of the file     */
025100020622      *  unsigned long  st_allocsize;  /* Allocation size of the file     */
025200020622      *  qp0l_objtype_t st_objtype;    /* AS/400 object type              */
025300020622      *  unsigned short st_codepage;   /* Object data codepage            */
025400020622      *  char           st_reserved1[66]; /* Reserved                     */
025500020622      * };
025600020622      *
025700020622      **********************************************************************
025800020622     D p_statds        S               *
025900020622     D statds          DS                  BASED(p_statds)
026000020622     D  st_mode                      10U 0
026100020622     D  st_ino                       10U 0
026200020622     D  st_nlink                      5U 0
026300020622     D  st_pad                        2A
026400020622     D  st_uid                       10U 0
026500020622     D  st_gid                       10U 0
026600020622     D  st_size                      10I 0
026700020622     D  st_atime                     10I 0
026800020622     D  st_mtime                     10I 0
026900020622     D  st_ctime                     10I 0
027000020622     D  st_dev                       10U 0
027100020622     D  st_blksize                   10U 0
027200020622     D  st_allocsize                 10U 0
027300020622     D  st_objtype                   12A
027400020622     D  st_codepage                   5U 0
027500020622     D  st_reserved1                 62A
027600020622     D  st_ino_gen_id                10U 0
027700020622
027800020622
027900020622      *--------------------------------------------------------------------
028000020622      * Get File Information
028100020622      *
028200020622      * int stat(const char *path, struct stat *buf)
028300020622      *--------------------------------------------------------------------
028400020622     D stat            PR            10I 0 ExtProc('stat')
028500020622     D   path                          *   value options(*string)
028600020622     D   buf                           *   value
028700020623
028800020623     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
028900020623     D*:  DEFINITIONS EXPLAINED IN CHAPTER 4:
029000020623     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
029100020623
029200020623     D**********************************************************************
029300020623     D* "whence" constants for use with lseek()
029400020623     D**********************************************************************
029500020623     D SEEK_SET        C                   CONST(0)
029600020623     D SEEK_CUR        C                   CONST(1)
029700020623     D SEEK_END        C                   CONST(2)
029800020623
029900020623     D*--------------------------------------------------------------------
030000020623     D* Set File Read/Write Offset
030100020623     D*
030200020623     D* off_t lseek(int fildes, off_t offset, int whence)
030300020623     D*--------------------------------------------------------------------
030400020623     D lseek           PR            10I 0 ExtProc('lseek')
030500020623     D   fildes                      10I 0 value
030600020623     D   offset                      10I 0 value
030700020623     D   whence                      10I 0 value
030800020624
030900020624
031000020624      *--------------------------------------------------------------------
031100020624      * Get File Information from descriptor
031200020624      *
031300020624      * int fstat(int fildes, struct stat *buf)
031400020624      *--------------------------------------------------------------------
031500020624     D fstat           PR            10I 0 ExtProc('fstat')
031600020624     D   fildes                      10I 0 value
031700020624     D   buf                           *   value
031800020627
031900020627     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
032000020627     D*:  DEFINITIONS EXPLAINED IN CHAPTER 7:
032100020627     D*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
032200020627
032300020627
032400020627     D**********************************************************************
032500020627     D*
032600020627     D* Directory Entry Structure (dirent)
032700020627     D*
032800020627     D* struct dirent {
032900020627     D*   char           d_reserved1[16];  /* Reserved                       */
033000020627     D*   unsigned int   d_reserved2;      /* Reserved                       */
033100020627     D*   ino_t          d_fileno;         /* The file number of the file    */
033200020627     D*   unsigned int   d_reclen;         /* Length of this directory entry
033300020627     D*                                     * in bytes                       */
033400020627     D*   int            d_reserved3;      /* Reserved                       */
033500020627     D*   char           d_reserved4[8];   /* Reserved                       */
033600020627     D*   qlg_nls_t      d_nlsinfo;        /* National Language Information
033700020627     D*                                     * about d_name                   */
033800020627     D*   unsigned int   d_namelen;        /* Length of the name, in bytes
033900020627     D*                                     * excluding NULL terminator      */
034000020627     D*   char           d_name[_QP0L_DIR_NAME]; /* Name...null terminated   */
034100020627     D*
034200020627     D* };
034300020627     D*
034400020627     D**********************************************************************
034500020627     D p_dirent        s               *
034600020627     D dirent          ds                  based(p_dirent)
034700020627     D   d_reserv1                   16A
034800020627     D   d_reserv2                   10U 0
034900020627     D   d_fileno                    10U 0
035000020627     D   d_reclen                    10U 0
035100020627     D   d_reserv3                   10I 0
035200020627     D   d_reserv4                    8A
035300020627     D   d_nlsinfo                   12A
035400020627     D     nls_ccsid                 10I 0 OVERLAY(d_nlsinfo:1)
035500020627     D     nls_cntry                  2A   OVERLAY(d_nlsinfo:5)
035600020627     D     nls_lang                   3A   OVERLAY(d_nlsinfo:7)
035700020627     D     nls_reserv                 3A   OVERLAY(d_nlsinfo:10)
035800020627     D   d_namelen                   10U 0
035900020627     D   d_name                     640A
036000020627
036100020627
036200020627     D*--------------------------------------------------------------------
036300020627     D* Make Directory
036400020627     D*
036500020627     D* int mkdir(const char *path, mode_t mode)
036600020627     D*--------------------------------------------------------------------
036700020627     D mkdir           PR            10I 0 ExtProc('mkdir')
036800020627     D   path                          *   Value options(*string)
036900020627     D   mode                        10U 0 Value
037000020627
037100020627
037200020627     D*--------------------------------------------------------------------
037300020627     D* Remove Directory
037400020627     D*
037500020627     D* int rmdir(const char *path)
037600020627     D*--------------------------------------------------------------------
037700020627     D rmdir           PR            10I 0 ExtProc('rmdir')
037800020627     D   path                          *   value options(*string)
037900020627
038000020627
038100020627     D*--------------------------------------------------------------------
038200020627     D* Change Directory
038300020627     D*
038400020627     D* int chdir(const char *path)
038500020627     D*--------------------------------------------------------------------
038600020627     D chdir           PR            10I 0 ExtProc('chdir')
038700020627     D   path                          *   Value Options(*string)
038800020627
038900020627
039000020627     D*--------------------------------------------------------------------
039100020627     D* Open a Directory
039200020627     D*
039300020627     D* DIR *opendir(const char *dirname)
039400020627     D*--------------------------------------------------------------------
039500020627     D opendir         PR              *   EXTPROC('opendir')
039600020627     D  dirname                        *   VALUE options(*string)
039700020627
039800020627
039900020627     D*--------------------------------------------------------------------
040000020627     D* Read Directory Entry
040100020627     D*
040200020627     D* struct dirent *readdir(DIR *dirp)
040300020627     D*--------------------------------------------------------------------
040400020627     D readdir         PR              *   EXTPROC('readdir')
040500020627     D  dirp                           *   VALUE
040600020627
040700020627
040800020627     D*--------------------------------------------------------------------
040900020627     D* Close a directory
041000020627     D*
041100020627     D* int closedir(DIR *dirp)
041200020627     D*--------------------------------------------------------------------
041300020627     D closedir        PR            10I 0 EXTPROC('closedir')
041400020627     D  dirhandle                      *   VALUE
041500020630
041600020630
041700020630     D*--------------------------------------------------------------------
041800020630     D* Get Current Working Directory
041900020630     D*
042000020630     D* char *getcwd(char *buf, int size);
042100020630     D*--------------------------------------------------------------------
042200020630     D getcwd          PR              *   EXTPROC('getcwd')
042300020630     D  buf                            *   VALUE
042400020630     D  size                         10I 0 VALUE
