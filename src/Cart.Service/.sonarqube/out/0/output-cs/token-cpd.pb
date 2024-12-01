ª%
ô/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BackgroundServices/OutboxMessageListener.cs
	namespace 	
Cart
 
. 
Service 
. 
BackgroundServices )
;) *
internal

 
class

	 !
OutboxMessageListener

 $
(

$ % 
IServiceScopeFactory 
serviceScopeFactory ,
,, -
ServiceBusClient 
	busClient 
, 
ILogger 
< !
OutboxMessageListener !
>! "
logger# )
)) *
:+ ,
BackgroundService- >
{ 
private 
const 
int ,
 NotFoundMessageDelayMilliseconds 6
=7 8
$num9 ?
;? @
private 
static 
readonly !
JsonSerializerOptions 1!
_serializationOptions2 G
=H I
newJ M
(M N
)N O
{ 
TypeInfoResolver 
= $
AppJsonSerializerContext 3
.3 4
Default4 ;
} 
; 
[ (
UnconditionalSuppressMessage !
(! "
$str" ,
,, -
$str	. …
,
…  
Justification
À ÿ
=
Ÿ ⁄
$str
€ Ê
)
Ê Á
]
Á Ë
	protected 
override 
async 
Task !
ExecuteAsync" .
(. /
CancellationToken/ @
stoppingTokenA N
)N O
{ 
await 
using 
var 
receiver  
=! "
	busClient# ,
., -
CreateReceiver- ;
(; <
	Constants< E
.E F
ProductsQueueNameF W
)W X
;X Y
while 
( 
! 
stoppingToken 
. #
IsCancellationRequested 5
)5 6
{ 	
try 
{ 
var 

busMessage 
=  
await! &
receiver' /
./ 0
ReceiveMessageAsync0 C
(C D
cancellationTokenD U
:U V
stoppingTokenW d
)d e
;e f
if 
( 

busMessage 
is !
null" &
)& '
{   
await!! 
Task!! 
.!! 
Delay!! $
(!!$ %,
 NotFoundMessageDelayMilliseconds!!% E
,!!E F
stoppingToken!!G T
)!!T U
;!!U V
continue"" 
;"" 
}## 
using%% 
var%% 
_%% 
=%% 
logger%% $
.%%$ %

BeginScope%%% /
(%%/ 0
$str&& g
,&&g h

busMessage'' 
.'' 
	MessageId'' (
,''( )

busMessage(( 
.(( 
CorrelationId(( ,
)((, -
;((- .
using** 
var** 
serviceScope** &
=**' (
serviceScopeFactory**) <
.**< =
CreateScope**= H
(**H I
)**I J
;**J K
var++ 
handler++ 
=++ 
serviceScope++ *
.++* +
ServiceProvider+++ :
.++: ;
GetRequiredService++; M
<++M N!
IOutboxMessageHandler++N c
>++c d
(++d e
)++e f
;++f g
var-- 
outboxMessage-- !
=--" #

busMessage--$ .
!--. /
.--/ 0
Body--0 4
.--4 5
ToObjectFromJson--5 E
<--E F
BaseMessage--F Q
>--Q R
(--R S!
_serializationOptions--S h
)--h i
;--i j
await// 
handler// 
.// 
Handle// $
(//$ %
outboxMessage//% 2
,//2 3
stoppingToken//4 A
)//A B
;//B C
await11 
receiver11 
.11  
CompleteMessageAsync11 3
(113 4

busMessage114 >
,11> ?
cancellationToken11@ Q
:11Q R
stoppingToken11S `
)11` a
;11a b
logger33 
.33 
LogInformation33 %
(33% &
$str33& F
)33F G
;33G H
}44 
catch55 
(55 
	Exception55 
ex55 
)55  
{66 
logger77 
.77 
LogError77 
(77  
ex77  "
,77" #
$str77$ <
)77< =
;77= >
}88 
}99 	
}:: 
};; Æ
å/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Registrations.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
;$ %
public 
static 
class 
Registrations !
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
 $*
ConfigureBusinessLogicServices

% C
(

C D
this

D H
IServiceCollection

I [
services

\ d
,

d e
IConfiguration

f t
configuration	

u Ç
)


Ç É
{ 
services 
. 
AddTransient 
< !
IOutboxMessageHandler /
,/ 0 
OutboxMessageHandler1 E
>E F
(F G
)G H
. 
AddTransient 
< 
ICartService &
,& '
CartService( 3
>3 4
(4 5
)5 6
. 
AddTransient 
< 
ICartItemService *
,* +
CartItemService, ;
>; <
(< =
)= >
. 
	AddScoped 
< 

IValidator !
<! "
Models" (
.( )
CartItem) 1
>1 2
,2 3
CartItemValidator4 E
>E F
(F G
)G H
;H I
return 
services 
; 
} 
} Ä
•/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Services/Abstractions/ICartItemService.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %
Services% -
.- .
Abstractions. :
;: ;
public 
	interface 
ICartItemService !
{ 
Task 
< 	
Models	 
. 
CartItem 
[ 
] 
> 
List  
(  !
string! '
cartId( .
,. /
CancellationToken0 A
cancellationTokenB S
)S T
;T U
Task 
Add	 
( 
string 
cartId 
, 
Models "
." #
CartItem# +
cartItem, 4
,4 5
CancellationToken6 G
cancellationTokenH Y
)Y Z
;Z [
Task		 
Remove			 
(		 
string		 
cartId		 
,		 
int		 "

cartItemId		# -
,		- .
CancellationToken		/ @
cancellationToken		A R
)		R S
;		S T
Task 
Clear	 
( 
string 
cartId 
, 
CancellationToken /
cancellationToken0 A
)A B
;B C
} ˙
°/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Services/Abstractions/ICartService.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %
Services% -
.- .
Abstractions. :
;: ;
public 
	interface 
ICartService 
{ 
Task 
< 	
Models	 
. 
Cart 
? 
> 
Get 
( 
string !
cartId" (
,( )
CancellationToken* ;
cancellationToken< M
)M N
;N O
} ¬
™/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Services/Abstractions/IOutboxMessageHandler.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %
Services% -
.- .
Abstractions. :
;: ;
public 
	interface !
IOutboxMessageHandler &
{ 
Task 
Handle	 
( 
BaseMessage 
? 
message $
,$ %
CancellationToken& 7
cancellationToken8 I
)I J
;J K
} ‚A
ó/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Services/CartItemService.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %
Services% -
;- .
internal 
class	 
CartItemService 
( 
ICartRepository 

repository 
, 
ILogger		 
<		 
CartItemService		 
>		 
logger		 #
,		# $

IValidator

 
<

 
Models

 
.

 
CartItem

 
>

 
cartItemValidator

  1
)

1 2
:

3 4
ICartItemService

5 E
{ 
public 

async 
Task 
< 
Models 
. 
CartItem %
[% &
]& '
>' (
List) -
(- .
string. 4
cartId5 ;
,; <
CancellationToken= N
cancellationTokenO `
)` a
{ 
logger 
. 
LogInformation 
( 
$str >
,> ?
nameof@ F
(F G
ListG K
)K L
)L M
;M N
var 
cart 
= 
await 

repository #
.# $
Get$ '
(' (
cartId( .
,. /
cancellationToken0 A
)A B
;B C
return 
cart 
? 
. 
Items 
?? 
[ 
]  
;  !
} 
public 

async 
Task 
Add 
( 
string  
cartId! '
,' (
Models) /
./ 0
CartItem0 8
cartItem9 A
,A B
CancellationTokenC T
cancellationTokenU f
)f g
{ 
logger 
. 
LogInformation 
( 
$str >
,> ?
nameof@ F
(F G
AddG J
)J K
)K L
;L M
cartItemValidator 
. 
ValidateAndThrow *
(* +
cartItem+ 3
)3 4
;4 5
var 
currentCart 
= 
await 

repository  *
.* +
Get+ .
(. /
cartId/ 5
,5 6
cancellationToken7 H
)H I
;I J
if 

( 
currentCart 
is 
null 
)  
{ 	
logger 
. 
LogInformation !
(! "
$str" b
,b c
cartIdd j
)j k
;k l
currentCart   
=   
InitEmptyCart   '
(  ' (
cartId  ( .
,  . /
cartItem  0 8
)  8 9
;  9 :
}!! 	
else"" 
{## 	
AddItemToCart$$ 
($$ 
currentCart$$ %
,$$% &
cartItem$$' /
)$$/ 0
;$$0 1
}%% 	
await'' 

repository'' 
.'' 
Upsert'' 
(''  
cartId''  &
,''& '
currentCart''( 3
,''3 4
cancellationToken''5 F
)''F G
;''G H
}(( 
private** 
static** 
Models** 
.** 
Cart** 
InitEmptyCart** ,
(**, -
string**- 3
cartId**4 :
,**: ;
Models**< B
.**B C
CartItem**C K
cartItem**L T
)**T U
{++ 
var,, 
cart,, 
=,, 
new,, 
Models,, 
.,, 
Cart,, "
(,," #
),,# $
{-- 	
Id.. 
=.. 
cartId.. 
,.. 
Items// 
=// 
[// 
cartItem// 
]// 
}00 	
;00	 

return22 
cart22 
;22 
}33 
private55 
static55 
void55 
AddItemToCart55 %
(55% &
Models55& ,
.55, -
Cart55- 1
cart552 6
,556 7
Models558 >
.55> ?
CartItem55? G
item55H L
)55L M
{66 
var77 
existingCartItem77 
=77 
cart77 #
.77# $
Items77$ )
.77) *
FirstOrDefault77* 8
(778 9
x779 :
=>77; =
x77> ?
.77? @
ItemId77@ F
==77G I
item77J N
.77N O
ItemId77O U
)77U V
;77V W
if88 

(88 
existingCartItem88 
!=88 
null88  $
)88$ %
{99 	
existingCartItem:: 
.:: 
Quantity:: %
+=::& (
item::) -
.::- .
Quantity::. 6
;::6 7
};; 	
else<< 
{== 	
cart>> 
.>> 
Items>> 
=>> 
[>> 
..>> 
cart>> !
.>>! "
Items>>" '
,>>' (
item>>) -
]>>- .
;>>. /
}?? 	
}@@ 
publicDD 

asyncDD 
TaskDD 
RemoveDD 
(DD 
stringDD #
cartIdDD$ *
,DD* +
intDD, /
idDD0 2
,DD2 3
CancellationTokenDD4 E
cancellationTokenDDF W
)DDW X
{EE 
loggerFF 
.FF 
LogInformationFF 
(FF 
$strFF >
,FF> ?
nameofFF@ F
(FFF G
RemoveFFG M
)FFM N
)FFN O
;FFO P
varHH 
currentCartHH 
=HH 
awaitHH 

repositoryHH  *
.HH* +
GetHH+ .
(HH. /
cartIdHH/ 5
,HH5 6
cancellationTokenHH7 H
)HHH I
;HHI J
ifII 

(II 
currentCartII 
isII 
nullII 
)II  
returnJJ 
;JJ 
varLL 
cartItemLL 
=LL 
currentCartLL "
.LL" #
ItemsLL# (
.LL( )
FirstOrDefaultLL) 7
(LL7 8
xLL8 9
=>LL: <
xLL= >
.LL> ?
ItemIdLL? E
==LLF H
idLLI K
)LLK L
;LLL M
ifMM 

(MM 
cartItemMM 
isMM 
nullMM 
)MM 
returnNN 
;NN 
cartItemPP 
.PP 
QuantityPP 
-=PP 
$numPP 
;PP 
ifRR 

(RR 
cartItemRR 
.RR 
QuantityRR 
<=RR  
$numRR! "
)RR" #
{SS 	
currentCartTT 
.TT 
ItemsTT 
=TT 
currentCartTT  +
.TT+ ,
ItemsTT, 1
.TT1 2
WhereTT2 7
(TT7 8
xTT8 9
=>TT: <
xTT= >
.TT> ?
ItemIdTT? E
!=TTF H
idTTI K
)TTK L
.TTL M
ToArrayTTM T
(TTT U
)TTU V
;TTV W
}UU 	
awaitWW 

repositoryWW 
.WW 
UpsertWW 
(WW  
cartIdWW  &
,WW& '
currentCartWW( 3
,WW3 4
cancellationTokenWW5 F
)WWF G
;WWG H
}XX 
publicZZ 

asyncZZ 
TaskZZ 
ClearZZ 
(ZZ 
stringZZ "
cartIdZZ# )
,ZZ) *
CancellationTokenZZ+ <
cancellationTokenZZ= N
)ZZN O
{[[ 
logger\\ 
.\\ 
LogInformation\\ 
(\\ 
$str\\ >
,\\> ?
nameof\\@ F
(\\F G
Clear\\G L
)\\L M
)\\M N
;\\N O
await]] 

repository]] 
.]] 
Remove]] 
(]]  
cartId]]  &
,]]& '
cancellationToken]]( 9
)]]9 :
;]]: ;
}^^ 
}__ –
ì/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Services/CartService.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %
Services% -
;- .
public 
class 
CartService 
( 
ICartRepository 

repository 
, 
ILogger 
< 
CartService 
> 
logger 
)  
:! "
ICartService# /
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
 
<

 
Models

 
.

 
Cart

 !
?

! "
>

" #
Get

$ '
(

' (
string

( .
cartId

/ 5
,

5 6
CancellationToken

7 H
cancellationToken

I Z
)

Z [
{ 
logger 
. 
LogInformation 
( 
$str >
,> ?
nameof@ F
(F G
GetG J
)J K
)K L
;L M
var 
cart 
= 
await 

repository #
.# $
Get$ '
(' (
cartId( .
,. /
cancellationToken0 A
)A B
;B C
return 
cart 
; 
} 
} ˙.
ú/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Services/OutboxMessageHandler.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %
Services% -
;- .
public 
class  
OutboxMessageHandler !
(! "
ICartRepository" 1

repository2 <
)< =
:> ?!
IOutboxMessageHandler@ U
{ 
public		 

async		 
Task		 
Handle		 
(		 
BaseMessage		 (
?		( )
message		* 1
,		1 2
CancellationToken		3 D
cancellationToken		E V
)		V W
{

 !
ArgumentNullException 
. 
ThrowIfNull )
() *
message* 1
,1 2
nameof3 9
(9 :
message: A
)A B
)B C
;C D
switch 
( 
message 
) 
{ 	
case !
ProductDeletedMessage &
deleteMessage' 4
:4 5
await 
DeleteItemFromCarts )
() *
deleteMessage* 7
.7 8
	ProductId8 A
,A B
cancellationTokenC T
)T U
;U V
break 
; 
case !
ProductUpdatedMessage &
updateMessage' 4
:4 5
await 
UpdateItemInCarts '
(' (
updateMessage( 5
.5 6
	ProductId6 ?
,? @
updateMessageA N
.N O
NameO S
,S T
updateMessageU b
.b c
Pricec h
!h i
,i j
cancellationTokenk |
)| }
;} ~
break 
; 
default 
: 
throw 
new  
InvalidCastException .
(. /
$"/ 1
$str1 Q
{Q R
messageR Y
.Y Z
GetTypeZ a
(a b
)b c
.c d
Named h
}h i
"i j
)j k
;k l
} 	
} 
private 
async 
Task 
UpdateItemInCarts (
(( )
int) ,
itemId- 3
,3 4
string5 ;
name< @
,@ A
decimalB I
priceJ O
,O P
CancellationTokenQ b
cancellationTokenc t
)t u
{ 
var 
cart 
= 
await 

repository #
.# $
GetNextOutdated$ 3
(3 4
itemId4 :
,: ;
name< @
,@ A
priceB G
,G H
cancellationTokenI Z
)Z [
;[ \
while 
( 
cart 
!= 
null 
) 
{ 	
var   
cartItem   
=   
cart   
.    
Items    %
.  % &
First  & +
(  + ,
x  , -
=>  . 0
x  1 2
.  2 3
ItemId  3 9
==  : <
itemId  = C
)  C D
;  D E
cartItem!! 
.!! 
Name!! 
=!! 
name!!  
;!!  !
cartItem"" 
."" 
Price"" 
="" 
price"" "
;""" #
await$$ 

repository$$ 
.$$ 
Upsert$$ #
($$# $
cart$$$ (
.$$( )
Id$$) +
,$$+ ,
cart$$- 1
,$$1 2
cancellationToken$$3 D
)$$D E
;$$E F
cart&& 
=&& 
await&& 

repository&& #
.&&# $
GetNextOutdated&&$ 3
(&&3 4
itemId&&4 :
,&&: ;
name&&< @
,&&@ A
price&&B G
,&&G H
cancellationToken&&I Z
)&&Z [
;&&[ \
}'' 	
}(( 
private** 
async** 
Task** 
DeleteItemFromCarts** *
(*** +
int**+ .
itemId**/ 5
,**5 6
CancellationToken**7 H
cancellationToken**I Z
)**Z [
{++ 
var,, 
cart,, 
=,, 
await,, 

repository,, #
.,,# $
GetNextOutdated,,$ 3
(,,3 4
itemId,,4 :
,,,: ;
newName,,< C
:,,C D
null,,E I
,,,I J
newPrice,,K S
:,,S T
null,,U Y
,,,Y Z
cancellationToken,,[ l
),,l m
;,,m n
while.. 
(.. 
cart.. 
!=.. 
null.. 
).. 
{// 	
cart00 
.00 
Items00 
=00 
cart00 
.00 
Items00 #
.00# $
Where00$ )
(00) *
x00* +
=>00, .
x00/ 0
.000 1
ItemId001 7
!=008 :
itemId00; A
)00A B
.00B C
ToArray00C J
(00J K
)00K L
;00L M
await22 

repository22 
.22 
Upsert22 #
(22# $
cart22$ (
.22( )
Id22) +
,22+ ,
cart22- 1
,221 2
cancellationToken223 D
)22D E
;22E F
cart44 
=44 
await44 

repository44 #
.44# $
GetNextOutdated44$ 3
(443 4
itemId444 :
,44: ;
newName44< C
:44C D
null44E I
,44I J
newPrice44K S
:44S T
null44U Y
,44Y Z
cancellationToken44[ l
)44l m
;44m n
}55 	
}66 
}77 ﬁ
õ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/BusinessLogic/Validators/CartItemValidator.cs
	namespace 	
Cart
 
. 
Service 
. 
BusinessLogic $
.$ %

Validators% /
;/ 0
public 
class 
CartItemValidator 
:  
AbstractValidator! 2
<2 3
Models3 9
.9 :
CartItem: B
>B C
{ 
public 

CartItemValidator 
( 
) 
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 
ItemId		 
)		 
.

 
NotEmpty

 
(

 
)

 
;

 
RuleFor 
( 
x 
=> 
x 
. 
Name 
) 
. 
NotNull 
( 
) 
. 
NotEmpty 
( 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Price 
) 
. 
GreaterThan 
( 
$num 
) 
; 
RuleFor 
( 
x 
=> 
x 
. 
Quantity 
)  
. 
GreaterThan 
( 
$num 
) 
; 
} 
} ˝
ì/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Options/CosmosDbOptions.cs
	namespace 	
Cart
 
. 
Service 
. 

DataAccess !
.! "
Options" )
;) *
public 
sealed 
class 
CosmosDbOptions #
{ 
public 

const 
string 
Position  
=! "
$str# -
;- .
[		 
Required		 
]		 
public

 

required

 
string

 
Endpoint

 #
{

$ %
get

& )
;

) *
set

+ .
;

. /
}

0 1
[ 
Required 
] 
public 

required 
string 
ResourceToken (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} ì
ê/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Options/RedisOptions.cs
	namespace 	
Cart
 
. 
Service 
. 

DataAccess !
.! "
Options" )
;) *
public 
sealed 
class 
RedisOptions  
{ 
public 

const 
string 
Position  
=! "
$str# *
;* +
[		 
Required		 
]		 
public

 

string

 
?

 
ConnectionString

 #
{

$ %
get

& )
;

) *
set

+ .
;

. /
}

0 1
public 

int 
DbNumber 
{ 
get 
; 
set "
;" #
}$ %
=& '
$num( )
;) *
public 

uint 
MaxValueLength 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
int/ 2
.2 3
MaxValue3 ;
;; <
public 

int 
PoolSize 
{ 
get 
; 
set "
;" #
}$ %
=& '
$num( )
;) *
} ∑
õ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Options/ValidateCosmosDbOptions.cs
	namespace 	
Cart
 
. 
Service 
. 
Options 
; 
[ 
OptionsValidator 
] 
public 
partial 
class #
ValidateCosmosDbOptions ,
:- .
IValidateOptions/ ?
<? @
CosmosDbOptions@ O
>O P
{ 
}		 Æ
ò/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Options/ValidateRedisOptions.cs
	namespace 	
Cart
 
. 
Service 
. 
Options 
; 
[ 
OptionsValidator 
] 
public 
partial 
class  
ValidateRedisOptions )
:* +
IValidateOptions, <
<< =
RedisOptions= I
>I J
{ 
}		 ø>
â/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Registrations.cs
	namespace 	
Cart
 
. 
Service 
. 

DataAccess !
;! "
public 
static 
class 
Registrations !
{ 
public 

const 
string 
DbName 
=  
$str! 1
;1 2
public 

static 
IServiceCollection $'
ConfigureDataAccessServices% @
(@ A
thisA E
IServiceCollectionF X
servicesY a
,a b
IConfigurationc q
configurationr 
)	 Ä
{ 
services 
. 
	Configure 
< 
RedisOptions '
>' (
(( )
configuration) 6
.6 7

GetSection7 A
(A B
RedisOptionsB N
.N O
PositionO W
)W X
)X Y
;Y Z
services 
. 
	Configure 
< 
CosmosDbOptions *
>* +
(+ ,
configuration, 9
.9 :

GetSection: D
(D E
CosmosDbOptionsE T
.T U
PositionU ]
)] ^
)^ _
;_ `
services 
. 
AddSingleton 
( 
sp 
=> 
{ 
var 
cosmosDbOptions #
=$ %
sp& (
.( )
GetRequiredService) ;
<; <
IOptions< D
<D E
CosmosDbOptionsE T
>T U
>U V
(V W
)W X
.X Y
ValueY ^
;^ _
var 

credential 
=  
new! $"
DefaultAzureCredential% ;
(; <
)< =
;= >
var 
client 
= 
new  
CosmosClient! -
(- .
accountEndpoint   #
:  # $
cosmosDbOptions  % 4
.  4 5
Endpoint  5 =
,  = >"
authKeyOrResourceToken!! *
:!!* +
cosmosDbOptions!!, ;
.!!; <
ResourceToken!!< I
,!!I J
clientOptions"" !
:""! "
new""# &
CosmosClientOptions""' :
{## 
ConnectionMode$$ &
=$$' (
ConnectionMode$$) 7
.$$7 8
Direct$$8 >
,$$> ?$
IdleTcpConnectionTimeout%% 0
=%%1 2
TimeSpan%%3 ;
.%%; <
FromMinutes%%< G
(%%G H
$num%%H J
)%%J K
,%%K L2
&UseSystemTextJsonSerializerWithOptions&& >
=&&? @
new&&A D
System&&E K
.&&K L
Text&&L P
.&&P Q
Json&&Q U
.&&U V!
JsonSerializerOptions&&V k
(&&k l
)&&l m
{'' 
TypeInfoResolver(( ,
=((- .$
AppJsonSerializerContext((/ G
.((G H
Default((H O
,((O P
})) 
,)) 
}** 
)** 
;** 
return,, 
client,, 
;,, 
}-- 
)-- 
... 
AddSingleton.. 
<.. 
ICartRepository.. )
,..) *
CartRepository..+ 9
>..9 :
(..: ;
)..; <
;..< =
return00 
services00 
;00 
}11 
private44 
static44 
IServiceCollection44 %
RegisterRedisCache44& 8
(448 9
this449 =
IServiceCollection44> P
services44Q Y
)44Y Z
{66 
services77 
.88 
AddSingleton88 
<88 '
IRedisConnectionPoolManager88 5
>885 6
(886 7
sp887 9
=>88: <
{99 
var:: 
redisOptions::  
=::! "
sp::# %
.::% &
GetRequiredService::& 8
<::8 9
IOptions::9 A
<::A B
RedisOptions::B N
>::N O
>::O P
(::P Q
)::Q R
.::R S
Value::S X
;::X Y
var;; 
configuration;; !
=;;" #
new;;$ '
RedisConfiguration;;( :
(;;: ;
);;; <
{<< 
ConnectionString== $
===% &
redisOptions==' 3
.==3 4
ConnectionString==4 D
,==D E
PoolSize>> 
=>> 
redisOptions>> +
.>>+ ,
PoolSize>>, 4
,>>4 5
}?? 
;?? 
varAA 
connectionManagerAA %
=AA& '
newAA( +&
RedisConnectionPoolManagerAA, F
(AAF G
configurationAAG T
)AAT U
;AAU V
returnBB 
connectionManagerBB (
;BB( )
}CC 
)CC 
.DD 
AddSingletonDD 
<DD 
IRedisDatabaseDD (
>DD( )
(DD) *
spDD* ,
=>DD- /
{EE 
varFF 
redisOptionsFF  
=FF! "
spFF# %
.FF% &
GetRequiredServiceFF& 8
<FF8 9
IOptionsFF9 A
<FFA B
RedisOptionsFFB N
>FFN O
>FFO P
(FFP Q
)FFQ R
.FFR S
ValueFFS X
;FFX Y
varGG 
connectionManagerGG %
=GG& '
spGG( *
.GG* +
GetRequiredServiceGG+ =
<GG= >'
IRedisConnectionPoolManagerGG> Y
>GGY Z
(GGZ [
)GG[ \
;GG\ ]
varHH 

serializerHH 
=HH  
newHH! $$
SystemTextJsonSerializerHH% =
(HH= >
newHH> A
SystemHHB H
.HHH I
TextHHI M
.HHM N
JsonHHN R
.HHR S!
JsonSerializerOptionsHHS h
(HHh i
)HHi j
{II 
TypeInfoResolverJJ $
=JJ% &$
AppJsonSerializerContextJJ' ?
.JJ? @
DefaultJJ@ G
,JJG H
}KK 
)KK 
;KK 
varMM 
databaseMM 
=MM 
newMM "
RedisDatabaseMM# 0
(MM0 1!
connectionPoolManagerNN )
:NN) *
connectionManagerNN+ <
,NN< =

serializerOO 
:OO 

serializerOO  *
,OO* +%
serverEnumerationStrategyPP -
:PP- .
newPP/ 2%
ServerEnumerationStrategyPP3 L
(PPL M
)PPM N
{QQ 
ModeRR 
=RR %
ServerEnumerationStrategyRR 8
.RR8 9
ModeOptionsRR9 D
.RRD E
SingleRRE K
,RRK L

TargetRoleSS "
=SS# $%
ServerEnumerationStrategySS% >
.SS> ?
TargetRoleOptionsSS? P
.SSP Q
AnySSQ T
,SST U#
UnreachableServerActionTT /
=TT0 1%
ServerEnumerationStrategyTT2 K
.TTK L*
UnreachableServerActionOptionsTTL j
.TTj k
ThrowTTk p
,TTp q
}UU 
,UU 
dbNumberVV 
:VV 
redisOptionsVV *
.VV* +
DbNumberVV+ 3
,VV3 4
maxvalueLengthWW "
:WW" #
redisOptionsWW$ 0
.WW0 1
MaxValueLengthWW1 ?
,WW? @
	keyPrefixXX 
:XX 
AssemblyXX '
.XX' (
GetEntryAssemblyXX( 8
(XX8 9
)XX9 :
!XX: ;
.XX; <
GetNameXX< C
(XXC D
)XXD E
.XXE F
NameXXF J
)XXJ K
;XXK L
returnZZ 
databaseZZ 
;ZZ  
}[[ 
)[[ 
;[[ 
return]] 
services]] 
;]] 
}^^ 
}__ ®
•/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Repositories/Abstractions/ICartRepository.cs
	namespace 	
Cart
 
. 
Service 
. 

DataAccess !
.! "
Repositories" .
.. /
Abstractions/ ;
;; <
public 
	interface 
ICartRepository  
{ 
Task 
< 	
Models	 
. 
Cart 
? 
> 
Get 
( 
string !
cartId" (
,( )
CancellationToken* ;
cancellationToken< M
)M N
;N O
Task 
< 	
Models	 
. 
Cart 
? 
> 
GetNextOutdated &
(& '
int' *
itemId+ 1
,1 2
string3 9
?9 :
newName; B
,B C
decimalD K
?K L
newPriceM U
,U V
CancellationTokenW h
cancellationTokeni z
)z {
;{ |
Task		 
Upsert			 
(		 
string		 
cartId		 
,		 
Models		 %
.		% &
Cart		& *
cart		+ /
,		/ 0
CancellationToken		1 B
cancellationToken		C T
)		T U
;		U V
Task 
Remove	 
( 
string 
cartId 
, 
CancellationToken 0
cancellationToken1 B
)B C
;C D
} úE
ó/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/DataAccess/Repositories/CartRepository.cs
	namespace 	
Cart
 
. 
Service 
. 

DataAccess !
.! "
Repositories" .
;. /
internal 
class	 
CartRepository 
: 
ICartRepository  /
{ 
internal		 
const		 
string		 
ContainerName		 '
=		( )
$str		* 1
;		1 2
private 
readonly 
CosmosClient !
_cosmosClient" /
;/ 0
internal 
	Container 
	Container  
=>! #
_cosmosClient$ 1
.1 2
GetDatabase2 =
(= >
Registrations> K
.K L
DbNameL R
)R S
.S T
GetContainerT `
(` a
ContainerNamea n
)n o
;o p
public 

CartRepository 
( 
CosmosClient &
cosmosClient' 3
)3 4
{ 
var 
databaseResponse 
= 
cosmosClient +
. *
CreateDatabaseIfNotExistsAsync +
(+ ,
Registrations, 9
.9 :
DbName: @
,@ A
cancellationTokenB S
:S T
defaultU \
)\ ]
. 

GetAwaiter 
( 
) 
. 
	GetResult #
(# $
)$ %
;% &
databaseResponse 
. 
Database 
. +
CreateContainerIfNotExistsAsync ,
(, -
id 
: 
ContainerName !
,! "
partitionKeyPath  
:  !
$"" $
$str$ %
{% &
nameof& ,
(, -
Models- 3
.3 4
Cart4 8
.8 9
Id9 ;
); <
.< =
ToLowerInvariant= M
(M N
)N O
}O P
"P Q
)Q R
. 

GetAwaiter 
( 
) 
. 
	GetResult 
( 
) 
; 
_cosmosClient 
= 
cosmosClient $
;$ %
} 
public   

async   
Task   
<   
Models   
.   
Cart   !
?  ! "
>  " #
Get  $ '
(  ' (
string  ( .
cartId  / 5
,  5 6
CancellationToken  7 H
cancellationToken  I Z
)  Z [
{!! 
try"" 
{## 	
var$$ 
cart$$ 
=$$ 
await$$ 
	Container$$ &
.$$& '
ReadItemAsync$$' 4
<$$4 5
Models$$5 ;
.$$; <
Cart$$< @
>$$@ A
($$A B
cartId$$B H
,$$H I
new$$J M
PartitionKey$$N Z
($$Z [
cartId$$[ a
)$$a b
,$$b c
cancellationToken$$d u
:$$u v
cancellationToken	$$w à
)
$$à â
;
$$â ä
return&& 
cart&& 
;&& 
}'' 	
catch(( 
((( 
CosmosException(( 
ex(( !
)((! "
when((# '
(((( )
ex(() +
.((+ ,

StatusCode((, 6
==((7 9
System((: @
.((@ A
Net((A D
.((D E
HttpStatusCode((E S
.((S T
NotFound((T \
)((\ ]
{)) 	
return** 
null** 
;** 
}++ 	
},, 
public.. 

async.. 
Task.. 
<.. 
Models.. 
... 
Cart.. !
?..! "
>.." #
GetNextOutdated..$ 3
(..3 4
int..4 7
itemId..8 >
,..> ?
string..@ F
?..F G
newName..H O
,..O P
decimal..Q X
?..X Y
newPrice..Z b
,..b c
CancellationToken..d u
cancellationToken	..v á
)
..á à
{// 
try00 
{11 	

IQueryable22 
<22 
Models22 
.22 
Cart22 "
>22" #
	queryable22$ -
=22. /
	Container220 9
.229 : 
GetItemLinqQueryable22: N
<22N O
Models22O U
.22U V
Cart22V Z
>22Z [
(22[ \
)22\ ]
;22] ^
	queryable33 
=33 
	queryable33 !
.44 
Where44 
(44 
x44 
=>44 
x44 
.44 
Items44 #
.44# $
Any44$ '
(44' (
i44( )
=>44* ,
i44- .
.44. /
ItemId44/ 5
==446 8
itemId449 ?
)44? @
)44@ A
;44A B
if66 
(66 
!66 
string66 
.66 
IsNullOrEmpty66 %
(66% &
newName66& -
)66- .
)66. /
{77 
	queryable88 
=88 
	queryable88 %
.99 
Where99 
(99 
x99 
=>99 
x99  !
.99! "
Items99" '
.99' (
Any99( +
(99+ ,
i99, -
=>99. 0
i991 2
.992 3
Name993 7
!=998 :
newName99; B
)99B C
)99C D
;99D E
}:: 
if<< 
(<< 
newPrice<< 
.<< 
HasValue<< !
)<<! "
{== 
	queryable>> 
=>> 
	queryable>> %
.?? 
Where?? 
(?? 
x?? 
=>?? 
x??  !
.??! "
Items??" '
.??' (
Any??( +
(??+ ,
i??, -
=>??. 0
i??1 2
.??2 3
Price??3 8
!=??9 ;
newPrice??< D
.??D E
Value??E J
)??J K
)??K L
;??L M
}@@ 
usingBB 
varBB 
feedBB 
=BB 
	queryableBB &
.BB& '
ToFeedIteratorBB' 5
(BB5 6
)BB6 7
;BB7 8
varDD 
cartResponseDD 
=DD 
awaitDD $
feedDD% )
.DD) *
ReadNextAsyncDD* 7
(DD7 8
cancellationTokenDD8 I
:DDI J
cancellationTokenDDK \
)DD\ ]
;DD] ^
returnFF 
cartResponseFF 
?FF  
.FF  !
ResourceFF! )
?FF) *
.FF* +
FirstOrDefaultFF+ 9
(FF9 :
)FF: ;
;FF; <
}GG 	
catchHH 
(HH 
CosmosExceptionHH 
exHH !
)HH! "
whenHH# '
(HH( )
exHH) +
.HH+ ,

StatusCodeHH, 6
==HH7 9
SystemHH: @
.HH@ A
NetHHA D
.HHD E
HttpStatusCodeHHE S
.HHS T
NotFoundHHT \
)HH\ ]
{II 	
returnJJ 
nullJJ 
;JJ 
}KK 	
}LL 
publicNN 

asyncNN 
TaskNN 
UpsertNN 
(NN 
stringNN #
cartIdNN$ *
,NN* +
ModelsNN, 2
.NN2 3
CartNN3 7
cartNN8 <
,NN< =
CancellationTokenNN> O
cancellationTokenNNP a
)NNa b
{OO 
awaitPP 
	ContainerPP 
.PP 
UpsertItemAsyncPP '
(PP' (
itemQQ 
:QQ 
cartQQ 
,QQ 
partitionKeyRR 
:RR 
newRR 
PartitionKeyRR *
(RR* +
cartIdRR+ 1
)RR1 2
,RR2 3
cancellationTokenSS 
:SS 
cancellationTokenSS 0
)SS0 1
;SS1 2
}TT 
publicVV 

asyncVV 
TaskVV 
RemoveVV 
(VV 
stringVV #
cartIdVV$ *
,VV* +
CancellationTokenVV, =
cancellationTokenVV> O
)VVO P
=>VVQ S
awaitVVT Y
	ContainerVVZ c
.VVc d
DeleteItemAsyncVVd s
<VVs t
ModelsVVt z
.VVz {
CartVV{ 
>	VV Ä
(
VVÄ Å
cartId
VVÅ á
,
VVá à
new
VVâ å
PartitionKey
VVç ô
(
VVô ö
cartId
VVö †
)
VV† °
,
VV° ¢
cancellationToken
VV£ ¥
:
VV¥ µ
cancellationToken
VV∂ «
)
VV« »
;
VV» …
}WW ¯+
à/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Endpoints/CartEndpoints.cs
	namespace 	
Cart
 
. 
Service 
. 
	Endpoints  
;  !
public 
static 
class 
CartEndpoints !
{ 
private		 
const		 
string		 
CartEndpointsPrefix		 ,
=		- .
$str		/ 6
;		6 7
public 

static 
WebApplication  !
RegisterCartEndpoints! 6
(6 7
this7 ;
WebApplication< J
appK N
)N O
{ 
var 
endpointVersion 
= 
new !
Asp" %
.% &

Versioning& 0
.0 1

ApiVersion1 ;
(; <
$num< =
,= >
$num? @
)@ A
;A B
var 

versionSet 
= 
app 
. 
NewApiVersionSet -
(- .
). /
./ 0
Build0 5
(5 6
)6 7
;7 8
var 
cartApi 
= 
app 
. 
MapGroup 
( 
$str 2
)2 3
. 
WithApiVersionSet 
( 

versionSet )
)) *
;* +
cartApi 
. 
MapGet 
( 
$str %
,% &
GetCart' .
). /
. 
WithTags 
( 
CartEndpointsPrefix )
)) *
. 
WithName 
( 
$" 
{ 
CartEndpointsPrefix ,
}, -
$str- .
{. /
nameof/ 5
(5 6
GetCart6 =
)= >
}> ?
"? @
)@ A
. 
Produces 
< 
Models 
. 
Cart !
[! "
]" #
># $
($ %
StatusCodes% 0
.0 1
Status200OK1 <
)< =
. 
HasApiVersion 
( 
endpointVersion *
)* +
. 
MapToApiVersion 
( 
endpointVersion ,
), -
;- .
cartApi 
. 
	MapDelete 
( 
$str (
,( )
	ClearCart* 3
)3 4
. 
WithTags 
( 
CartEndpointsPrefix )
)) *
. 
WithName 
( 
$" 
{ 
CartEndpointsPrefix ,
}, -
$str- .
{. /
nameof/ 5
(5 6
	ClearCart6 ?
)? @
}@ A
"A B
)B C
.   
Produces   
(   
StatusCodes   !
.  ! "
Status204NoContent  " 4
)  4 5
.!! 
IsApiVersionNeutral!!  
(!!  !
)!!! "
;!!" #
return## 
app## 
;## 
}$$ 
private&& 
static&& 
async&& 
Task&& 
<&& 
Results&& %
<&&% &
Ok&&& (
<&&( )
ModelResponse&&) 6
<&&6 7
Models&&7 =
.&&= >
Cart&&> B
>&&B C
>&&C D
,&&D E
NotFound&&F N
>&&N O
>&&O P
GetCart&&Q X
(&&X Y
['' 	
	FromRoute''	 
]'' 
string'' 
cartId'' !
,''! "
[(( 	
FromServices((	 
](( 
ICartService(( #
cartService(($ /
,((/ 0
CancellationToken)) 
cancellationToken)) +
)))+ ,
{** 
var++ 
cart++ 
=++ 
await++ 
cartService++ $
.++$ %
Get++% (
(++( )
cartId++) /
,++/ 0
cancellationToken++1 B
)++B C
;++C D
if-- 

(-- 
cart-- 
is-- 
null-- 
)-- 
return.. 
TypedResults.. 
...  
NotFound..  (
(..( )
)..) *
;..* +
var00 
response00 
=00 
cart00 
.00 
MapToResponse00 )
(00) *
)00* +
;00+ ,
return22 
TypedResults22 
.22 
Ok22 
(22 
response22 '
)22' (
;22( )
}33 
private55 
static55 
async55 
Task55 
<55 
	NoContent55 '
>55' (
	ClearCart55) 2
(552 3
[66 	
	FromRoute66	 
]66 
string66 
cartId66 !
,66! "
[77 	
FromServices77	 
]77 
ICartItemService77 '
cartService77( 3
,773 4
CancellationToken88 
cancellationToken88 +
)88+ ,
{99 
await:: 
cartService:: 
.:: 
Clear:: 
(::  
cartId::  &
,::& '
cancellationToken::( 9
)::9 :
;::: ;
return<< 
TypedResults<< 
.<< 
	NoContent<< %
(<<% &
)<<& '
;<<' (
}== 
}>> ø
ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Endpoints/CartEndpointsV2.cs
	namespace 	
Cart
 
. 
Service 
. 
	Endpoints  
;  !
public 
static 
class 
CartEndpointsV2 #
{ 
private 
const 
string 
CartEndpointsPrefix ,
=- .
$str/ 6
;6 7
public		 

static		 
WebApplication		  #
RegisterCartEndpointsV2		! 8
(		8 9
this		9 =
WebApplication		> L
app		M P
)		P Q
{

 
var 
endpointsVersion 
= 
new "
Asp# &
.& '

Versioning' 1
.1 2

ApiVersion2 <
(< =
$num= >
,> ?
$num@ A
)A B
;B C
var 

versionSet 
= 
app 
. 
NewApiVersionSet -
(- .
). /
./ 0
Build0 5
(5 6
)6 7
;7 8
var 
cartApi 
= 
app 
. 
MapGroup 
( 
$str 2
)2 3
. 
WithApiVersionSet 
( 

versionSet )
)) *
. 
MapToApiVersion 
( 
endpointsVersion -
)- .
;. /
cartApi 
. 
MapGet 
( 
$str %
,% &
GetCartItems' 3
)3 4
. 
WithTags 
( 
CartEndpointsPrefix )
)) *
. 
WithName 
( 
$" 
{ 
CartEndpointsPrefix ,
}, -
$str- .
{. /
nameof/ 5
(5 6
GetCartItems6 B
)B C
}C D
"D E
)E F
. 
Produces 
< 
Models 
. 
Cart !
[! "
]" #
># $
($ %
StatusCodes% 0
.0 1
Status200OK1 <
)< =
;= >
return 
app 
; 
} 
private 
static 
async 
Task 
< 
Ok  
<  !
Models! '
.' (
CartItem( 0
[0 1
]1 2
>2 3
>3 4
GetCartItems5 A
(A B
[ 	
	FromRoute	 
] 
string 
cartId !
,! "
[ 	
FromServices	 
] 
ICartService #
cartService$ /
,/ 0
CancellationToken 
cancellationToken +
)+ ,
{   
var!! 
cart!! 
=!! 
await!! 
cartService!! $
.!!$ %
Get!!% (
(!!( )
cartId!!) /
,!!/ 0
cancellationToken!!1 B
)!!B C
;!!C D
var"" 
	cartItems"" 
="" 
cart"" 
?"" 
."" 
Items"" #
??""$ &
[""' (
]""( )
;"") *
return$$ 
TypedResults$$ 
.$$ 
Ok$$ 
($$ 
	cartItems$$ (
)$$( )
;$$) *
}%% 
}&& é%
å/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Endpoints/CartItemEndpoints.cs
	namespace 	
Cart
 
. 
Service 
. 
	Endpoints  
;  !
public 
static 
class 
CartItemEndpoints %
{ 
private 
const 
string 
CartEndpointsPrefix ,
=- .
$str/ :
;: ;
public		 

static		 
WebApplication		  &
RegisterCartItemsEndpoints		! ;
(		; <
this		< @
WebApplication		A O
app		P S
)		S T
{

 
var 

versionSet 
= 
app 
. 
NewApiVersionSet -
(- .
). /
./ 0
Build0 5
(5 6
)6 7
;7 8
var 
cartItemsApi 
= 
app 
. 
MapGroup 
( 
$str 2
)2 3
. 
WithApiVersionSet 
( 

versionSet )
)) *
. 
IsApiVersionNeutral  
(  !
)! "
;" #
cartItemsApi 
. 
MapPost 
( 
$str ,
,, -
AddCartItem. 9
)9 :
. 
WithTags 
( 
CartEndpointsPrefix )
)) *
. 
WithName 
( 
$" 
{ 
CartEndpointsPrefix ,
}, -
$str- .
{. /
nameof/ 5
(5 6
AddCartItem6 A
)A B
}B C
"C D
)D E
. 
Produces 
( 
StatusCodes !
.! "
Status204NoContent" 4
)4 5
;5 6
cartItemsApi 
. 
	MapDelete 
( 
$str ;
,; <
DeleteCartItem= K
)K L
. 
WithTags 
( 
CartEndpointsPrefix )
)) *
. 
WithName 
( 
$" 
{ 
CartEndpointsPrefix ,
}, -
$str- .
{. /
nameof/ 5
(5 6
DeleteCartItem6 D
)D E
}E F
"F G
)G H
. 
Produces 
( 
StatusCodes !
.! "
Status204NoContent" 4
)4 5
;5 6
return 
app 
; 
} 
private!! 
static!! 
async!! 
Task!! 
<!! 
	NoContent!! '
>!!' (
AddCartItem!!) 4
(!!4 5
["" 	
	FromRoute""	 
]"" 
string"" 
cartId"" !
,""! "
[## 	
FromBody##	 
]## 
Models## 
.## 
CartItem## "
item### '
,##' (
[$$ 	
FromServices$$	 
]$$ 
ICartItemService$$ '
cartService$$( 3
,$$3 4
CancellationToken%% 
cancellationToken%% +
)%%+ ,
{&& 
await'' 
cartService'' 
.'' 
Add'' 
('' 
cartId'' $
,''$ %
item''& *
,''* +
cancellationToken'', =
)''= >
;''> ?
return)) 
TypedResults)) 
.)) 
	NoContent)) %
())% &
)))& '
;))' (
}** 
private,, 
static,, 
async,, 
Task,, 
<,, 
	NoContent,, '
>,,' (
DeleteCartItem,,) 7
(,,7 8
[-- 	
	FromRoute--	 
]-- 
string-- 
cartId-- !
,--! "
[.. 	
	FromRoute..	 
].. 
int.. 
itemId.. 
,.. 
[// 	
FromServices//	 
]// 
ICartItemService// '
cartService//( 3
,//3 4
CancellationToken00 
cancellationToken00 +
)00+ ,
{11 
await22 
cartService22 
.22 
Remove22  
(22  !
cartId22! '
,22' (
itemId22) /
,22/ 0
cancellationToken221 B
)22B C
;22C D
return44 
TypedResults44 
.44 
	NoContent44 %
(44% &
)44& '
;44' (
}55 
}66 
}/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/GlobalUsings.cs¡
Ö/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Mappings/CartMapping.cs
	namespace 	
Cart
 
. 
Service 
. 
Mappings 
;  
internal 
static	 
class 
CartMapping !
{ 
public 

static 
ModelResponse 
<  
Models  &
.& '
Cart' +
>+ ,
MapToResponse- :
(: ;
this; ?
Models@ F
.F G
CartG K
cartL P
)P Q
{ 
var		 
response		 
=		 
new		 
ModelResponse		 (
<		( )
Models		) /
.		/ 0
Cart		0 4
>		4 5
(		5 6
)		6 7
{

 	
Payload 
= 
cart 
, 
Actions 
= 
[ 
new 
( 
) 
{ 
Method 
= 
HttpMethods (
.( )
Delete) /
,/ 0
Rel 
= 
HttpMethods %
.% &
Delete& ,
,, -
Uri 
= 
$" 
$str #
{# $
cart$ (
.( )
Id) +
}+ ,
", -
} 
] 
} 	
;	 

return 
response 
; 
} 
} Ÿ
|/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Models/Cart.cs
	namespace 	
Cart
 
. 
Service 
. 
Models 
; 
public 
class 
Cart 
{ 
[ 
JsonPropertyName 
( 
$str 
) 
] 
public 

required 
string 
Id 
{ 
get  #
;# $
set% (
;( )
}* +
public

 

CartItem

 
[

 
]

 
Items

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
=

* +
[

, -
]

- .
;

. /
} £

Ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Models/CartItem.cs
	namespace 	
Cart
 
. 
Service 
. 
Models 
; 
public 
class 
CartItem 
{ 
public 

int 
ItemId 
{ 
get 
; 
set  
;  !
}" #
public 

required 
string 
Name 
{  !
get" %
;% &
set' *
;* +
}, -
public		 

decimal		 
Price		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
Quantity 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
? 
ImageUrl 
{ 
get !
;! "
set# &
;& '
}( )
public 

string 
? 
ImageAlt 
{ 
get !
;! "
set# &
;& '
}( )
} ù
ä/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Options/MessageBusOptions.cs
	namespace 	
Cart
 
. 
Service 
. 
Options 
; 
public 
class 
MessageBusOptions 
{ 
public 

const 
string 
Position  
=! "
$str# /
;/ 0
public 

string 
? 
ConnectionString #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} ™
ï/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/ProblemDetailsRegistrations.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
;  
public 
static 
class '
ProblemDetailsRegistrations /
{ 
public 

static 
IServiceCollection $ 
AddAppProblemDetails% 9
(9 :
this: >
IServiceCollection? Q
servicesR Z
)Z [
{		 
services

 
.

 
AddProblemDetails

 "
(

" #
options

# *
=>

+ -
{ 	
options 
. #
CustomizeProblemDetails +
=, -
ctx. 1
=>2 4
{ 
var 
	exception 
= 
ctx  #
.# $
HttpContext$ /
./ 0
Features0 8
.8 9
Get9 <
<< =(
IExceptionHandlerPathFeature= Y
>Y Z
(Z [
)[ \
?\ ]
.] ^
Error^ c
;c d
if 
( 
	exception 
is  
ValidationException! 4
validationException5 H
)H I
{ 
ctx 
. 
ProblemDetails &
.& '
Status' -
=. /
StatusCodes0 ;
.; <(
Status422UnprocessableEntity< X
;X Y
ctx 
. 
ProblemDetails &
.& '
Detail' -
=. /
validationException0 C
.C D
MessageD K
;K L
ctx 
. 
HttpContext #
.# $
Response$ ,
., -

StatusCode- 7
=8 9
StatusCodes: E
.E F(
Status422UnprocessableEntityF b
;b c
} 
} 
; 
} 	
)	 

;
 
return 
services 
; 
} 
} ”
†/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Serialization/AppJsonSerializerContext.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
.  
Serialization  -
;- .
[ 
JsonSerializable 
( 
typeof 
( 
Models 
.  
Cart  $
)$ %
)% &
]& '
[		 
JsonSerializable		 
(		 
typeof		 
(		 
Models		 
.		  
Cart		  $
[		$ %
]		% &
)		& '
)		' (
]		( )
[

 
JsonSerializable

 
(

 
typeof

 
(

 
Models

 
.

  
CartItem

  (
)

( )
)

) *
]

* +
[ 
JsonSerializable 
( 
typeof 
( 
Models 
.  
CartItem  (
[( )
]) *
)* +
)+ ,
], -
[ 
JsonSerializable 
( 
typeof 
( 
RedisOptions %
)% &
)& '
]' (
[ 
JsonSerializable 
( 
typeof 
( 
ModelResponse &
<& '
Models' -
.- .
Cart. 2
>2 3
)3 4
)4 5
]5 6
[ 
JsonSerializable 
( 
typeof 
( 
BaseMessage $
)$ %
)% &
]& '
[ 
JsonSerializable 
( 
typeof 
( !
ProductUpdatedMessage .
). /
)/ 0
]0 1
[ 
JsonSerializable 
( 
typeof 
( !
ProductDeletedMessage .
). /
)/ 0
]0 1
internal 
partial	 
class $
AppJsonSerializerContext /
:0 1!
JsonSerializerContext2 G
{ 
} ⁄	
¢/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Serialization/SerializationRegistrations.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
.  
Serialization  -
;- .
public 
static 
class &
SerializationRegistrations .
{ 
public 

static 
IServiceCollection $
AddAppSerialization% 8
(8 9
this9 =
IServiceCollection> P
servicesQ Y
)Y Z
{ 
services 
. $
ConfigureHttpJsonOptions )
() *
options* 1
=>2 4
{ 	
options		 
.		 
SerializerOptions		 %
.		% &!
TypeInfoResolverChain		& ;
.		; <
Insert		< B
(		B C
$num		C D
,		D E$
AppJsonSerializerContext		F ^
.		^ _
Default		_ f
)		f g
;		g h
}

 	
)

	 

;


 
return 
services 
; 
} 
} ˜.
ô/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Swagger/ConfigureSwaggerOptions.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
.  
Swagger  '
;' (
public 
class #
ConfigureSwaggerOptions $
($ %*
IApiVersionDescriptionProvider% C
providerD L
)L M
:N O
IConfigureOptionsP a
<a b
SwaggerGenOptionsb s
>s t
{ 
public 

void 
	Configure 
( 
SwaggerGenOptions +
options, 3
)3 4
{ 
foreach 
( 
var 
description  
in! #
provider$ ,
., -"
ApiVersionDescriptions- C
)C D
{ 	
options 
. 

SwaggerDoc 
( 
description *
.* +
	GroupName+ 4
,4 5#
CreateInfoForApiVersion6 M
(M N
descriptionN Y
)Y Z
)Z [
;[ \
} 	
} 
private 
static 
OpenApiInfo #
CreateInfoForApiVersion 6
(6 7!
ApiVersionDescription7 L
descriptionM X
)X Y
{ 
var 
text 
= 
new 
StringBuilder $
($ %
$str% @
)@ A
;A B
var 
info 
= 
new 
OpenApiInfo "
(" #
)# $
{ 	
Title 
= 
$str "
," #
Version   
=   
description   !
.  ! "

ApiVersion  " ,
.  , -
ToString  - 5
(  5 6
)  6 7
,  7 8
Contact!! 
=!! 
new!! 
OpenApiContact!! (
(!!( )
)!!) *
{!!+ ,
Name!!- 1
=!!2 3
$str!!4 =
,!!= >
Email!!? D
=!!E F
$str!!G [
}!!\ ]
,!!] ^
License"" 
="" 
new"" 
OpenApiLicense"" (
(""( )
)"") *
{""+ ,
Name""- 1
=""2 3
$str""4 9
,""9 :
Url""; >
=""? @
new""A D
Uri""E H
(""H I
$str""I n
)""n o
}""p q
}## 	
;##	 

if%% 

(%% 
description%% 
.%% 
IsDeprecated%% $
)%%$ %
{&& 	
text'' 
.'' 
Append'' 
('' 
$str'' @
)''@ A
;''A B
}(( 	
if** 

(** 
description** 
.** 
SunsetPolicy** $
is**% '
{**( )
}*** +
policy**, 2
)**2 3
{++ 	
if,, 
(,, 
policy,, 
.,, 
HasLinks,, 
),,  
{-- 
text.. 
... 

AppendLine.. 
(..  
)..  !
;..! "
var00 
rendered00 
=00 
false00 $
;00$ %
for22 
(22 
var22 
i22 
=22 
$num22 
;22 
i22  !
<22" #
policy22$ *
.22* +
Links22+ 0
.220 1
Count221 6
;226 7
i228 9
++229 ;
)22; <
{33 
var44 
link44 
=44 
policy44 %
.44% &
Links44& +
[44+ ,
i44, -
]44- .
;44. /
if66 
(66 
link66 
.66 
Type66 !
==66" $
$str66% 0
)660 1
{77 
if88 
(88 
!88 
rendered88 %
)88% &
{99 
text::  
.::  !
Append::! '
(::' (
$str::( <
)::< =
;::= >
rendered;; $
=;;% &
true;;' +
;;;+ ,
}<< 
text>> 
.>> 
Append>> #
(>># $
$str>>$ 4
)>>4 5
;>>5 6
text?? 
.?? 
Append?? #
(??# $
link??$ (
.??( )

LinkTarget??) 3
.??3 4
OriginalString??4 B
)??B C
;??C D
text@@ 
.@@ 
Append@@ #
(@@# $
$str@@$ )
)@@) *
;@@* +
textAA 
.AA 
AppendAA #
(AA# $
StringSegmentBB )
.BB) *
IsNullOrEmptyBB* 7
(BB7 8
linkBB8 <
.BB< =
TitleBB= B
)BBB C
?CC 
linkCC "
.CC" #

LinkTargetCC# -
.CC- .
OriginalStringCC. <
:DD 
linkDD "
.DD" #
TitleDD# (
.DD( )
ToStringDD) 1
(DD1 2
)DD2 3
)DD3 4
;DD4 5
textEE 
.EE 
AppendEE #
(EE# $
$strEE$ /
)EE/ 0
;EE0 1
}FF 
}GG 
ifII 
(II 
renderedII 
)II 
{JJ 
textKK 
.KK 
AppendKK 
(KK  
$strKK  '
)KK' (
;KK( )
}LL 
}MM 
}NN 	
textPP 
.PP 
AppendPP 
(PP 
$strPP 5
)PP5 6
;PP6 7
infoQQ 
.QQ 
DescriptionQQ 
=QQ 
textQQ 
.QQ  
ToStringQQ  (
(QQ( )
)QQ) *
;QQ* +
returnSS 
infoSS 
;SS 
}TT 
}UU º/
ñ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Swagger/SwaggerDefaultValues.cs
	namespace		 	
Cart		
 
.		 
Service		 
.		 
Platform		 
.		  
Swagger		  '
;		' (
public 
class  
SwaggerDefaultValues !
:" #
IOperationFilter$ 4
{ 
[ 
SuppressMessage 
( 
$str 
,  
$str	! º
,
º Ω
Justification
æ À
=
Ã Õ
$str
Œ Ÿ
)
Ÿ ⁄
]
⁄ €
[ 
SuppressMessage 
( 
$str 
, 
$str	 é
,
é è
Justification
ê ù
=
û ü
$str
† ´
)
´ ¨
]
¨ ≠
public 

void 
Apply 
( 
OpenApiOperation &
	operation' 0
,0 1"
OperationFilterContext2 H
contextI P
)P Q
{ !
ArgumentNullException 
. 
ThrowIfNull )
() *
context* 1
,1 2
nameof3 9
(9 :
context: A
)A B
)B C
;C D!
ArgumentNullException 
. 
ThrowIfNull )
() *
	operation* 3
,3 4
nameof5 ;
(; <
	operation< E
)E F
)F G
;G H
var 
apiDescription 
= 
context $
.$ %
ApiDescription% 3
;3 4
	operation 
. 

Deprecated 
|= 
apiDescription  .
.. /
IsDeprecated/ ;
(; <
)< =
;= >
foreach 
( 
var 
responseType !
in" $
context% ,
., -
ApiDescription- ;
.; <"
SupportedResponseTypes< R
)R S
{ 	
var 
responseKey 
= 
responseType *
.* +
IsDefaultResponse+ <
?= >
$str? H
:I J
responseTypeK W
.W X

StatusCodeX b
.b c
ToStringc k
(k l
)l m
;m n
var 
response 
= 
	operation $
.$ %
	Responses% .
[. /
responseKey/ :
]: ;
;; <
foreach   
(   
var   
contentType   $
in  % '
response  ( 0
.  0 1
Content  1 8
.  8 9
Keys  9 =
)  = >
{!! 
if"" 
("" 
!"" 
responseType"" !
.""! "
ApiResponseFormats""" 4
.""4 5
Any""5 8
(""8 9
x""9 :
=>""; =
x""> ?
.""? @
	MediaType""@ I
==""J L
contentType""M X
)""X Y
)""Y Z
{## 
response$$ 
.$$ 
Content$$ $
.$$$ %
Remove$$% +
($$+ ,
contentType$$, 7
)$$7 8
;$$8 9
}%% 
}&& 
}'' 	
if)) 

()) 
	operation)) 
.)) 

Parameters))  
==))! #
null))$ (
)))( )
{** 	
return++ 
;++ 
},, 	
foreach00 
(00 
var00 
	parameter00 
in00 !
	operation00" +
.00+ ,

Parameters00, 6
)006 7
{11 	
var22 
description22 
=22 
apiDescription22 ,
.22, -!
ParameterDescriptions22- B
.22B C
First22C H
(22H I
p22I J
=>22K M
p22N O
.22O P
Name22P T
==22U W
	parameter22X a
.22a b
Name22b f
)22f g
;22g h
	parameter44 
.44 
Description44 !
??=44" %
description44& 1
.441 2
ModelMetadata442 ?
?44? @
.44@ A
Description44A L
;44L M
if66 
(66 
	parameter66 
.66 
Schema66  
.66  !
Default66! (
==66) +
null66, 0
&&661 3
description77 
.77 
DefaultValue77 )
!=77* ,
null77- 1
&&772 4
description88 
.88 
DefaultValue88 )
is88* ,
not88- 0
DBNull881 7
&&888 :
description99 
.99 
ModelMetadata99 *
is99+ -
ModelMetadata99. ;
modelMetadata99< I
)99I J
{:: 
var<< 
json<< 
=<< 
JsonSerializer<< )
.<<) *
	Serialize<<* 3
(<<3 4
value== 
:== 
description== &
.==& '
DefaultValue==' 3
,==3 4
	inputType>> 
:>> 
modelMetadata>> ,
.>>, -
	ModelType>>- 6
,>>6 7
options?? 
:?? 
new??  
(??  !
)??! "
{@@ 
TypeInfoResolverAA (
=AA) *$
AppJsonSerializerContextAA+ C
.AAC D
DefaultAAD K
}BB 
)BB 
;BB 
	parameterCC 
.CC 
SchemaCC  
.CC  !
DefaultCC! (
=CC) *
OpenApiAnyFactoryCC+ <
.CC< =
CreateFromJsonCC= K
(CCK L
jsonCCL P
)CCP Q
;CCQ R
}DD 
	parameterFF 
.FF 
RequiredFF 
|=FF !
descriptionFF" -
.FF- .

IsRequiredFF. 8
;FF8 9
}GG 	
}HH 
}II ç
ñ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Swagger/SwaggerRegistrations.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
.  
Swagger  '
;' (
public 
static 
class  
SwaggerRegistrations (
{ 
public 

static 
IServiceCollection $
AddAppSwagger% 2
(2 3
this3 7
IServiceCollection8 J
servicesK S
)S T
{		 
services

 
.

 
AddTransient

 
<

 
IConfigureOptions

 /
<

/ 0
SwaggerGenOptions

0 A
>

A B
,

B C#
ConfigureSwaggerOptions

D [
>

[ \
(

\ ]
)

] ^
;

^ _
services 
. 
AddSwaggerGen 
( 
options &
=>' )
options* 1
.1 2
OperationFilter2 A
<A B 
SwaggerDefaultValuesB V
>V W
(W X
)X Y
)Y Z
;Z [
return 
services 
; 
} 
public 

static 
WebApplication  
UseAppSwagger! .
(. /
this/ 3
WebApplication4 B
appC F
)F G
{ 
app 
. 

UseSwagger 
( 
) 
; 
app 
. 
UseSwaggerUI 
( 
options  
=>! #
{ 	
var  
documentDescriptions $
=% &
app' *
.* +
DescribeApiVersions+ >
(> ?
)? @
;@ A
foreach 
( 
var 
document !
in" $ 
documentDescriptions% 9
)9 :
{ 
var 
url 
= 
$" 
$str %
{% &
document& .
.. /
	GroupName/ 8
}8 9
$str9 F
"F G
;G H
var 
name 
= 
document #
.# $
	GroupName$ -
;- .
options 
. 
SwaggerEndpoint '
(' (
url( +
,+ ,
name- 1
)1 2
;2 3
} 
} 	
)	 

;
 
return 
app 
; 
}   
}!! æ
ï/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Versioning/VersionConstants.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
.  

Versioning  *
;* +
internal 
static	 
class 
VersionConstants &
{ 
public 

static 
readonly 

ApiVersion %
DefaultApiVersion& 7
=8 9
new: =

ApiVersion> H
(H I
$numI J
,J K
$numL M
)M N
;N O
} Û
ú/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Platform/Versioning/VersioningRegistrations.cs
	namespace 	
Cart
 
. 
Service 
. 
Platform 
.  

Versioning  *
;* +
internal 
static	 
class #
VersioningRegistrations -
{ 
public 

static 
IServiceCollection $
AddAppVersioning% 5
(5 6
this6 :
IServiceCollection; M
servicesN V
)V W
{ 
services		 
.

 
AddApiVersioning

 
(

 
options

 %
=>

& (
{ 
options 
. 
DefaultApiVersion )
=* +
VersionConstants, <
.< =
DefaultApiVersion= N
;N O
options 
. 
ReportApiVersions )
=* +
true, 0
;0 1
options 
. /
#AssumeDefaultVersionWhenUnspecified ;
=< =
true> B
;B C
options 
. 
ApiVersionReader (
=) *
new+ .&
UrlSegmentApiVersionReader/ I
(I J
)J K
;K L
} 
) 
. 
AddApiExplorer 
( 
options #
=>$ &
{ 
options 
. 
GroupNameFormat '
=( )
$str* 2
;2 3
options 
. 
DefaultApiVersion )
=* +
VersionConstants, <
.< =
DefaultApiVersion= N
;N O
options 
. 5
)AddApiVersionParametersWhenVersionNeutral A
=B C
trueD H
;H I
options 
. %
SubstituteApiVersionInUrl 1
=2 3
true4 8
;8 9
} 
) 
. #
EnableApiVersionBinding $
($ %
)% &
;& '
return 
services 
; 
} 
}   ¶
x/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Program.cs
	namespace 	
Cart
 
. 
Service 
; 
public 
static 
class 
Program 
{ 
public 

static 
void 
Main 
( 
string "
[" #
]# $
args% )
)) *
{ 
WebApplication 
. 
CreateSlimBuilder 
( 
args #
)# $
.		 
RegisterAppServices		  
(		  !
)		! "
.

 
Build

 
(

 
)

 
. 
UseAppPipeline 
( 
) 
. 
Run 
( 
) 
; 
} 
} û
Ç/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Program.Pipelines.cs
	namespace 	
Cart
 
. 
Service 
; 
public 
static 
class 
ProgramPipelines $
{ 
public 

static 
WebApplication  
UseAppPipeline! /
(/ 0
this0 4
WebApplication5 C
appD G
)G H
{		 
app

 
.

 !
RegisterCartEndpoints

 !
(

! "
)

" #
;

# $
app 
. #
RegisterCartEndpointsV2 #
(# $
)$ %
;% &
app 
. &
RegisterCartItemsEndpoints &
(& '
)' (
;( )
app 
. 
UseAppSwagger 
( 
) 
; 
return 
app 
; 
} 
} ó
Å/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/Program.Services.cs
	namespace 	
Cart
 
. 
Service 
; 
public 
static 
class 
ProgramServices #
{ 
public 

static !
WebApplicationBuilder '
RegisterAppServices( ;
(; <
this< @!
WebApplicationBuilderA V
builderW ^
)^ _
{ 
builder 
. 
Services 
. 
AddAppSerialization ,
(, -
)- .
;. /
builder 
. 
Services 
.  
AddAppProblemDetails -
(- .
). /
;/ 0
builder 
. 
Services 
. 
AddAppVersioning )
() *
)* +
;+ ,
builder 
. 
Services 
. #
AddEndpointsApiExplorer 0
(0 1
)1 2
;2 3
builder 
. 
Services 
. 
AddAppSwagger &
(& '
)' (
;( )
var 
messageBusOptions 
= 
new  #
MessageBusOptions$ 5
(5 6
)6 7
;7 8
builder 
. 
Configuration 
. 

GetSection (
(( )
MessageBusOptions) :
.: ;
Position; C
)C D
.D E
BindE I
(I J
messageBusOptionsJ [
)[ \
;\ ]
builder 
. 
Services 
. 
AddAzureClients (
(( )
builder) 0
=>1 3
{ 	
builder 
. 
AddServiceBusClient '
(' (
messageBusOptions( 9
.9 :
ConnectionString: J
)J K
;K L
} 	
)	 

;
 
builder 
. 
Services 
. 
AddHostedService )
<) *!
OutboxMessageListener* ?
>? @
(@ A
)A B
;B C
builder   
.   
Services   
.!! *
ConfigureBusinessLogicServices!! +
(!!+ ,
builder!!, 3
.!!3 4
Configuration!!4 A
)!!A B
."" '
ConfigureDataAccessServices"" (
(""( )
builder"") 0
.""0 1
Configuration""1 >
)""> ?
;""? @
return$$ 
builder$$ 
;$$ 
}%% 
}&& Ô
á/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/ViewModels/ModelAction.cs
	namespace 	
Cart
 
. 
Service 
. 

ViewModels !
;! "
internal 
class	 
ModelAction 
{ 
public 

required 
string 
Rel 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

required 
string 
Uri 
{  
get! $
;$ %
set& )
;) *
}+ ,
public		 

required		 
string		 
Method		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
}

 º
â/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Cart.Service/Cart.Service/ViewModels/ModelResponse.cs
	namespace 	
Cart
 
. 
Service 
. 

ViewModels !
;! "
internal 
class	 
ModelResponse 
< 
T 
> 
{ 
public 

required 
T 
Payload 
{ 
get  #
;# $
set% (
;( )
}* +
public 

ModelAction 
[ 
] 
Actions  
{! "
get# &
;& '
set( +
;+ ,
}- .
=/ 0
[1 2
]2 3
;3 4
} 