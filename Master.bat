:: the working directory
Set WorkingDir="%~dp0"

:: The Process directory (where the worker located)
Set Proc="%WorkingDir%\Proc"

:: Set the number of worker
Set /A NumberOfWorker=20

cd /d %workingDir%

:: Spawn worker Async
Del %Proc%\*.bat*
Set /A workercounter=1
:workerpool
Copy %Proc%\template\Worker0.bat %Proc%\Worker%Workercounter%.bat
Start cmd /C Call %Proc%\worker%workercounter%.bat
IF %workercounter%==%NumberOfWorker%  (
	GOTO workerend
) Else (
	Set /A workercounter+=1
	GOTO workerpool
)
:workerend


:: Check if worker finish the job
:chkworker
If exist %Proc%\Flag\*.lock (
	Ping 127.0.0.1 -n 5 > NUL 
	GOTO chkworker	
) Else (
	GOTO endworkerchk
)
:endworkerchk
Del %Proc%\*.bat*

pause