@ECHO OFF
set instance=%1

net stop smpbatch%instance%_$backtest
net stop smpbatch%instance%_$jobwkshbk
net stop smpbatch%instance%_$rslt_pipe

net stop smpWCF%instance%
net stop smptq%instance%
net stop smp%instance%
net stop SMDaemon%instance%
net stop smplock%instance%

