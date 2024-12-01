 
å/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Queries/Categories/ListCategories.cs
	namespace 	
API
 
. 
Queries 
. 

Categories  
;  !
public 
class 
ListCategories 
( 
ILogger #
<# $
ListCategories$ 2
>2 3
logger4 :
,: ;
	IMediator< E
senderF L
)L M
{ 
[ 
Function 
( 
$str 
) 
]  
public 

async 
Task 
< 
IActionResult #
># $
Run% (
(( )
[		 	
HttpTrigger			 
(		 
AuthorizationLevel		 '
.		' (
	Anonymous		( 1
,		1 2
$str		3 8
,		8 9
Route		: ?
=		@ A
$str		B N
)		N O
]		O P
HttpRequest		Q \
req		] `
,		` a
CancellationToken

 
cancellationToken

 +
)

+ ,
{ 
logger 
. 
LogInformation 
( 
$str 9
,9 :
nameof; A
(A B
ListCategoriesB P
)P Q
)Q R
;R S
var 

categories 
= 
await 
sender %
.% &
Send& *
(* +
new+ .
ListCategoriesQuery/ B
(B C
)C D
,D E
cancellationTokenF W
)W X
;X Y
return 
new 
OkObjectResult !
(! "

categories" ,
), -
;- .
} 
} Å
/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Queries/GlobalUsings.cs‰
à/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Queries/Products/ListProducts.cs
	namespace 	
API
 
. 
Queries 
. 
Products 
; 
public 
class 
ListProducts 
( 
ILogger !
<! "
ListProducts" .
>. /
logger0 6
,6 7
	IMediator8 A
senderB H
)H I
{ 
[ 
Function 
( 
$str 
) 
] 
public 

async 
Task 
< 
IActionResult #
># $
Run% (
(( )
[		 	
HttpTrigger			 
(		 
AuthorizationLevel		 '
.		' (
	Anonymous		( 1
,		1 2
$str		3 8
,		8 9
Route		: ?
=		@ A
$str		B ^
)		^ _
]		_ `
HttpRequest		a l
req		m p
,		p q
int

 
?

 

categoryId

 
,

 
CancellationToken 
cancellationToken +
)+ ,
{ 
logger 
. 
LogInformation 
( 
$str 9
,9 :
nameof; A
(A B
ListProductsB N
)N O
)O P
;P Q
var 
currentPage 
= 
GetQueryParam '
(' (
req( +
,+ ,
nameof- 3
(3 4
ListProductsQuery4 E
.E F
CurrentPageF Q
)Q R
)R S
;S T
var 
pageSize 
= 
GetQueryParam $
($ %
req% (
,( )
nameof* 0
(0 1
ListProductsQuery1 B
.B C
PageSizeC K
)K L
)L M
;M N
var 
products 
= 
await 
sender #
.# $
Send$ (
(( )
new) ,
ListProductsQuery- >
(> ?

categoryId? I
,I J
currentPageK V
,V W
pageSizeX `
)` a
,a b
cancellationTokenc t
)t u
;u v
return 
new 
OkObjectResult !
(! "
products" *
)* +
;+ ,
} 
private 
static 
int 
? 
GetQueryParam %
(% &
HttpRequest& 1
req2 5
,5 6
string7 =
key> A
)A B
{ 
int 
? 
value 
= 
null 
; 
if 

( 
int 
. 
TryParse 
( 
req 
. 
Query "
[" #
key# &
]& '
.' (
ToString( 0
(0 1
)1 2
,2 3
out4 7
var8 ;
parsedValue< G
)G H
)H I
value 
= 
parsedValue 
;  
return 
value 
; 
} 
} §
z/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Queries/Program.cs
var 
host 
=	 

new 
HostBuilder 
( 
) 
. ,
 ConfigureFunctionsWebApplication %
(% &
)& '
. 
ConfigureServices 
( 
( 
context 
,  
services! )
)) *
=>+ -
{		 
services

 
.

 8
,AddApplicationInsightsTelemetryWorkerService

 =
(

= >
)

> ?
;

? @
services 
. 1
%ConfigureFunctionsApplicationInsights 6
(6 7
)7 8
;8 9
var 

sqlOptions 
= 
new 
SqlDatabaseOptions /
(/ 0
)0 1
;1 2
context 
. 
Configuration 
. 
Bind "
(" #

sqlOptions# -
)- .
;. /
services 
.  
ConfigureAppServices %
(% &
)& '
;' (
services 
. +
ConfigureInfrastructureServices 0
(0 1

sqlOptions1 ;
); <
;< =
} 
) 
. 
Build 

(
 
) 
; 
host 
. 
Run 
( 	
)	 

;
 