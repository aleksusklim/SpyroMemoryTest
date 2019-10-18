@set p=%~dp0
@cd ..\..\..\frameworks\
@set j=@java -Xrs -Xmx400000000 -Xms10000000 -jar ..\lib\mxmlc.jar -load-config="%p%flex-config-make.xml"
%j% "%p%main.as"
@cd %p%
pause

