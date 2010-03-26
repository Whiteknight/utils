@echo off
if exist .svn goto have_dot_svn
goto _end
:have_dot_svn
svn up
:_end
@echo on