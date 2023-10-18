@echo off

set burn_mcu=
set mcu_img=
set burn_app=
set app_img=
set port=%1
set pkg_path=C:\Program Files (x86)\Altair Semiconductor\BranFlakes\BF_CORE_02_02_00_00_34161
set pkg_avas_path=C:\Program Files (x86)\Altair Semiconductor\BranFlakes\BF_AVAS_02_02_00_00_34161
rem for /F %%a in ('echo prompt $E ^| cmd') do set "_esc=%%a"
rem set _coloroff=%_esc%[0m

:loop

if /i "%1" == "m" (
	set burn_mcu=/a0
	set mcu_img=%2
)
if /i "%1" == "a" (
	set burn_app="/3" 
	set app_img=%2
)
shift
if not "%1"=="" (
	goto loop
)

start ImageBurnTool.exe -v "%pkg_path%" %burn_app% D:\vmshare\%app_img% -va "%pkg_avas_path%" %burn_mcu% D:\vmshare\%mcu_img%  -uartparams 0 %port%% 3000000 1
timeout 1
python D:\tool\ftdiapi.py shutdown

rem %_esc%[31m
echo [31m
echo Path:
echo %pkg_path%
echo %pkg_avas_path%
echo Burning img to COM%port%
echo images path: D:\vmshare\
echo images:
echo %mcu_img% %app_img%
rem %_coloroff%
echo [0m