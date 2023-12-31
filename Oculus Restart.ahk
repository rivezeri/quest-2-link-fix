﻿#NoTrayIcon

serial := ""
wrkDir := "C:\Program Files\Oculus\Support\oculus-client"
oculusClient := "C:\Program Files\Oculus\Support\oculus-client\OculusClient.exe"

F21::
{
	JEE_RunGetStdOut(vTarget)
	{
		DetectHiddenWindows, On
		vComSpec := A_ComSpec ? A_ComSpec : ComSpec
		Run, % vComSpec,, Hide, vPID
		WinWait, % "ahk_pid " vPID
		DllCall("kernel32\AttachConsole", "UInt", vPID)
		oShell := ComObjCreate("WScript.Shell")
		oExec := oShell.Exec(vTarget)
		vStdOut := oExec.StdOut.ReadAll()
		DllCall("kernel32\FreeConsole")
		Process, Close, % vPID
		return vStdOut
	}

	TrayTip Oculus, Beginning Oculus keybind, 1	
	run, %comspec% /c adb -s %serial% reboot,, hide

	cmd := "cmd.exe /q /c adb shell dumpsys activity activities | grep ""mFocusedApp=ActivityRecord{"""
	result := JEE_RunGetStdOut(cmd)

	opn := "ShellEnvActivity"
	sec := "xrstreamingclient"
	clr := "clearactivity"

	while (!InStr(result, opn))
		result := JEE_RunGetStdOut(cmd)

	run, %comspec% adb shell settings put system screen_off_timeout 7200000,, hide
	run, %comspec% adb shell svc power stayon true,, hide

	SetWorkingDir %wrkDir%

	loop
	{
		Process, Close, vrcompositor.exe
		Process, Close, vrmonitor.exe
		Process, Close, vrwebhelper.exe
		Process, Close, vrserver.exe
		
		Process, Close, OculusClient.exe
		Process, Close, OVRRedir.exe
		Process, Close, OVRServer_x64.exe
		Process, Close, OVRServiceLauncher.exe

		Run %oculusClient%
		Process, Wait, OculusClient.exe, 10
		
		NewPID := ErrorLevel
		
		if NewPID
		{
			break
		}
	}

	run, %comspec% /c adb shell am force-stop com.oculus.shellenv,, hide

	TrayTip Oculus, Services restart finished, 1

	while (!InStr(result, sec)) {
		run, %comspec% /c adb shell am start -S com.oculus.xrstreamingclient/.MainActivity,, hide
		Sleep 5000
		result := JEE_RunGetStdOut(cmd)
		
	}

	TrayTip Oculus, Restart finished, 1	
	
	var := 0
	loop {
		if (var == 30) {
			break
		}
		WinMinimize, Oculus
		WinMinimize, OVR Toolkit Settings
		var := var + 1
		Sleep 1000
	}
	
}