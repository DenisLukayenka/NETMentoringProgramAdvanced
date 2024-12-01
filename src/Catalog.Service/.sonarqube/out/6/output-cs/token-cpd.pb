º
ç/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Categories/CreateCategory.cs
	namespace 	
API
 
. 
Commands 
. 

Categories !
;! "
public 
class 
CreateCategory 
( 
ILogger #
<# $
CreateCategory$ 2
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
$str		3 9
,		9 :
Route		; @
=		A B
$str		C O
)		O P
]		P Q
HttpRequest		R ]
req		^ a
,		a b
[

 	
FromBody

	 
]

 !
CreateCategoryCommand

 (
command

) 0
,

0 1
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
(A B
CreateCategoryB P
)P Q
)Q R
;R S
var 
category 
= 
await 
sender #
.# $
Send$ (
(( )
command) 0
,0 1
cancellationToken2 C
)C D
;D E
return 
new 
OkObjectResult !
(! "
category" *
)* +
{ 	

StatusCode 
= 
( 
int 
) 
HttpStatusCode ,
., -
Created- 4
} 	
;	 

} 
} °
ç/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Categories/DeleteCategory.cs
	namespace 	
API
 
. 
Commands 
. 

Categories !
;! "
public 
class 
DeleteCategory 
( 
ILogger #
<# $
UpdateCategory$ 2
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
$str		3 ;
,		; <
Route		= B
=		C D
$str		E b
)		b c
]		c d
HttpRequest		e p
req		q t
,		t u
int

 

categoryId

 
,

 
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
(A B
DeleteCategoryB P
)P Q
)Q R
;R S
var 
command 
= 
new !
DeleteCategoryCommand /
(/ 0

categoryId0 :
): ;
;; <
await 
sender 
. 
Send 
( 
command !
,! "
cancellationToken# 4
)4 5
;5 6
return 
new 
OkResult 
( 
) 
; 
} 
} ¥
ç/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Categories/UpdateCategory.cs
	namespace 	
API
 
. 
Commands 
. 

Categories !
;! "
public 
class 
UpdateCategory 
( 
ILogger #
<# $
UpdateCategory$ 2
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
$str		B _
)		_ `
]		` a
HttpRequest		b m
req		n q
,		q r
[

 	
FromBody

	 
]

 !
UpdateCategoryCommand

 (
command

) 0
,

0 1
int 

categoryId 
, 
CancellationToken 
cancellationToken +
)+ ,
{ 
logger 
. 
LogInformation 
( 
$str 9
,9 :
nameof; A
(A B
UpdateCategoryB P
)P Q
)Q R
;R S
command 
= 
command 
with 
{ 	

CategoryId 
= 

categoryId #
,# $
} 	
;	 

await 
sender 
. 
Send 
( 
command !
,! "
cancellationToken# 4
)4 5
;5 6
return 
new 
OkResult 
( 
) 
; 
} 
} É
Ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/GlobalUsings.cs±
ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Products/CreateProduct.cs
	namespace 	
API
 
. 
Commands 
. 
Products 
;  
public 
class 
CreateProduct 
( 
ILogger "
<" #
CreateProduct# 0
>0 1
logger2 8
,8 9
	IMediator: C
senderD J
)J K
{ 
[ 
Function 
( 
$str 
) 
] 
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
$str		3 9
,		9 :
Route		; @
=		A B
$str		C M
)		M N
]		N O
HttpRequest		P [
req		\ _
,		_ `
[

 	
FromBody

	 
]

  
CreateProductCommand

 '
command

( /
,

/ 0
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
(A B
CreateProductB O
)O P
)P Q
;Q R
var 
product 
= 
await 
sender "
." #
Send# '
(' (
command( /
,/ 0
cancellationToken1 B
)B C
;C D
return 
new 
OkObjectResult !
(! "
product" )
)) *
{ 	

StatusCode 
= 
( 
int 
) 
HttpStatusCode ,
., -
Created- 4
} 	
;	 

} 
} ñ
ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Products/DeleteProduct.cs
	namespace 	
API
 
. 
Commands 
. 
Products 
;  
public 
class 
DeleteProduct 
( 
ILogger "
<" #
DeleteProduct# 0
>0 1
logger2 8
,8 9
	IMediator: C
senderD J
)J K
{ 
[ 
Function 
( 
$str 
) 
] 
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
$str		3 ;
,		; <
Route		= B
=		C D
$str		E _
)		_ `
]		` a
HttpRequest		b m
req		n q
,		q r
int

 
	productId

 
,

 
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
(A B
DeleteProductB O
)O P
)P Q
;Q R
var 
command 
= 
new  
DeleteProductCommand .
(. /
	productId/ 8
)8 9
;9 :
await 
sender 
. 
Send 
( 
command !
,! "
cancellationToken# 4
)4 5
;5 6
return 
new 
OkResult 
( 
) 
; 
} 
} ô
ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Products/UpdateProduct.cs
	namespace 	
API
 
. 
Commands 
. 
Products 
;  
public 
class 
UpdateProduct 
( 
ILogger "
<" #
UpdateProduct# 0
>0 1
logger2 8
,8 9
	IMediator: C
senderD J
)J K
{ 
[ 
Function 
( 
$str 
) 
] 
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
$str		B \
)		\ ]
]		] ^
HttpRequest		_ j
req		k n
,		n o
[

 	
FromBody

	 
]

  
UpdateProductCommand

 '
command

( /
,

/ 0
int 
	productId 
, 
CancellationToken 
cancellationToken +
)+ ,
{ 
logger 
. 
LogInformation 
( 
$str 9
,9 :
nameof; A
(A B
UpdateProductB O
)O P
)P Q
;Q R
command 
= 
command 
with 
{ 	
	ProductId 
= 
	productId !
} 	
;	 

await 
sender 
. 
Send 
( 
command !
,! "
cancellationToken# 4
)4 5
;5 6
return 
new 
OkResult 
( 
) 
; 
} 
} •
{/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/API.Commands/Program.cs
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
 