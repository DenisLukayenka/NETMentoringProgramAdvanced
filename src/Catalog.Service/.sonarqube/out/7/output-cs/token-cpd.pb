†
ƒ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Maintanance/GlobalUsings.cs†
–/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Maintanance/OutboxEvents/SendOutboxMessages.cs
	namespace 	
API
 
. 
Maintanance 
. 
OutboxEvents &
;& '
public 
class 
SendOutboxMessages 
(  
ILogger  '
<' (
SendOutboxMessages( :
>: ;
logger< B
,B C
	IMediatorD M
senderN T
)T U
{ 
[ 
Function 
( 
$str "
)" #
]# $
public 

async 
Task 
< 
IActionResult #
># $
Run% (
(( )
[) *
TimerTrigger* 6
(6 7
$str7 F
)F G
]G H
	TimerInfoI R
myTimerS Z
)Z [
{		 
logger

 
.

 
LogInformation

 
(

 
$str

 9
,

9 :
nameof

; A
(

A B
SendOutboxMessages

B T
)

T U
)

U V
;

V W
var 
command 
= 
new %
SendOutboxMessagesCommand 3
(3 4
)4 5
;5 6
await 
sender 
. 
Send 
( 
command !
)! "
;" #
if 

( 
myTimer 
. 
ScheduleStatus "
is# %
not& )
null* .
). /
logger 
. 
LogInformation !
(! "
$str" O
,O P
myTimerQ X
.X Y
ScheduleStatusY g
.g h
Nexth l
)l m
;m n
return 
new 
OkObjectResult !
(! "
true" &
)& '
;' (
} 
} ˜
~/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Maintanance/Program.cs
var		 
host		 
=			 

new		 
HostBuilder		 
(		 
)		 
.

 ,
 ConfigureFunctionsWebApplication

 %
(

% &
)

& '
. 
ConfigureServices 
( 
( 
context 
,  
services! )
)) *
=>+ -
{ 
services 
. 8
,AddApplicationInsightsTelemetryWorkerService =
(= >
)> ?
;? @
services 
. 1
%ConfigureFunctionsApplicationInsights 6
(6 7
)7 8
;8 9
var 
messageBusOptions 
= 
new  #
MessageBusOptions$ 5
(5 6
)6 7
;7 8
context 
. 
Configuration 
. 
Bind "
(" #
messageBusOptions# 4
)4 5
;5 6
var 

sqlOptions 
= 
new 
SqlDatabaseOptions /
(/ 0
)0 1
;1 2
context 
. 
Configuration 
. 
Bind "
(" #

sqlOptions# -
)- .
;. /
services 
. +
ConfigureInfrastructureServices 0
(0 1

sqlOptions1 ;
); <
;< =
services 
. 5
)ConfigureInfrastructureMessageBusServices :
(: ;
messageBusOptions; L
)L M
;M N
services 
.  
ConfigureAppServices %
(% &
)& '
;' (
} 
) 
. 
Build 

(
 
) 
; 
host 
. 
Run 
( 	
)	 

;
 