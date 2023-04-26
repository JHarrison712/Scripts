::  It is recommended to test the script on a local machine for its purpose and effects. 
::  ManageEngine Desktop Central will not be responsible for any 
::  damage/loss to the data/setup based on the behavior of the script.

::  Description - Batch script to set the password expiry for the local machine
::  Configuration Type - COMPUTER
::	Remarks: THe machine may require a restart to make the changes effective
::  ==============================================================

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f