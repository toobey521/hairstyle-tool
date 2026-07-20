Set ws = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
curDir = fso.GetParentFolderName(WScript.ScriptFullName)

htmlFile = "hairstyle.html"
fullPath = curDir & "\" & htmlFile
If Not fso.FileExists(fullPath) Then
    MsgBox "未找到 hairstyle.html", vbExclamation, "发型设计助手"
    WScript.Quit
End If

' 1) 启动 Python HTTP 服务（发型工具页面）
ws.Run "cmd /c cd /d """ & curDir & """ && python -m http.server 18765", 0, False

' 2) 启动 ComfyUI（本地生图引擎）
comfyDir = "C:\Users\Administrator\Documents\comfy\ComfyUI"
ws.Run "cmd /c cd /d """ & comfyDir & """ && .venv\Scripts\python.exe main.py --port 8189 --highvram", 0, False

' 3) 启动桥接服务（发型工具→ComfyUI）
ws.Run "cmd /c cd /d """ & curDir & """ && " & comfyDir & "\.venv\Scripts\python.exe comfy_bridge.py", 0, False

' 等待服务就绪（最多等 45 秒）
For i = 1 To 30
    WScript.Sleep 1500
    On Error Resume Next
    Set http = CreateObject("MSXML2.XMLHTTP")
    http.open "GET", "http://localhost:18765/" & htmlFile, False
    http.send
    If http.Status = 200 Then Exit For
    On Error GoTo 0
Next

' 打开浏览器
ws.Run "cmd /c start http://localhost:18765/" & htmlFile, 0, False
