REM ***  System specific variables - NEED TO BE CHANGED
REM *****************************************************
set server=WIN-VUQTGOQFUSH\VGSM
set db=SM21
set indir=C:\Users\Administrator\Desktop\sql_server_input\
set outdir=C:\Users\Administrator\Desktop\sql_server_output\
REM
REM ***  Create SQL Server verification files 
REM *****************************************************
REM sqlcmd options:
REM -s = column separator, -h-1 = No headers, -W = remove trailing spaces
REM
echo "Creating SQL Server data verification files!"
sqlcmd -S %server% -d %db% -i %indir%sql_job_template.sql -o %outdir%sql_job_template.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_samp_tmpl_header.sql -o %outdir%sql_samp_tmpl_header.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_mlp_level.sql -o %outdir%sql_mlp_level.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_test_sched.sql -o %outdir%sql_test_sched.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_job_header.sql -o %outdir%sql_job_header.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_sample.sql -o %outdir%sql_sample.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_test.sql -o %outdir%sql_test.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_result.sql -o %outdir%sql_result.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_mlp_header.sql -o %outdir%sql_mlp_header.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_mlp_components.sql -o %outdir%sql_mlp_components.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_versioned_analysis.sql -o %outdir%sql_versioned_analysis.txt -s "," -h-1 -W
sqlcmd -S %server% -d %db% -i %indir%sql_template_fields.sql -o %outdir%sql_template_fields.txt -s "," -h-1 -W
echo "SQL Server data verification files created!"
