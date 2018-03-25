<!--#INCLUDE VIRTUAL="./incs/common_functions.asp"-->
<!--#include virtual="./incs/rc4.inc"-->
<!--#INCLUDE VIRTUAL="./ADMIN/load_connection.asp"-->
<%


response.Write EnDeCrypt("Ck%E6%87a%D6%86%E2a%EF%FB%2E%C2w%F7%8B%A0xg%B68%10%23%9B", npass, 2)
response.write URLDecode("Ck%E6%87a%D6%86%E2a%EF%FB%2E%C2w%F7%8B%A0xg%B68%10%23%9B")
response.End

 %>