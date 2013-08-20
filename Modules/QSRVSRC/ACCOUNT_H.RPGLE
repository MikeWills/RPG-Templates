000100080415      // ***********************************************************************
000200080415      // Account Prompts and Validation
000300080415      // ***********************************************************************
000400080415      // Fund Prompt
000500090825     D PromptFund      PR                  extpgm('APLIBR2/APF4FUND')
000600080415     D  retFund                       3A
000700080415     D  retFund        S              3A
000800080415      // Department Prompt
000900090825     D PromptDept      PR                  extpgm('APLIBR2/APF4DEPT')
001000080415     D  retDept                       5A
001100080415     D  retDept        S              5A
001200080415      // Account Prompt
001300090825     D PromptAcct      PR                  extpgm('APLIBR2/APF4ACCT')
001400080415     D  retAcct                       6A
001500080415     D  retAcct        S              6A
001600080415      // Project Prompt
001700090825     D PromptProj      PR                  extpgm('APLIBR2/APF4PROJ')
001800080415     D  retProj                       5A
001900080415     D  retProj        S              5A
002000080415      // Job Prompt
002100090825     D PromptJob       PR                  extpgm('APLIBR2/APF4JOB')
002200080415     D  retJob                        3A
002300080415     D  retJob         S              3A
002400080415      // Validate Account Number
002500080415     D ValidAccountCheck...
002600090825     D                 PR                  extpgm('APLIBR2/APEDITGL')
002700080415     D  fundIn                        3A   const
002800080415     D  deptIn                        5A   const
002900080415     D  acctIn                        6A   const
003000080415     D  projIn                        5A   const
003100080415     D  jobIn                         3A   const
003200080415     D  retPErrors                    1A
003300080415     D  retErrorMessage...
003400080415     D                               78A
003500080415     D  retCursor                     1A
003600080415     D  retPErrors     S              1A
003700080415     D  retErrorMessage...
003800080415     D                 S             78A
003900080415     D  retCursor      S              1A
