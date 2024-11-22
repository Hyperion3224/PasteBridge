#Requires AutoHotkey v2.0
#SingleInstance Force

Tab:: 
{
    Send "^c"
    Sleep 50  
    payload := A_Clipboard
    payload := StrReplace(payload, '"', '')
    http := ComObject("WinHttp.WinHttpRequest.5.1")

    try {
        ; CHANGE THE API TO WHATEVER YOURE USING
        http.Open("POST", 'GET YOUR OWN API >:(', true)
        http.SetRequestHeader("Content-Type", "application/json")
        
        jsonPayload := '{"text": "' . payload . '"}'
        http.Send(jsonPayload)
        http.WaitForResponse()
        
    } catch Error as err {
        ; TrayTip "Error", "Failed to connect to API", , 0x10
    }

    return
}