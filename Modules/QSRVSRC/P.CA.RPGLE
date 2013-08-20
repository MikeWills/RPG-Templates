000100060627       // **********************************************************************
000200060627       // Copybook for Common Address
000300060627
000400060627     D*--------------------------------------------------
000500060627     D* Procedure name: GetCAUKeyInfo
000600060627     D* Purpose:        Get the Common Address Unique Key Info
000700060627     D* Returns:        cauKey Data Return
000800060627     D* Parameter:      cauKey => Common Address Key
000900060627     D*--------------------------------------------------
001000060627     D GetCAUKeyInfo   PR            88A
001100060627     D  cauKey                        6P 0 CONST
001200060627
001300060627       // Global Values
001400060627     D caReturnDS      DS
001500060627     D  retCaPin                     17A
001600060627     D  retOwner                     30A
001700060627     D  retCaStNu                     9A
001800060627     D  retCaStEx                     5A
001900060627     D  retCaStNa                    20A
002000060627     D  retCaStSu                     5A
002100060627     D  retCaStDir                    2A
002200060720
002300060720     D*--------------------------------------------------
002400060720     D* Procedure name: BuildAddress
002500060720     D* Purpose:        Join the Address into one text field
002600060720     D* Returns:        Joined Address
002700060720     D* Parameter:      CommonAddrKey
002800060720     D*--------------------------------------------------
002900060720     D BuildAddress    PR            40A
003000060720     D  CommonAddrKey                 6P 0 CONST
003100060720
