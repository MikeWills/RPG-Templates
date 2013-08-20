000100020624      /if defined(IFSTEXT_H)
000200020624      /eof
000300020624      /endif
000400020624
000500020624      /define IFSTEXT_H
000600020624
000700020624     D writeline       PR            10I 0
000800020624     D   fd                          10I 0 value
000900020624     D   text                          *   value
001000020624     D   len                         10I 0 value
001100020624
001200020624     D readline        PR            10I 0
001300020624     D   fd                          10I 0 value
001400020624     D   text                          *   value
001500020624     D   maxlen                      10I 0 value
