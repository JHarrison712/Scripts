takeown /F "c:\program files (x86)\webroot" /R /D Y
"C:\Program Files (x86)\Webroot\WRSA.exe" -uninstall /s /q
del C:\ProgramData\WRCore\* /s /q
del C:\ProgramData\WRData\* /s/q
