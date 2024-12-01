∏
®/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Commands/CreateCategory/CreateCategory.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Commands% -
.- .
CreateCategory. <
;< =
public 
record !
CreateCategoryCommand #
(# $
string$ *
Name+ /
,/ 0
string1 7
?7 8
Image9 >
,> ?
int@ C
?C D
ParentCategoryIdE U
)U V
:W X
IRequestY a
<a b
Categoryb j
>j k
;k l
public 
class (
CreateCategoryCommandHandler )
() *
ICategoryRepository* =

repository> H
)H I
:J K
IRequestHandlerL [
<[ \!
CreateCategoryCommand\ q
,q r
Categorys {
>{ |
{ 
public		 

async		 
Task		 
<		 
Category		 
>		 
Handle		  &
(		& '!
CreateCategoryCommand		' <
request		= D
,		D E
CancellationToken		F W
cancellationToken		X i
)		i j
{

 
Category 
? 
parentCategory  
=! "
null# '
;' (
if 

( 
request 
. 
ParentCategoryId $
.$ %
HasValue% -
)- .
{ 	
parentCategory 
= 
await "

repository# -
.- .
Get. 1
(1 2
request2 9
.9 :
ParentCategoryId: J
.J K
ValueK P
,P Q
cancellationTokenR c
)c d
;d e
if 
( 
parentCategory 
is !
null" &
)& '
throw 
new #
EntityNotFoundException 1
(1 2
)2 3
;3 4
} 	
var 
entity 
= 
new 
Category !
(! "
)" #
{ 	
Name 
= 
request 
. 
Name 
,  
Image 
= 
request 
. 
Image !
,! "
ParentCategoryId 
= 
parentCategory -
?- .
.. /
Id/ 1
} 	
;	 

entity 
= 
await 

repository !
.! "
Add" %
(% &
entity& ,
,, -
cancellationToken. ?
)? @
;@ A
return 
entity 
; 
} 
} ì
∏/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Commands/CreateCategory/CreateCategoryCommandValidator.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Commands% -
.- .
CreateCategory. <
;< =
internal 
class	 *
UpdateCategoryCommandValidator -
:. /
AbstractValidator0 A
<A B!
CreateCategoryCommandB W
>W X
{ 
public 
*
UpdateCategoryCommandValidator )
() *
)* +
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 
Name		 
)		 
.

 
Cascade

 
(

 
CascadeMode

  
.

  !
Stop

! %
)

% &
. 
NotEmpty 
( 
) 
. 
MaximumLength 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
Must 
( 
value 
=> 
value  
.  !

IsValidUrl! +
(+ ,
), -
)- .
. 
When 
( 
x 
=> 
! 
string 
. 
IsNullOrEmpty ,
(, -
x- .
.. /
Image/ 4
)4 5
)5 6
. 
WithMessage 
( 
$str =
)= >
;> ?
} 
} ©
®/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Commands/DeleteCategory/DeleteCategory.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Commands% -
.- .
DeleteCategory. <
;< =
public 
record !
DeleteCategoryCommand #
(# $
int$ '

CategoryId( 2
)2 3
:4 5
IRequest6 >
;> ?
public 
class (
DeleteCategoryCommandHandler )
() *
ICategoryRepository* =

repository> H
)H I
:J K
IRequestHandlerL [
<[ \!
DeleteCategoryCommand\ q
>q r
{ 
public 

async 
Task 
Handle 
( !
DeleteCategoryCommand 2
request3 :
,: ;
CancellationToken< M
cancellationTokenN _
)_ `
{ 
var		 
entity		 
=		 
await		 

repository		 %
.		% &
Get		& )
(		) *
request		* 1
.		1 2

CategoryId		2 <
,		< =
cancellationToken		> O
)		O P
;		P Q
if 

( 
entity 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
var 
dependentCategories 
=  !
await" '

repository( 2
.2 3
List3 7
(7 8
entity8 >
.> ?
Id? A
,A B
cancellationTokenC T
)T U
;U V
entity 
. 
ChildCategories 
=  
dependentCategories! 4
;4 5
await 

repository 
. 
Delete 
(  
entity  &
,& '
cancellationToken( 9
)9 :
;: ;
} 
} á
®/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Commands/UpdateCategory/UpdateCategory.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Commands% -
.- .
UpdateCategory. <
;< =
public 
record !
UpdateCategoryCommand #
(# $
int$ '

CategoryId( 2
,2 3
string4 :
?: ;
Name< @
,@ A
stringB H
?H I
ImageJ O
)O P
:Q R
IRequestS [
;[ \
public 
class (
UpdateCategoryCommandHandler )
() *
ICategoryRepository* =

repository> H
)H I
:J K
IRequestHandlerL [
<[ \!
UpdateCategoryCommand\ q
>q r
{ 
public 

async 
Task 
Handle 
( !
UpdateCategoryCommand 2
request3 :
,: ;
CancellationToken< M
cancellationTokenN _
)_ `
{ 
var		 
entity		 
=		 
await		 

repository		 %
.		% &
Get		& )
(		) *
request		* 1
.		1 2

CategoryId		2 <
,		< =
cancellationToken		> O
)		O P
;		P Q
if 

( 
entity 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
if 

( 
! 
string 
. 
IsNullOrEmpty !
(! "
request" )
.) *
Name* .
). /
)/ 0
{ 	
entity 
. 
Name 
= 
request !
.! "
Name" &
;& '
} 	
if 

( 
! 
string 
. 
IsNullOrEmpty !
(! "
request" )
.) *
Image* /
)/ 0
)0 1
{ 	
entity 
. 
Image 
= 
request "
." #
Image# (
;( )
} 	
await 

repository 
. 
Update 
(  
entity  &
,& '
cancellationToken( 9
)9 :
;: ;
} 
} ì
∏/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Commands/UpdateCategory/UpdateCategoryCommandValidator.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Commands% -
.- .
UpdateCategory. <
;< =
internal 
class	 *
UpdateCategoryCommandValidator -
:. /
AbstractValidator0 A
<A B!
UpdateCategoryCommandB W
>W X
{ 
public 
*
UpdateCategoryCommandValidator )
() *
)* +
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 
Name		 
)		 
.

 
Cascade

 
(

 
CascadeMode

  
.

  !
Stop

! %
)

% &
. 
NotEmpty 
( 
) 
. 
MaximumLength 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
Must 
( 
value 
=> 
value  
.  !

IsValidUrl! +
(+ ,
), -
)- .
. 
When 
( 
x 
=> 
! 
string 
. 
IsNullOrEmpty ,
(, -
x- .
.. /
Image/ 4
)4 5
)5 6
. 
WithMessage 
( 
$str =
)= >
;> ?
} 
} ¨
©/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Queries/GetCategoryById/GetCategoryById.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Queries% ,
., -
GetCategoryById- <
;< =
public 
record  
GetCategoryByIdQuery "
(" #
int# &

CategoryId' 1
)1 2
:3 4
IRequest5 =
<= >
Category> F
>F G
;G H
public 
class '
GetCategoryByIdQueryHandler (
(( )
ICategoryRepository) <
categoryRepository= O
)O P
:Q R
IRequestHandlerS b
<b c 
GetCategoryByIdQueryc w
,w x
Category	y Å
>
Å Ç
{ 
public		 

async		 
Task		 
<		 
Category		 
>		 
Handle		  &
(		& ' 
GetCategoryByIdQuery		' ;
request		< C
,		C D
CancellationToken		E V
cancellationToken		W h
)		h i
{

 
var 
category 
= 
await 
categoryRepository /
./ 0
Get0 3
(3 4
request4 ;
.; <

CategoryId< F
,F G
cancellationTokenH Y
)Y Z
;Z [
if 

( 
category 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
return 
category 
; 
} 
} π
ß/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Categories/Queries/ListCategories/ListCategories.cs
	namespace 	
ApplicationCore
 
. 

Categories $
.$ %
Queries% ,
., -
ListCategories- ;
;; <
public 
record 
ListCategoriesQuery !
:" #
IRequest$ ,
<, -
Category- 5
[5 6
]6 7
>7 8
;8 9
public 
class &
ListCategoriesQueryHandler '
(' (
ICategoryRepository( ;
categoryRepository< N
)N O
:P Q
IRequestHandlerR a
<a b
ListCategoriesQueryb u
,u v
Categoryw 
[	 Ä
]
Ä Å
>
Å Ç
{ 
public		 

async		 
Task		 
<		 
Category		 
[		 
]		  
>		  !
Handle		" (
(		( )
ListCategoriesQuery		) <
request		= D
,		D E
CancellationToken		F W
cancellationToken		X i
)		i j
{

 
var 

categories 
= 
await 
categoryRepository 1
.1 2
List2 6
(6 7
null7 ;
,; <
cancellationToken= N
)N O
;O P
return 

categories 
; 
} 
} í
ö/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Behaviors/ValidationBehavior.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !
	Behaviors! *
;* +
public 
class 
ValidationBehavior 
<  
TRequest  (
,( )
	TResponse* 3
>3 4
:5 6
IPipelineBehavior7 H
<H I
TRequestI Q
,Q R
	TResponseS \
>\ ]
where 	
TRequest
 
: 
notnull 
{ 
private 
readonly 
IEnumerable  
<  !

IValidator! +
<+ ,
TRequest, 4
>4 5
>5 6
_validators7 B
;B C
public

 

ValidationBehavior

 
(

 
IEnumerable

 )
<

) *

IValidator

* 4
<

4 5
TRequest

5 =
>

= >
>

> ?

validators

@ J
)

J K
{ 
_validators 
= 

validators  
??! #
[$ %
]% &
;& '
} 
public 

async 
Task 
< 
	TResponse 
>  
Handle! '
(' (
TRequest( 0
request1 8
,8 9"
RequestHandlerDelegate: P
<P Q
	TResponseQ Z
>Z [
next\ `
,` a
CancellationTokenb s
cancellationToken	t Ö
)
Ö Ü
{ 
if 

( 
_validators 
. 
Any 
( 
) 
) 
{ 	
var 
context 
= 
new 
ValidationContext /
</ 0
TRequest0 8
>8 9
(9 :
request: A
)A B
;B C
var 
validationResults !
=" #
await$ )
Task* .
.. /
WhenAll/ 6
(6 7
_validators 
. 
Select "
(" #
v# $
=>% '
v 
. 
ValidateAsync #
(# $
context$ +
,+ ,
cancellationToken- >
)> ?
)? @
)@ A
;A B
var 
failures 
= 
validationResults ,
. 
Where 
( 
r 
=> 
r 
. 
Errors $
.$ %
Count% *
!=+ -
$num. /
)/ 0
. 

SelectMany 
( 
r 
=>  
r! "
." #
Errors# )
)) *
. 
ToList 
( 
) 
; 
if 
( 
failures 
. 
Count 
!= !
$num" #
)# $
throw 
new 
ValidationException -
(- .
failures. 6
)6 7
;7 8
}   	
return"" 
await"" 
next"" 
("" 
)"" 
;"" 
}## 
}$$ £

†/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Exceptions/EntityNotFoundException.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !

Exceptions! +
;+ ,
[ 
Serializable 
] 
public 
class #
EntityNotFoundException $
:% &
	Exception' 0
{ 
public 
#
EntityNotFoundException "
(" #
)# $
: 	
this
 
( 
$str &
)& '
{ 
}		 
public 
#
EntityNotFoundException "
(" #
string# )
message* 1
)1 2
: 	
base
 
( 
message 
) 
{ 
} 
public 
#
EntityNotFoundException "
(" #
string# )
?) *
message+ 2
,2 3
	Exception4 =
?= >
innerException? M
)M N
: 	
base
 
( 
message 
, 
innerException &
)& '
{ 
} 
} Ø	
ô/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Extensions/StringExtensions.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !

Extensions! +
;+ ,
internal 
static	 
class 
StringExtensions &
{ 
public 

static 
bool 

IsValidUrl !
(! "
this" &
string' -
?- .
value/ 4
)4 5
{ 
if 

( 
string 
. 
IsNullOrEmpty  
(  !
value! &
)& '
)' (
return 
true 
; 
try

 
{ 	
var 
url 
= 
new 
Uri 
( 
value #
!# $
)$ %
;% &
return 
true 
; 
} 	
catch 
{ 	
return 
false 
; 
} 	
} 
} ı
ú/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Interfaces/ICategoryRepository.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !

Interfaces! +
;+ ,
public 
	interface 
ICategoryRepository $
{ 
Task 
< 	
Category	 
> 
Get 
( 
int 
id 
, 
CancellationToken 0
cancellationToken1 B
=C D
defaultE L
)L M
;M N
Task 
< 	
Category	 
[ 
] 
> 
List 
( 
int 
? 
parentCategory -
,- .
CancellationToken/ @
cancellationTokenA R
=S T
defaultU \
)\ ]
;] ^
Task		 
<		 	
Category			 
>		 
Add		 
(		 
Category		 
category		  (
,		( )
CancellationToken		* ;
cancellationToken		< M
=		N O
default		P W
)		W X
;		X Y
Task

 
Update

	 
(

 
Category

 
category

 !
,

! "
CancellationToken

# 4
cancellationToken

5 F
=

G H
default

I P
)

P Q
;

Q R
Task 
Delete	 
( 
Category 
category !
,! "
CancellationToken# 4
cancellationToken5 F
=G H
defaultI P
)P Q
;Q R
} ë
ó/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Interfaces/IMessageSender.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !

Interfaces! +
;+ ,
public 
	interface 
IMessageSender 
{ 
Task 
SendMessage	 
( 
string 
	queueName %
,% &
BaseMessage' 2
message3 :
,: ;
CancellationToken< M
cancellationTokenN _
)_ `
;` a
} Ô
†/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Interfaces/IOutboxEventsRepository.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !

Interfaces! +
;+ ,
public 
	interface #
IOutboxEventsRepository (
{ 
public 

Task 
< 
	BaseEvent 
? 
> 
GetNextUnprocessed .
(. /
CancellationToken/ @
cancellationTokenA R
)R S
;S T
public 

Task 
Update 
( 
	BaseEvent  
outboxEvent! ,
,, -
CancellationToken. ?
cancellationToken@ Q
)Q R
;R S
}		 ’
õ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Common/Interfaces/IProductRepository.cs
	namespace 	
ApplicationCore
 
. 
Common  
.  !

Interfaces! +
;+ ,
public 
	interface 
IProductRepository #
{ 
Task 
< 	
Product	 
> 
Get 
( 
int 
id 
, 
CancellationToken /
cancellationToken0 A
=B C
defaultD K
)K L
;L M
Task 
< 	
Product	 
[ 
] 
> 
List 
( 
int 
? 

categoryId (
,( )
int* -
currentPage. 9
,9 :
int; >
pageSize? G
,G H
CancellationTokenI Z
cancellationToken[ l
=m n
defaulto v
)v w
;w x
Task

 
<

 	
Product

	 
>

 
Add

 
(

 
Product

 
product

 %
,

% &
CancellationToken

' 8
cancellationToken

9 J
=

K L
default

M T
)

T U
;

U V
Task 
Update	 
( 
Product 
product 
,  
CancellationToken! 2
cancellationToken3 D
=E F
defaultG N
)N O
;O P
Task 
Delete	 
( 
Product 
product 
,  
CancellationToken! 2
cancellationToken3 D
=E F
defaultG N
)N O
;O P
} æ
ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/DependencyInjection.cs
	namespace 	
ApplicationCore
 
; 
public 
static 
class 
DependencyInjection '
{		 
public

 

static

 
IServiceCollection

 $ 
ConfigureAppServices

% 9
(

9 :
this

: >
IServiceCollection

? Q
services

R Z
)

Z [
{ 
services 
. %
AddValidatorsFromAssembly *
(* +
Assembly+ 3
.3 4 
GetExecutingAssembly4 H
(H I
)I J
)J K
;K L
services 
. 

AddMediatR 
( 
cfg 
=> 
{ 
cfg 
. (
RegisterServicesFromAssembly 0
(0 1
Assembly1 9
.9 : 
GetExecutingAssembly: N
(N O
)O P
)P Q
;Q R
cfg 
. 
AddBehavior 
(  
typeof  &
(& '
IPipelineBehavior' 8
<8 9
,9 :
>: ;
); <
,< =
typeof> D
(D E
ValidationBehaviorE W
<W X
,X Y
>Y Z
)Z [
)[ \
;\ ]
} 
) 
; 
return 
services 
; 
} 
} Ü
É/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/GlobalUsings.csÅ
ó/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Outbox/Commands/SendOutboxEvents.cs
	namespace 	
ApplicationCore
 
. 
Outbox  
.  !
Commands! )
;) *
public 
record %
SendOutboxMessagesCommand '
(' (
)( )
:* +
IRequest, 4
;4 5
public		 
class		 %
SendOutboxMessagesHandler		 &
(		& '#
IOutboxEventsRepository		' >

repository		? I
,		I J
IMessageSender		K Y
messageSender		Z g
)		g h
:		i j
IRequestHandler		k z
<		z {&
SendOutboxMessagesCommand			{ î
>
		î ï
{

 
public 

async 
Task 
Handle 
( %
SendOutboxMessagesCommand 6
request7 >
,> ?
CancellationToken@ Q
cancellationTokenR c
)c d
{ 
var 
entity 
= 
await #
GetNextUnprocessedEvent 2
(2 3
cancellationToken3 D
)D E
;E F
while 
( 
entity 
!= 
null 
) 
{ 	
var 
message 
= 
entity  
.  !
Map! $
($ %
)% &
;& '
await 
messageSender 
.  
SendMessage  +
(+ ,
	Constants, 5
.5 6
ProductsQueueName6 G
,G H
messageI P
,P Q
cancellationTokenR c
)c d
;d e
await  
MarkEventAsProcessed &
(& '
entity' -
,- .
cancellationToken/ @
)@ A
;A B
entity 
= 
await #
GetNextUnprocessedEvent 2
(2 3
cancellationToken3 D
)D E
;E F
} 	
} 
private 
async 
Task 
< 
	BaseEvent  
?  !
>! "#
GetNextUnprocessedEvent# :
(: ;
CancellationToken; L
cancellationTokenM ^
)^ _
{ 
var 
entity 
= 
await 

repository %
.% &
GetNextUnprocessed& 8
(8 9
cancellationToken9 J
)J K
;K L
return 
entity 
; 
} 
private!! 
async!! 
Task!!  
MarkEventAsProcessed!! +
(!!+ ,
	BaseEvent!!, 5
entity!!6 <
,!!< =
CancellationToken!!> O
cancellationToken!!P a
)!!a b
{"" 
entity## 
.## 
	Processed## 
=## 
true## 
;##  
entity$$ 
.$$ 
ProcessedDate$$ 
=$$ 
DateTime$$ '
.$$' (
UtcNow$$( .
;$$. /
await&& 

repository&& 
.&& 
Update&& 
(&&  
entity&&  &
,&&& '
cancellationToken&&( 9
)&&9 :
;&&: ;
}'' 
}(( Ù
ï/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Outbox/Mappings/OutboxMappings.cs
	namespace 	
ApplicationCore
 
. 
Outbox  
.  !
Mappings! )
;) *
internal 
static	 
class 
OutboxMappings $
{ 
public 

static 
OutboxEvents 
. 
BaseMessage *
Map+ .
(. /
this/ 3
	BaseEvent4 =
outboxEvent> I
)I J
{		 
if

 

(

 
outboxEvent

 
is

 
ProductDeletedEvent

 .
deletedEvent

/ ;
)

; <
return 
deletedEvent 
.  
Map  #
(# $
)$ %
;% &
else 
if 
( 
outboxEvent 
is 
ProductUpdatedEvent  3
updatedEvent4 @
)@ A
return 
updatedEvent 
.  
Map  #
(# $
)$ %
;% &
throw 
new  
InvalidCastException &
(& '
$str' R
)R S
;S T
} 
public 

static 
OutboxEvents 
. !
ProductUpdatedMessage 4
Map5 8
(8 9
this9 =
ProductUpdatedEvent> Q
outboxEventR ]
)] ^
=> 

new 
( 
) 
{ 	
Date 
= 
outboxEvent 
. 
CreatedDate *
,* +
	ProductId 
= 
outboxEvent #
.# $
	ProductId$ -
,- .
Name 
= 
outboxEvent 
. 
Name #
,# $
Price 
= 
outboxEvent 
.  
Price  %
} 	
;	 

public 

static 
OutboxEvents 
. !
ProductDeletedMessage 4
Map5 8
(8 9
this9 =
ProductDeletedEvent> Q
outboxEventR ]
)] ^
=> 

new 
( 
) 
{ 	
Date 
= 
outboxEvent 
. 
CreatedDate *
,* +
	ProductId   
=   
outboxEvent   #
.  # $
	ProductId  $ -
}!! 	
;!!	 

}"" Ñ
§/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Commands/CreateProduct/CreateProduct.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Commands# +
.+ ,
CreateProduct, 9
;9 :
public 
record  
CreateProductCommand "
(" #
string 

Name 
, 
string 

Description 
, 
string 

?
 
Image 
, 
int		 

CategoryId		 
,		 
decimal

 
Price

 
,

 
int 
Amount 
) 
: 
IRequest 
< 
Product "
>" #
;# $
public 
class '
CreateProductCommandHandler (
(( )
IProductRepository 
productRepository (
,( )
ICategoryRepository 
categoryRepository *
)* +
:, -
IRequestHandler. =
<= > 
CreateProductCommand> R
,R S
ProductT [
>[ \
{ 
public 

async 
Task 
< 
Product 
> 
Handle %
(% & 
CreateProductCommand& :
request; B
,B C
CancellationTokenD U
cancellationTokenV g
)g h
{ 
var 
category 
= 
await 
categoryRepository /
./ 0
Get0 3
(3 4
request4 ;
.; <

CategoryId< F
,F G
cancellationTokenH Y
)Y Z
;Z [
if 

( 
category 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
var 
entity 
= 
new 
Product  
(  !
)! "
{ 	
Name 
= 
request 
. 
Name 
,  
Description 
= 
request !
.! "
Description" -
,- .
Image 
= 
request 
. 
Image !
,! "

CategoryId 
= 
category !
.! "
Id" $
,$ %
Price 
= 
request 
. 
Price !
,! "
Amount 
= 
request 
. 
Amount #
} 	
;	 

entity!! 
=!! 
await!! 
productRepository!! (
.!!( )
Add!!) ,
(!!, -
entity!!- 3
,!!3 4
cancellationToken!!5 F
)!!F G
;!!G H
return## 
entity## 
;## 
}$$ 
}%% ∏
¥/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Commands/CreateProduct/CreateProductCommandValidator.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Commands# +
.+ ,
CreateProduct, 9
;9 :
internal 
class	 )
CreateProductCommandValidator ,
:- .
AbstractValidator/ @
<@ A 
CreateProductCommandA U
>U V
{ 
public 
)
CreateProductCommandValidator (
(( )
)) *
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 
Name		 
)		 
.

 
Cascade

 
(

 
CascadeMode

  
.

  !
Stop

! %
)

% &
. 
NotEmpty 
( 
) 
. 
MaximumLength 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
Must 
( 
value 
=> 
value  
.  !

IsValidUrl! +
(+ ,
), -
)- .
. 
When 
( 
x 
=> 
! 
string 
. 
IsNullOrEmpty ,
(, -
x- .
.. /
Image/ 4
)4 5
)5 6
. 
WithMessage 
( 
$str =
)= >
;> ?
RuleFor 
( 
x 
=> 
x 
. 

CategoryId !
)! "
. 
NotEmpty 
( 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Price 
) 
. 
GreaterThan 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Amount 
) 
. 
GreaterThan 
( 
$num 
) 
; 
} 
} Ç
•/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Commands/DeleteCategory/DeleteProduct.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Commands# +
.+ ,
DeleteProduct, 9
;9 :
public 
record  
DeleteProductCommand "
(" #
int# &
	ProductId' 0
)0 1
:2 3
IRequest4 <
;< =
public 
class '
DeleteProductCommandHandler (
(( )
IProductRepository) ;

repository< F
)F G
:H I
IRequestHandlerJ Y
<Y Z 
DeleteProductCommandZ n
>n o
{ 
public 

async 
Task 
Handle 
(  
DeleteProductCommand 1
request2 9
,9 :
CancellationToken; L
cancellationTokenM ^
)^ _
{ 
var		 
entity		 
=		 
await		 

repository		 %
.		% &
Get		& )
(		) *
request		* 1
.		1 2
	ProductId		2 ;
,		; <
cancellationToken		= N
)		N O
;		O P
if 

( 
entity 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
await 

repository 
. 
Delete 
(  
entity  &
,& '
cancellationToken( 9
)9 :
;: ;
} 
} ä'
§/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Commands/UpdateProduct/UpdateProduct.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Commands# +
.+ ,
UpdateProduct, 9
;9 :
public 
record  
UpdateProductCommand "
(" #
int 
	ProductId 
, 
string 

?
 
Name 
, 
string 

?
 
Description 
, 
string 

?
 
Image 
, 
int 
? 

CategoryId	 
, 
decimal		 
?		 
Price		 
,		 
int

 
?

 
Amount

	 
)

 
:

 
IRequest

 
;

 
public 
class '
UpdateProductCommandHandler (
(( )
IProductRepository 
productRepository (
,( )
ICategoryRepository 
categoryRepository *
)* +
:, -
IRequestHandler. =
<= > 
UpdateProductCommand> R
>R S
{ 
public 

async 
Task 
Handle 
(  
UpdateProductCommand 1
request2 9
,9 :
CancellationToken; L
cancellationTokenM ^
)^ _
{ 
var 
entity 
= 
await 
productRepository ,
., -
Get- 0
(0 1
request1 8
.8 9
	ProductId9 B
,B C
cancellationTokenD U
)U V
;V W
if 

( 
entity 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
if 

( 
! 
string 
. 
IsNullOrEmpty !
(! "
request" )
.) *
Name* .
). /
)/ 0
{ 	
entity 
. 
Name 
= 
request !
.! "
Name" &
;& '
} 	
if 

( 
! 
string 
. 
IsNullOrEmpty !
(! "
request" )
.) *
Description* 5
)5 6
)6 7
{ 	
entity 
. 
Description 
=  
request! (
.( )
Description) 4
;4 5
} 	
if 

( 
! 
string 
. 
IsNullOrEmpty !
(! "
request" )
.) *
Image* /
)/ 0
)0 1
{ 	
entity   
.   
Image   
=   
request   "
.  " #
Image  # (
;  ( )
}!! 	
if"" 

("" 
request"" 
."" 

CategoryId"" 
."" 
HasValue"" '
)""' (
{## 	
var$$ 
category$$ 
=$$ 
await$$  
categoryRepository$$! 3
.$$3 4
Get$$4 7
($$7 8
request$$8 ?
.$$? @

CategoryId$$@ J
.$$J K
Value$$K P
,$$P Q
cancellationToken$$R c
)$$c d
;$$d e
if%% 
(%% 
category%% 
is%% 
null%%  
)%%  !
throw&& 
new&& #
EntityNotFoundException&& 1
(&&1 2
)&&2 3
;&&3 4
entity(( 
.(( 

CategoryId(( 
=(( 
category((  (
.((( )
Id(() +
;((+ ,
})) 	
if** 

(** 
request** 
.** 
Price** 
.** 
HasValue** "
)**" #
{++ 	
entity,, 
.,, 
Price,, 
=,, 
request,, "
.,," #
Price,,# (
.,,( )
Value,,) .
;,,. /
}-- 	
if.. 

(.. 
request.. 
... 
Amount.. 
... 
HasValue.. #
)..# $
{// 	
entity00 
.00 
Amount00 
=00 
request00 #
.00# $
Amount00$ *
.00* +
Value00+ 0
;000 1
}11 	
await33 
productRepository33 
.33  
Update33  &
(33& '
entity33' -
,33- .
cancellationToken33/ @
)33@ A
;33A B
}44 
}55 ∏
¥/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Commands/UpdateProduct/UpdateProductCommandValidator.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Commands# +
.+ ,
UpdateProduct, 9
;9 :
internal 
class	 )
UpdateProductCommandValidator ,
:- .
AbstractValidator/ @
<@ A 
UpdateProductCommandA U
>U V
{ 
public 
)
UpdateProductCommandValidator (
(( )
)) *
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 
Name		 
)		 
.

 
Cascade

 
(

 
CascadeMode

  
.

  !
Stop

! %
)

% &
. 
NotEmpty 
( 
) 
. 
MaximumLength 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
Must 
( 
value 
=> 
value  
.  !

IsValidUrl! +
(+ ,
), -
)- .
. 
When 
( 
x 
=> 
! 
string 
. 
IsNullOrEmpty ,
(, -
x- .
.. /
Image/ 4
)4 5
)5 6
. 
WithMessage 
( 
$str =
)= >
;> ?
RuleFor 
( 
x 
=> 
x 
. 

CategoryId !
)! "
. 
NotEmpty 
( 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Price 
) 
. 
GreaterThan 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Amount 
) 
. 
GreaterThan 
( 
$num 
) 
; 
} 
} Ö
•/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Queries/GetProductById/GetProductById.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Queries# *
.* +
GetProductById+ 9
;9 :
public 
record 
GetProductByIdQuery !
(! "
int" %
	ProductId& /
)/ 0
:1 2
IRequest3 ;
<; <
Product< C
>C D
;D E
public 
class &
GetProductByIdQueryHandler '
(' (
IProductRepository( :

repository; E
)E F
:G H
IRequestHandlerI X
<X Y
GetProductByIdQueryY l
,l m
Productn u
>u v
{ 
public		 

async		 
Task		 
<		 
Product		 
>		 
Handle		 %
(		% &
GetProductByIdQuery		& 9
request		: A
,		A B
CancellationToken		C T
cancellationToken		U f
)		f g
{

 
var 
product 
= 
await 

repository &
.& '
Get' *
(* +
request+ 2
.2 3
	ProductId3 <
,< =
cancellationToken> O
)O P
;P Q
if 

( 
product 
is 
null 
) 
throw 
new #
EntityNotFoundException -
(- .
). /
;/ 0
return 
product 
; 
} 
} í
£/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/ApplicationCore/Products/Queries/ListProducts/ListCategories.cs
	namespace 	
ApplicationCore
 
. 
Products "
." #
Queries# *
.* +
ListProducts+ 7
;7 8
public 
record 
ListProductsQuery 
(  
int  #
?# $

CategoryId% /
,/ 0
int1 4
?4 5
CurrentPage6 A
,A B
intC F
?F G
PageSizeH P
)P Q
:R S
IRequestT \
<\ ]
Product] d
[d e
]e f
>f g
;g h
public 
class $
ListProductsQueryHandler %
(% &
IProductRepository& 8

repository9 C
)C D
:E F
IRequestHandlerG V
<V W
ListProductsQueryW h
,h i
Productj q
[q r
]r s
>s t
{ 
private		 
const		 
int		 
DefaultCurrentPage		 (
=		) *
$num		+ ,
;		, -
private

 
const

 
int

 
DefaultPageSize

 %
=

& '
$num

( *
;

* +
public 

async 
Task 
< 
Product 
[ 
] 
>  
Handle! '
(' (
ListProductsQuery( 9
request: A
,A B
CancellationTokenC T
cancellationTokenU f
)f g
{ 
var 
products 
= 
await 

repository '
.' (
List( ,
(, -
request 
. 

CategoryId 
, 
request 
. 
CurrentPage 
.  
GetValueOrDefault  1
(1 2
DefaultCurrentPage2 D
)D E
,E F
request 
. 
PageSize 
. 
GetValueOrDefault .
(. /
DefaultPageSize/ >
)> ?
,? @
cancellationToken 
) 
; 
return 
products 
; 
} 
} 