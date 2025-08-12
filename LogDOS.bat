:LOGDOS
cls
@echo off
setlocal enabledelayedexpansion
REM _______________________________________________
REM BUILT ON THE BATDOS KERNEL 3.0 
REM DO NOT COPY THIS CODE 
REM FEEL FREE TO USE THE BATDOS KERNEL WHICH WILL
REM BE INCLUDED IN THE LOGDOS 3.51 GITHUB
REM REPOSITORY
REM Initialize variables with error checking
set "logfile=LOGDOSCMDHISTORY.DAT"
set "version=3.51"
set "os_version=2.20"
set "kernel_version=1.01"
set "admin_password=admin"  REM Default; modify as needed

REM Test initial setup and load virtual disk files
if not exist "!logfile!" (
    echo Creating command history file...
    echo. > "!logfile!" 2>nul || (echo Error: Cannot create !logfile!. & pause & exit /b 1)
)
if exist "DISK1.cmd" (
    call "DISK1.cmd" 2>nul || echo Warning: DISK1.cmd failed to load.
) else (
    echo Warning: DISK1.cmd not found. Virtual disk support limited.
)
if exist "recpart.cmd" (
    call "recpart.cmd" 2>nul || echo Warning: recpart.cmd failed to load.
) else (
    echo Warning: recpart.cmd not found. Recovery partition support limited.
)

REM Start main loop
goto :dosloop

:dosloop
set "input="
set /p "input=X:~$ "
if not defined input goto :dosloop
if /i "!input!"=="exit" goto :recovery
if /i "!input!"=="^>" goto :dosloop
echo !input!>>"!logfile!" 2>nul || echo Error: Unable to log command.
call :parse_command 2>nul || echo 1 > 1.txt
goto :dosloop

:parse_command
if not defined input (
    echo Error: No command entered.
    goto :eof
)

if /i "!input!"=="help" goto :cmd_help
if /i "!input!"=="start" goto :cmd_start
if /i "!input!"=="logver" goto :cmd_logver
if /i "!input!"=="set" goto :cmd_set
if /i "!input!"=="exit_norec" goto :boot
if /i "!input!"=="kernvers" goto :cmd_kernvers
if /i "!input!"=="errorlevel" goto :cmd_errorlevel
if /i "!input!"=="echo" goto :cmd_echo
if /i "!input!"=="dir" goto :cmd_dir
if /i "!input!"=="tree" goto :cmd_tree
if /i "!input!"=="admprv" goto :cmd_admprv
if /i "!input!"=="runamd" goto :cmd_runamd
if /i "!input!"=="echo on" goto :cmd_echo_on
if /i "!input!"=="qbasic" goto :cmd_qbasic
if /i "!input!"=="logedit" goto :logedit
if /i "!input!"=="intinf" goto :cmd_intinf
if /i "!input!"=="logosys" goto :cmd_logosys
if /i "!input!"=="echo off" goto :cmd_echo_off
if /i "!input!"=="setlocal" goto :cmd_setlocal
if /i "!input!"=="del" goto :cmd_del
if /i "!input!"=="xcopy" goto :cmd_xcopy
if /i "!input!"=="chkdsk" goto :cmd_chkdsk
if /i "!input!"=="format" goto :cmd_format
if /i "!input!"=="cls" goto :cmd_cls
if /i "!input!"=="spart" goto :cmd_spart
if /i "!input!"=="time" goto :cmd_time
if /i "!input!"=="date" goto :cmd_date
if /i "!input!"=="doskey" goto :cmd_doskey
if /i "!input!"=="type" goto :cmd_type
if /i "!input!"=="cd" goto :cmd_cd
if /i "!input!"=="mkdir" goto :cmd_mkdir
if /i "!input!"=="rem" goto :cmd_rem
if /i "!input!"=="rmdir" goto :cmd_rmdir
if /i "!input!"=="dosver" goto :cmd_dosver
if /i "!input!"=="mode" goto :cmd_mode
if /i "!input!"=="edit" goto :logedit
if /i "!input!"=="color" goto :cmd_color
if /i "!input!"=="rename" goto :cmd_rename
if /i "!input!"=="copycon" goto :cmd_copycon
if /i "!input!"=="move" goto :cmd_move
if /i "!input!"=="attrib" goto :cmd_attrib
if /i "!input!"=="find" goto :cmd_find
if /i "!input!"=="findstr" goto :cmd_findstr
if /i "!input!"=="more" goto :cmd_more
if /i "!input!"=="path" goto :cmd_path
if /i "!input!"=="prompt" goto :cmd_prompt
if /i "!input!"=="replace" goto :cmd_replace
if /i "!input!"=="sort" goto :cmd_sort
if /i "!input!"=="subst" goto :cmd_subst
if /i "!input!"=="ver" goto :cmd_ver
if /i "!input!"=="vol" goto :cmd_vol
if /i "!input!"=="label" goto :cmd_label
if /i "!input!"=="backup" goto :cmd_backup
if /i "!input!"=="restore" goto :cmd_restore
if /i "!input!"=="comp" goto :cmd_comp
if /i "!input!"=="fc" goto :cmd_fc
if /i "!input!"=="editenv" goto :cmd_editenv
if /i "!input!"=="pause" goto :cmd_pause
if /i "!input!"=="resume" goto :cmd_resume
if /i "!input!"=="restart" goto :cmd_restart
if /i "!input!"=="shutdown" goto :cmd_shutdown
if /i "!input!"=="logclear" goto :cmd_logclear
if /i "!input!"=="diskinfo" goto :cmd_diskinfo
if /i "!input!"=="partinfo" goto :cmd_partinfo
if /i "!input!"=="defrag" goto :cmd_defrag
if /i "!input!"=="recover" goto :cmd_recover
if /i "!input!"=="sysinfo" goto :cmd_sysinfo
echo Error: Command "!input!" not recognized.
goto :eof

:cmd_help
echo.
echo LogDOS Command Prompt Help
echo -------------------------
echo Available commands:
echo help          - Display this help
echo start        - Run an application
echo logver       - Show LogDOS version
echo set          - Set a variable
echo exit         - Exit to recovery
echo exit_norec   - Exit to boot
echo kernvers     - Show kernel info
echo errorlevel   - Show error level
echo echo         - Echo text
echo dir          - List files
echo tree         - Show directory tree
echo admprv       - Request admin privileges
echo runamd       - Show CPU info
echo echo on/off  - Toggle echoing
echo qbasic       - Launch QBasic (not included)
echo logedit      - Open text editor
echo intinf       - Check internet
echo logosys      - Show system info
echo del          - Delete file
echo xcopy        - Copy file
echo chkdsk       - Check virtual disk
echo format       - Format virtual partition
echo cls          - Clear screen
echo spart        - Switch partition
echo time         - Show time
echo date         - Show date
echo doskey       - Show history
echo type         - Display file
echo cd           - Change directory
echo mkdir        - Create directory
echo rem          - Add comment
echo rmdir        - Remove directory (not supported)
echo dosver       - Show version
echo mode         - Change mode (not supported)
echo edit         - Open editor
echo color        - Change color
echo rename       - Rename a file
echo copycon      - Create a file with text
echo move         - Move a file
echo attrib       - Change file attributes
echo find         - Search file for text
echo findstr      - Search files with patterns
echo more         - Display file page by page
echo path         - Display or set PATH
echo prompt       - Change command prompt
echo replace      - Replace file contents
echo sort         - Sort file contents
echo subst        - Assign drive letter
echo ver          - Show OS version
echo vol          - Show disk volume
echo label        - Set disk label
echo backup       - Create file backup
echo restore      - Restore file from backup
echo comp         - Compare two files
echo fc           - Compare files with details
echo editenv      - Edit environment variables
echo pause        - Pause execution
echo resume       - Resume execution
echo restart      - Restart LogDOS
echo shutdown     - Simulate shutdown
echo logclear     - Clear command history
echo diskinfo     - Show virtual disk info
echo partinfo     - Show partition info
echo defrag       - Simulate defragmentation
echo recover      - Attempt file recovery
echo sysinfo      - Show extended system info
echo.
pause
goto :eof

:cmd_start
set /p "app=Enter app name (e.g., filename.bat): "
if not defined app echo Error: No app name. & goto :eof
if not exist "!app!" echo Error: "!app!" not found. & goto :eof
call "!app!" 2>nul || echo Error: Failed to run "!app!".
goto :eof

:cmd_logver
echo LogDOS Version: !version!
echo For system info, type logosys.
pause
goto :eof

:cmd_set
set /p "var=Enter variable name: "
if not defined var echo Error: No variable name. & goto :eof
set /p "val=Enter value: "
if not defined val echo Error: No value. & goto :eof
set "!var!=!val!"
echo !var! set to !val!.
goto :eof

:cmd_kernvers
echo LogOS Kernel Data
echo -----------------
echo Version: !kernel_version!
echo File System: FAT16
echo Kernel File: kernel.bat
pause
goto :eof

:cmd_errorlevel
echo Error level: !errorlevel!
goto :eof

:cmd_echo
set /p "text=Enter text: "
if not defined text echo Error: No text. & goto :eof
echo !text!
goto :eof

:cmd_dir
dir /b 2>nul || echo Error: Cannot list directory.
goto :eof

:cmd_tree
set /p "path=Enter path (Enter for current): "
if not defined path set "path=."
tree "!path!" 2>nul || echo Error: Invalid path.
goto :eof

:cmd_admprv
set /p "pass=Enter password: "
if /i "!pass!"=="!admin_password!" (
    echo Admin access granted.
    set "adminpriv=True"
) else (
    echo Error: Wrong password.
)
goto :eof

:cmd_runamd
echo System Info
echo -----------
echo Version: !version!
echo NT: False
echo Processor: Intel
echo OS: LogDOS !version!
goto :eof

:cmd_echo_on
@echo on
echo Command echoing enabled.
goto :eof

:cmd_qbasic
echo Error: QBasic not included in LogDOS !version!. Use LogDOS 3.0 Boot DVD.
goto :eof

:cmd_intinf
echo Error: Internet not connected. Boot to LogOS.
goto :eof

:cmd_logosys
echo System Info
echo -----------
echo LogOS Kernel: 1.2
echo LogOS Version: !os_version!
echo LogDOS Version: !version!
echo 3.5 Compatibility: Off
goto :eof

:cmd_echo_off
@echo off
echo Command echoing disabled.
pause
goto :eof

:cmd_setlocal
set /p "mode=Enter mode (enabledelayedexpansion/disabledelayedexpansion): "
if /i "!mode!"=="enabledelayedexpansion" (
    setlocal enabledelayedexpansion
    echo Delayed expansion enabled.
) else if /i "!mode!"=="disabledelayedexpansion" (
    setlocal disabledelayedexpansion
    echo Delayed expansion disabled.
) else (
    echo Error: Invalid mode.
)
pause
goto :eof

:cmd_del
set /p "file=Enter file name: "
if not defined file echo Error: No file name. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
del "!file!" 2>nul && echo !file! deleted. || echo Error: Delete failed.
pause
goto :eof

:cmd_xcopy
set /p "source=Enter source file: "
if not defined source echo Error: No source. & goto :eof
set /p "dest=Enter destination: "
if not defined dest echo Error: No destination. & goto :eof
if not exist "!source!" echo Error: "!source!" not found. & goto :eof
xcopy "!source!" "!dest!" 2>nul && echo Copy successful. || echo Error: Copy failed.
pause
goto :eof

:cmd_chkdsk
if exist "DISK1.cmd" (
    call "DISK1.cmd" check 2>nul && echo Virtual disk checked. || echo Error: Disk check failed.
) else (
    echo Error: DISK1.cmd not found. Cannot check virtual disk.
)
pause
goto :eof

:cmd_format
echo Loading virtual partitions...
if exist "recpart.cmd" (
    call "recpart.cmd" 2>nul || echo Warning: recpart.cmd failed to load.
)
if exist "DISK1.cmd" (
    call "DISK1.cmd" 2>nul || echo Warning: DISK1.cmd failed to load.
)
echo Select partition:
echo 1. LogOS Recovery (recpart.cmd)
echo 2. LogDOS (DISK1.cmd)
echo 3. LogOS
echo 4. Boot
choice /c 1234
if errorlevel 4 echo Format aborted. & goto :eof
if errorlevel 3 (
    echo WARNING: Deletes LogOS. Proceed? [Y/N]
    choice /c YN
    if errorlevel 2 echo Format aborted. & goto :eof
    if exist "LOGOSPARTDATA.CMD" del "LOGOSPARTDATA.CMD" 2>nul && echo LogOS partition formatted. || echo Error: Format failed.
)
if errorlevel 2 (
    if exist "DISK1.cmd" (
        call "DISK1.cmd" format 2>nul && echo DISK1 formatted. || echo Error: Format failed.
    ) else (
        echo Error: DISK1.cmd not found.
    )
)
if errorlevel 1 (
    if exist "recpart.cmd" (
        call "recpart.cmd" format 2>nul && echo Recovery partition formatted. || echo Error: Format failed.
    ) else (
        echo Error: recpart.cmd not found.
    )
)
pause
goto :eof

:cmd_cls
cls
goto :eof

:cmd_spart
if exist "DISK1.cmd" (
    call "DISK1.cmd" switch 2>nul && echo Switched to DISK1. || echo Error: Switch failed.
) else (
    echo Error: DISK1.cmd not found.
)
if exist "recpart.cmd" (
    call "recpart.cmd" switch 2>nul && echo Switched to recovery partition. || echo Error: Switch failed.
) else (
    echo Warning: recpart.cmd not found.
)
goto :eof

:cmd_time
echo Current time: %time%
goto :eof

:cmd_date
echo Current date: %date%
goto :eof

:cmd_doskey
if exist "!logfile!" (type "!logfile!" 2>nul) else echo Error: History not found.
goto :eof

:cmd_type
set /p "file=Enter file name: "
if not defined file echo Error: No file. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
type "!file!" 2>nul || echo Error: Cannot display.
goto :eof

:cmd_cd
set /p "dir=Enter directory: "
if not defined dir echo Error: No directory. & goto :eof
cd /d "!dir!" 2>nul && echo Changed to !dir!. || echo Error: Invalid directory.
goto :eof

:cmd_mkdir
set /p "dir=Enter directory name: "
if not defined dir echo Error: No name. & goto :eof
mkdir "!dir!" 2>nul && echo !dir! created. || echo Error: Create failed.
goto :eof

:cmd_rem
set /p "comment=Enter comment: "
if not defined comment echo Error: No comment. & goto :eof
:: !comment!
goto :eof

:cmd_rmdir
echo Error: RMDIR not supported in this environment.
pause
goto :eof

:cmd_dosver
echo LogDOS Version: !version!
echo LogOS Version: !os_version!
pause
goto :eof

:cmd_mode
echo Error: Mode change not supported. Use LogOS.
goto :eof

:cmd_color
color /?
set /p "code=Enter color code (e.g., 0a): "
if defined code color !code! 2>nul && echo Color changed. || echo Error: Invalid code.
goto :eof

:cmd_rename
set /p "oldname=Enter current file name: "
if not defined oldname echo Error: No file name. & goto :eof
if not exist "!oldname!" echo Error: "!oldname!" not found. & goto :eof
set /p "newname=Enter new file name: "
if not defined newname echo Error: No new name. & goto :eof
ren "!oldname!" "!newname!" 2>nul && echo Renamed to !newname!. || echo Error: Rename failed.
goto :eof

:cmd_copycon
set /p "filename=Enter file name: "
if not defined filename echo Error: No file name. & goto :eof
echo Enter text (Ctrl+Z to finish):
copy con "!filename!" >nul
if exist "!filename!" echo File !filename! created. else echo Error: File creation failed.
goto :eof

:cmd_move
set /p "source=Enter source file: "
if not defined source echo Error: No source. & goto :eof
if not exist "!source!" echo Error: "!source!" not found. & goto :eof
set /p "dest=Enter destination: "
if not defined dest echo Error: No destination. & goto :eof
move "!source!" "!dest!" 2>nul && echo Moved to !dest!. || echo Error: Move failed.
goto :eof

:cmd_attrib
set /p "file=Enter file name: "
if not defined file echo Error: No file name. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
attrib "!file!"
goto :eof

:cmd_find
set /p "file=Enter file name: "
if not defined file echo Error: No file name. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
set /p "text=Enter text to find: "
if not defined text echo Error: No text. & goto :eof
find "!text!" "!file!" 2>nul || echo Error: Search failed.
goto :eof

:cmd_findstr
set /p "file=Enter file name: "
if not defined file echo Error: No file name. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
set /p "pattern=Enter search pattern: "
if not defined pattern echo Error: No pattern. & goto :eof
findstr "!pattern!" "!file!" 2>nul || echo Error: Search failed.
goto :eof

:cmd_more
set /p "file=Enter file name: "
if not defined file echo Error: No file name. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
more < "!file!" 2>nul || echo Error: Cannot display.
goto :eof

:cmd_path
set /p "newpath=Enter new PATH (Enter to display): "
if not defined newpath (
    echo Current PATH: !path!
) else (
    set "path=!newpath!"
    echo PATH set to !path!.
)
goto :eof

:cmd_prompt
set /p "newprompt=Enter new prompt (Enter to reset): "
if not defined newprompt (
    prompt $p$g
    echo Prompt reset.
) else (
    prompt !newprompt!
    echo Prompt changed to !newprompt!.
)
goto :eof

:cmd_replace
set /p "source=Enter source file: "
if not defined source echo Error: No source. & goto :eof
if not exist "!source!" echo Error: "!source!" not found. & goto :eof
set /p "dest=Enter destination file: "
if not defined dest echo Error: No destination. & goto :eof
replace "!source!" "!dest!" 2>nul && echo Replaced successfully. || echo Error: Replace failed.
goto :eof

:cmd_sort
set /p "file=Enter file name: "
if not defined file echo Error: No file name. & goto :eof
if not exist "!file!" echo Error: "!file!" not found. & goto :eof
sort < "!file!" 2>nul || echo Error: Sort failed.
goto :eof

:cmd_subst
set /p "drive=Enter drive letter (e.g., X:): "
if not defined drive echo Error: No drive. & goto :eof
set /p "path=Enter path to substitute: "
if not defined path echo Error: No path. & goto :eof
subst "!drive!" "!path!" 2>nul && echo Substituted !drive! to !path!. || echo Error: Substitution failed.
goto :eof

:cmd_ver
ver
goto :eof

:cmd_vol
vol 2>nul || echo Error: Cannot display volume.
goto :eof

:cmd_label
set /p "label=Enter new disk label: "
if not defined label echo Error: No label. & goto :eof
label !label! 2>nul && echo Label set to !label!. || echo Error: Label change failed.
goto :eof

:cmd_backup
set /p "source=Enter source file: "
if not defined source echo Error: No source. & goto :eof
if not exist "!source!" echo Error: "!source!" not found. & goto :eof
set /p "backup=Enter backup name: "
if not defined backup echo Error: No backup name. & goto :eof
copy "!source!" "!backup!.bak" 2>nul && echo Backup created as !backup!.bak. || echo Error: Backup failed.
goto :eof

:cmd_restore
set /p "backup=Enter backup file (e.g., filename.bak): "
if not defined backup echo Error: No backup file. & goto :eof
if not exist "!backup!" echo Error: "!backup!" not found. & goto :eof
set /p "dest=Enter destination file: "
if not defined dest echo Error: No destination. & goto :eof
copy "!backup!" "!dest!" 2>nul && echo Restored to !dest!. || echo Error: Restore failed.
goto :eof

:cmd_comp
set /p "file1=Enter first file: "
if not defined file1 echo Error: No first file. & goto :eof
if not exist "!file1!" echo Error: "!file1!" not found. & goto :eof
set /p "file2=Enter second file: "
if not defined file2 echo Error: No second file. & goto :eof
if not exist "!file2!" echo Error: "!file2!" not found. & goto :eof
comp "!file1!" "!file2!" 2>nul && echo Files are identical. || echo Files differ.
goto :eof

:cmd_fc
set /p "file1=Enter first file: "
if not defined file1 echo Error: No first file. & goto :eof
if not exist "!file1!" echo Error: "!file1!" not found. & goto :eof
set /p "file2=Enter second file: "
if not defined file2 echo Error: No second file. & goto :eof
if not exist "!file2!" echo Error: "!file2!" not found. & goto :eof
fc "!file1!" "!file2!" 2>nul || echo Error: Comparison failed.
goto :eof

:cmd_editenv
set /p "var=Enter variable name: "
if not defined var echo Error: No variable name. & goto :eof
set /p "val=Enter new value: "
if defined val (
    set "!var!=!val!"
    echo !var! set to !val!.
) else (
    if defined !var! echo !var!=!%var%! & goto :eof
    echo Error: Variable !var! not found.
)
goto :eof

:cmd_pause
echo Press any key to continue...
pause >nul
goto :eof

:cmd_resume
echo Resuming (simulated)...
goto :eof

:cmd_restart
echo Restarting LogDOS...
goto :dosloop

:cmd_shutdown
echo Shutting down LogDOS (simulated)...
echo System halted. Press any key to exit.
pause >nul
exit /b
goto :eof

:cmd_logclear
echo Clearing command history...
if exist "!logfile!" (
    del "!logfile!" 2>nul && echo History cleared. || echo Error: Failed to clear history.
) else (
    echo No history to clear.
)
goto :eof

:cmd_diskinfo
if exist "DISK1.cmd" (
    call "DISK1.cmd" info 2>nul && echo Disk info displayed. || echo Error: Disk info failed.
) else (
    echo Error: DISK1.cmd not found.
)
pause
goto :eof

:cmd_partinfo
if exist "recpart.cmd" (
    call "recpart.cmd" info 2>nul && echo Partition info displayed. || echo Error: Partition info failed.
) else (
    echo Error: recpart.cmd not found.
)
pause
goto :eof

:cmd_defrag
if exist "DISK1.cmd" (
    call "DISK1.cmd" defrag 2>nul && echo Defragmentation simulated. || echo Error: Defrag failed.
) else (
    echo Error: DISK1.cmd not found.
)
pause
goto :eof

:cmd_recover
if exist "DISK1.cmd" (
    call "DISK1.cmd" recover 2>nul && echo Recovery attempted. || echo Error: Recovery failed.
) else (
    echo Error: DISK1.cmd not found. Use LogOS recovery tools.
)
pause
goto :eof

:cmd_sysinfo
echo Extended System Info
echo -------------------
echo LogDOS Version: !version!
echo LogOS Version: !os_version!
echo Kernel Version: !kernel_version!
echo Date: %date%
echo Time: %time%
echo Memory: Simulated 64MB (use DISK1.cmd for details)
pause
goto :eof

:recovery
echo Exiting to recovery...
exit /b

:boot
echo Exiting to boot...
exit /b

:logedit
ECHO LOADING THE LOGDOS TEXT EDITOR
ECHO PLEASE WAIT
ping 3>nul
cls
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo.
echo.
echo.
echo.
echo.
echo                      ллллллллллллллллллллллллллллллл
echo                      лSelect a file              лXл
echo                      ллллллллллллллллллллллллллллллл
echo                      лPlease type in the name of   л
echo                      лThe file you are trying to   л
echo                      лedit or type a new name to   л
echo                      лMake a new file              л
echo                      ллллллллллллллллллллллллллллллл
set /p file=""
cls
goto enterloop
:enterloop
cls
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
goto loop
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л Editing %file%
echo.
:loop
set /p input=""
if %input%==1 goto editfile
if %input%==2 goto editedit
if %input%==3 goto toolsedit
echo %input% >> %file% 
goto loop
:editfile
cls
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo лллллллл
echo 1 edit л
echo 2 exit л
echo 3 cont л
echo лллллллл
choice /c 123 >nul
if %ERRORLEVEL%==1 goto editfileeditingoptions
if %ERRORLEVEL%==2 goto LogDOS
if %ERRORLEVEL%==3 goto enterloop
:editfileeditingoptions
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo лллллллл
echo 1 edit л
echo 2 exit л
echo 3 cont л
echo лллллллл         лллллллллллллллллллллллллллллллллллл
echo                  лEditor file options             лXл
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л                                  л
echo                  л 1 Save file and switch files     л
echo                  л 2 Save file and exit             л
echo                  л 3 Exit and delete file           л
echo                  л 4 Switch files without saving    л
echo                  л                                  л 
echo                  лллллллллллллллллллллллллллллллллллл
choice /c 1234X >NUL
if %ERRORLEVEL%==1 goto edit
if %ERRORLEVEL%==2 goto desktop
if %ERRORLEVEL%==3 (
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo лллллллл
echo 1 edit л
echo 2 exit л
echo 3 cont л
echo лллллллл         лллллллллллллллллллллллллллллллллллл
echo                  лEditor file options             лXл
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л                                  л
echo                  л are you sure you want to delete  л
echo                  л your file?                       л
echo                  л If you delete your file it wont  л
echo                  л be reoverable.                   л
echo                  л                     [YES] [NO]   л 
echo                  лллллллллллллллллллллллллллллллллллл
choice /c YN >nul
if %ERRORLEVEL%==1 del %file%
if %ERRORLEVEL%==2 goto enterloop

echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo лллллллл
echo 1 edit л
echo 2 exit л
echo 3 cont л
echo лллллллл         лллллллллллллллллллллллллллллллллллл
echo                  лEditor file options               л
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л                                  л
echo                  л File deleted succesfully         л
echo                  л Going to desktop                 л
echo                  л                                  л
echo                  л                                  л 
echo                  лллллллллллллллллллллллллллллллллллл
ping 1>nul
ping 1>nul
ping 1>nul
ping 1>nul
cls
goto desktop
)
if %ERRORLEVEL%==4 (
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo лллллллл
echo 1 edit л
echo 2 exit л
echo 3 cont л
echo лллллллл         лллллллллллллллллллллллллллллллллллл
echo                  лEditor file options             лXл
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л                                  л
echo                  л are you sure you want to delete  л
echo                  л your file?                       л
echo                  л If you delete your file it wont  л
echo                  л be reoverable.                   л
echo                  л                     [YES] [NO]   л 
echo                  лллллллллллллллллллллллллллллллллллл
choice /c YN >nul
if %ERRORLEVEL%==1 del %file%
if %ERRORLEVEL%==2 goto enterloop

echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo лллллллл
echo 1 edit л
echo 2 exit л
echo 3 cont л
echo лллллллл         лллллллллллллллллллллллллллллллллллл
echo                  лEditor file options               л
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л                                  л
echo                  л File deleted succesfully         л
echo                  л Going to file select             л
echo                  л                                  л
echo                  л                                  л 
echo                  лллллллллллллллллллллллллллллллллллл
ping 1>nul
ping 1>nul
ping 1>nul
ping 1>nul
cls
goto edit
:editedit
cls
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo        лллллллллл 
echo 
echo 
echo 
echo                  лллллллллллллллллллллллллллллллллллл
echo                  лEditor options                  лXл
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л1 change color                    л
echo                  л2 goto file options               л
echo                  л3 goto tools                      л
echo                  л4 change font                     л
echo                  л                                  л
echo                  лллллллллллллллллллллллллллллллллллл
choice /c 1234xm >nul
if %ERRORLEVEL%==1 goto colorchangeedit
if %ERRORLEVEL%==2 goto editfile
if %ERRORLEVEL%==3 goto toolsedit
if %ERRORLEVEL%==4 goto fontchange
:toolsedit
cls
cls
echo лллллллллллллллллллллллллллллLogOS editorллллллллллллллллллллллллллллл
echo 1 File л 2 Edit л 3 Tools л
echo        лллллллллл 
echo 
echo 
echo 
echo                  лллллллллллллллллллллллллллллллллллл
echo                  лEditor options                  лXл
echo                  лллллллллллллллллллллллллллллллллллл
echo                  л No editor tools downloaded       л
echo                  л                              [OK]л
echo                  л                                  л
echo                  лллллллллллллллллллллллллллллллллллл
pause 1>nul
pause 1>nul
pause 1>nul
pause 1>nul
pause 1>nul
goto enterloop
:colorchangeedit
cls
color help
echo type the color code from here that you want
echo this will require a restart of edit tho
set /p editcolor=""
echo color %editcolor% > coloredit.cmd
goto edit