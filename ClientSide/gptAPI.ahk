#Requires AutoHotkey v2.0
#SingleInstance Force

FileRead, envContents, .env  
Loop, parse, envContents, `n  
{
    StringTrimRight, line, A_LoopField, 1 
    if (line != "" && InStr(line, "="))  
    {
        StringSplit, envPair, line, =  
        envVar := envPair1  
        envValue := envPair2  

        EnvSet(envVar, envValue) 
    }
}

Tab::  ; Tab hotkey
{
    ; Copy the currently selected text
    Send "^c"
    Sleep 50  ; Small delay to ensure copy completes

    ; Get the copied text from clipboard
    payload := A_Clipboard

    ; Escape double quotes in payload to avoid breaking the JSON format
    payload := StrReplace(payload, '"', '')

    ; Create WinHTTP object
    http := ComObject("WinHttp.WinHttpRequest.5.1")

    try {
        ; Setup the POST request
        http.Open("POST", EnvGet("API_LINK"), true)
        http.SetRequestHeader("Content-Type", "application/json")
        
        ; Create JSON payload - fixed concatenation syntax
        jsonPayload := '{"text": "' . payload . '"}'
        
        ; Send the request
        http.Send(jsonPayload)
        
        ; Wait for response
        http.WaitForResponse()

        
    } catch Error as err {
        ; TrayTip "Error", "Failed to connect to API", , 0x10
    }

    return
}