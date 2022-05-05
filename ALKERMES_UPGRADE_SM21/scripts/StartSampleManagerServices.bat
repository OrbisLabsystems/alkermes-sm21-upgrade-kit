@ECHO OFF
set instance=%1

net start smplock%instance%
net start smp%instance%
net start smptq%instance%
net start SMDaemon%instance%
net start smpWCF%instance%

net start smpbatch%instance%_$backtest
net start smpbatch%instance%_$jobwkshbk
net start smpbatch%instance%_$rslt_pipe




