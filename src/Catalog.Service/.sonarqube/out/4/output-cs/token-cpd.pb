…

’/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Messages/DependencyInjection.cs
	namespace 	
Infrastructure
 
. 
Messages !
;! "
public		 
static		 
class		 
DependencyInjection		 '
{

 
public 

static 
IServiceCollection $5
)ConfigureInfrastructureMessageBusServices% N
(N O
this 
IServiceCollection 
services  (
,( )
MessageBusOptions 
options !
)! "
{ 
services 
. 
	AddScoped 
< 
IMessageSender %
,% &
MessageSender' 4
>4 5
(5 6
)6 7
. 
AddAzureClients 
( 
builder $
=>% '
{ 
builder 
. 
AddServiceBusClient +
(+ ,
options, 3
.3 4&
MessageBusConnectionString4 N
)N O
;O P
} 
) 
; 
return 
services 
; 
} 
} ï
˜/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Messages/Options/MessageBusOptions.cs
	namespace 	
Infrastructure
 
. 
Messages !
.! "
Options" )
;) *
public 
class 
MessageBusOptions 
{ 
public 

string &
MessageBusConnectionString ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
=; <
null= A
!A B
;B C
} À
•/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Messages/Services/MessageSender.cs
	namespace 	
Infrastructure
 
. 
Messages !
.! "
Services" *
;* +
internal 
class	 
MessageSender 
( 
ServiceBusClient -
	busClient. 7
)7 8
:9 :
IMessageSender; I
{		 
public

 

async

 
Task

 
SendMessage

 !
(

! "
string

" (
	queueName

) 2
,

2 3
BaseMessage

4 ?
message

@ G
,

G H
CancellationToken

I Z
cancellationToken

[ l
)

l m
{ 
var 
sender 
= 
	busClient 
. 
CreateSender +
(+ ,
	queueName, 5
)5 6
;6 7
var 
payload 
= 
JsonSerializer $
.$ %
	Serialize% .
(. /
message/ 6
)6 7
;7 8
var 

busMessage 
= 
new 
ServiceBusMessage .
(. /
payload/ 6
)6 7
;7 8
await 
sender 
. 
SendMessagesAsync &
(& '
[' (

busMessage( 2
]2 3
,3 4
cancellationToken5 F
)F G
;G H
} 
} 