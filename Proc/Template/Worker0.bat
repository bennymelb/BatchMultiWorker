:: Do some operation 

Set lockfile=%Proc%\Flag\Worker%Workercounter%.lock

Worker%workercounter% > %lockfile%

Set /A counter=0
:loop
Set /A counter+=1
echo %counter% >> %WorkingDir%/work%workercounter%.txt
IF %Counter% == 1000 (
	GOTO end
) ELSE (
	GOTO loop
)
:end
del %lockfile%
