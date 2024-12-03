µ
°/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Abstractions/IApplicationDbContext.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Abstractions" .
;. /
internal 
	interface	 !
IApplicationDbContext (
{ 
DbSet		 	
<			 

Category		
 
>		 

Categories		 
{		  
get		! $
;		$ %
}		& '
DbSet

 	
<

	 

Product


 
>

 
Products

 
{

 
get

 !
;

! "
}

# $
DbSet 	
<	 

	BaseEvent
 
> 
Events 
{ 
get !
;! "
}# $
Task 
< 	
int	 
> 
SaveChangesAsync 
( 
CancellationToken 0
cancellationToken1 B
)B C
;C D
} ô
ò/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/ApplicationDbContext.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
;& '
internal		 
class			  
ApplicationDbContext		 #
:		$ %
	DbContext		& /
,		/ 0!
IApplicationDbContext		1 F
{

 
public 
 
ApplicationDbContext 
(  
)  !
{ 
} 
public 
 
ApplicationDbContext 
(  
DbContextOptions  0
<0 1 
ApplicationDbContext1 E
>E F
optionsG N
)N O
:P Q
baseR V
(V W
optionsW ^
)^ _
{ 
} 
public 

DbSet 
< 
Category 
> 

Categories %
=>& (
Set) ,
<, -
Category- 5
>5 6
(6 7
)7 8
;8 9
public 

DbSet 
< 
Product 
> 
Products "
=># %
Set& )
<) *
Product* 1
>1 2
(2 3
)3 4
;4 5
public 

DbSet 
< 
	BaseEvent 
> 
Events "
=># %
Set& )
<) *
	BaseEvent* 3
>3 4
(4 5
)5 6
;6 7
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
modelBuilder9 E
)E F
{ 
base 
. 
OnModelCreating 
( 
modelBuilder )
)) *
;* +
modelBuilder 
. +
ApplyConfigurationsFromAssembly 4
(4 5
Assembly5 =
.= > 
GetExecutingAssembly> R
(R S
)S T
)T U
;U V
} 
} ◊
®/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Configurations/CategoryConfiguration.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Configurations' 5
;5 6
public 
class !
CategoryConfiguration "
:# $$
IEntityTypeConfiguration% =
<= >
Category> F
>F G
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
Category		, 4
>		4 5
builder		6 =
)		= >
{

 
builder 
. 
Property 
( 
x 
=> 
x 
.  
Name  $
)$ %
. 

IsRequired 
( 
) 
. 
HasMaxLength 
( 
$num 
) 
; 
builder 
. 
HasMany 
( 
x 
=> 
x 
. 
Products $
)$ %
. 
WithOne 
( 
x 
=> 
x 
. 
Category $
)$ %
. 
HasForeignKey 
( 
x 
=> 
x  !
.! "

CategoryId" ,
), -
. 
OnDelete 
( 
DeleteBehavior $
.$ %
ClientCascade% 2
)2 3
;3 4
builder 
. 
HasOne 
( 
x 
=> 
x 
. 
ParentCategory )
)) *
. 
WithMany 
( 
x 
=> 
x 
. 
ChildCategories ,
), -
. 
HasForeignKey 
( 
x 
=> 
x  !
.! "
ParentCategoryId" 2
)2 3
. 
OnDelete 
( 
DeleteBehavior $
.$ %
ClientSetNull% 2
)2 3
;3 4
} 
} ı

•/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Configurations/EventConfiguration.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Configurations' 5
;5 6
public 
class 
EventConfiguration 
:  !$
IEntityTypeConfiguration" :
<: ;
	BaseEvent; D
>D E
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
	BaseEvent		, 5
>		5 6
builder		7 >
)		> ?
{

 
builder 
. 
HasDiscriminator 
( 
x 
=>  "
x# $
.$ %
Discriminator% 2
)2 3
. 
HasValue 
< 
ProductUpdatedEvent )
>) *
(* +
nameof+ 1
(1 2
ProductUpdatedEvent2 E
)E F
)F G
. 
HasValue 
< 
ProductDeletedEvent )
>) *
(* +
nameof+ 1
(1 2
ProductDeletedEvent2 E
)E F
)F G
;G H
} 
} È

ß/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Configurations/ProductConfiguration.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Configurations' 5
;5 6
public 
class  
ProductConfiguration !
:" #$
IEntityTypeConfiguration$ <
<< =
Product= D
>D E
{ 
public		 

void		 
	Configure		 
(		 
EntityTypeBuilder		 +
<		+ ,
Product		, 3
>		3 4
builder		5 <
)		< =
{

 
builder 
. 
Property 
( 
x 
=> 
x 
.  
Name  $
)$ %
. 

IsRequired 
( 
) 
. 
HasMaxLength 
( 
$num 
) 
; 
builder 
. 
Property 
( 
x 
=> 
x 
.  
Price  %
)% &
. 
HasColumnType 
( 
$str "
)" #
;# $
} 
} ÷+
™/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Interceptors/PopulateEventsInterceptor.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Interceptors' 3
;3 4
public 
class %
PopulateEventsInterceptor &
:' ("
SaveChangesInterceptor) ?
{		 
public

 

override

 
InterceptionResult

 &
<

& '
int

' *
>

* +
SavingChanges

, 9
(

9 :
DbContextEventData

: L
	eventData

M V
,

V W
InterceptionResult

X j
<

j k
int

k n
>

n o
result

p v
)

v w
{ 
TrackProductsEvents 
( 
	eventData %
.% &
Context& -
,- .
default/ 6
)6 7
.7 8

GetAwaiter8 B
(B C
)C D
.D E
	GetResultE N
(N O
)O P
;P Q
return 
base 
. 
SavingChanges !
(! "
	eventData" +
,+ ,
result- 3
)3 4
;4 5
} 
public 

override 
async 
	ValueTask #
<# $
InterceptionResult$ 6
<6 7
int7 :
>: ;
>; <
SavingChangesAsync= O
(O P
DbContextEventDataP b
	eventDatac l
,l m
InterceptionResult	n Ä
<
Ä Å
int
Å Ñ
>
Ñ Ö
result
Ü å
,
å ç
CancellationToken
é ü
cancellationToken
† ±
=
≤ ≥
default
¥ ª
)
ª º
{ 
await 
TrackProductsEvents !
(! "
	eventData" +
.+ ,
Context, 3
,3 4
cancellationToken5 F
)F G
.G H
ConfigureAwaitH V
(V W
falseW \
)\ ]
;] ^
return 
await 
base 
. 
SavingChangesAsync ,
(, -
	eventData- 6
,6 7
result8 >
,> ?
cancellationToken@ Q
)Q R
.R S
ConfigureAwaitS a
(a b
falseb g
)g h
;h i
} 
public 

static 
async 
Task 
TrackProductsEvents 0
(0 1
	DbContext1 :
?: ;
context< C
,C D
CancellationTokenE V
cancellationTokenW h
=i j
defaultk r
)r s
{ 
if 

( 
context 
is 
null 
) 
return 
; 
var  
deletedProductEvents  
=! "
context# *
. 
ChangeTracker 
. 
Entries 
< 
Product 
> 
( 
) 
. 
Where 
( 
x 
=> 
x 
. 
State 
==  "
EntityState# .
.. /
Deleted/ 6
)6 7
.   
Select   
(   
x   
=>   
new   
ProductDeletedEvent   0
(  0 1
x  1 2
.  2 3
Entity  3 9
.  9 :
Id  : <
)  < =
)  = >
.!! 
ToList!! 
(!! 
)!! 
;!! 
var##  
updatedProductEvents##  
=##! "
context### *
.$$ 
ChangeTracker$$ 
.%% 
Entries%% 
<%% 
Product%% 
>%% 
(%% 
)%% 
.&& 
Where&& 
(&& 
x&& 
=>&& 
x&& 
.&& 
State&& 
==&&  "
EntityState&&# .
.&&. /
Modified&&/ 7
)&&7 8
.'' 
Select'' 
('' 
x'' 
=>'' 
new'' 
ProductUpdatedEvent'' 0
(''0 1
x''1 2
.''2 3
Entity''3 9
.''9 :
Id'': <
,''< =
x''> ?
.''? @
Entity''@ F
.''F G
Name''G K
,''K L
x''M N
.''N O
Entity''O U
.''U V
Price''V [
)''[ \
)''\ ]
.(( 
ToList(( 
((( 
)(( 
;(( 
if** 

(**  
deletedProductEvents**  
.**  !
Count**! &
>**' (
$num**) *
)*** +
await++ 
context++ 
.++ 
AddRangeAsync++ '
(++' ( 
deletedProductEvents++( <
,++< =
cancellationToken++> O
)++O P
;++P Q
if-- 

(--  
updatedProductEvents--  
.--  !
Count--! &
>--' (
$num--) *
)--* +
await.. 
context.. 
... 
AddRangeAsync.. '
(..' ( 
updatedProductEvents..( <
,..< =
cancellationToken..> O
)..O P
;..P Q
}// 
}00 ©%
£/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Repositories/CategoryRepository.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Repositories' 3
;3 4
internal 
class	 
CategoryRepository !
(! "!
IApplicationDbContext" 7
context8 ?
)? @
:A B
ICategoryRepositoryC V
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
 
Category

 
>

 
Add

  #
(

# $
Category

$ ,
category

- 5
,

5 6
CancellationToken

7 H
cancellationToken

I Z
=

[ \
default

] d
)

d e
{ 
context 
. 

Categories 
. 
Add 
( 
category '
)' (
;( )
await 
context 
. 
SaveChangesAsync &
(& '
cancellationToken' 8
)8 9
;9 :
return 
category 
; 
} 
public 

async 
Task 
Delete 
( 
Category %
category& .
,. /
CancellationToken0 A
cancellationTokenB S
=T U
defaultV ]
)] ^
{ 
context 
. 

Categories 
. 
Remove !
(! "
category" *
)* +
;+ ,
await 
context 
. 
SaveChangesAsync &
(& '
cancellationToken' 8
)8 9
;9 :
} 
public 

async 
Task 
< 
Category 
> 
Get  #
(# $
int$ '
id( *
,* +
CancellationToken, =
cancellationToken> O
=P Q
defaultR Y
)Y Z
{ 
var 
entity 
= 
await 
context "
." #

Categories# -
. 
Where 
( 
x 
=> 
x 
. 
Id 
== 
id  "
)" #
. 
AsNoTracking 
( 
) 
. 

FirstAsync 
( 
cancellationToken )
)) *
;* +
return 
entity 
; 
}   
public"" 

async"" 
Task"" 
<"" 
Category"" 
["" 
]""  
>""  !
List""" &
(""& '
int""' *
?""* +
parentCategory"", :
,"": ;
CancellationToken""< M
cancellationToken""N _
=""` a
default""b i
)""i j
{## 

IQueryable$$ 
<$$ 
Category$$ 
>$$ 

categories$$ '
=$$( )
context$$* 1
.$$1 2

Categories$$2 <
;$$< =
if%% 

(%% 
parentCategory%% 
.%% 
HasValue%% #
)%%# $
{&& 	

categories'' 
='' 

categories'' #
.(( 
Where(( 
((( 
x(( 
=>(( 
x(( 
.(( 
ParentCategoryId(( .
==((/ 1
parentCategory((2 @
.((@ A
Value((A F
)((F G
;((G H
})) 	
var++ 
entities++ 
=++ 
await++ 

categories++ '
.,, 
AsNoTracking,, 
(,, 
),, 
.-- 
ToArrayAsync-- 
(-- 
cancellationToken-- +
)--+ ,
;--, -
return// 
entities// 
;// 
}00 
public22 

async22 
Task22 
Update22 
(22 
Category22 %
category22& .
,22. /
CancellationToken220 A
cancellationToken22B S
=22T U
default22V ]
)22] ^
{33 
context44 
.44 

Categories44 
.44 
Update44 !
(44! "
category44" *
)44* +
;44+ ,
await55 
context55 
.55 
SaveChangesAsync55 &
(55& '
cancellationToken55' 8
)558 9
;559 :
}66 
}77 ¶
ß/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Repositories/OutboxEventsRepository.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Repositories' 3
;3 4
internal 
class	 "
OutboxEventsRepository %
(% &!
IApplicationDbContext& ;
context< C
)C D
:E F#
IOutboxEventsRepositoryG ^
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
 
	BaseEvent

 
?

  
>

  !
GetNextUnprocessed

" 4
(

4 5
CancellationToken

5 F
cancellationToken

G X
)

X Y
{ 
var 
entity 
= 
await 
context "
. 
Events 
. 
AsNoTracking 
( 
) 
. 
FirstOrDefaultAsync  
(  !
x! "
=># %
x& '
.' (
	Processed( 1
==2 4
false5 :
,: ;
cancellationToken< M
)M N
;N O
return 
entity 
; 
} 
public 

async 
Task 
Update 
( 
	BaseEvent &
outboxEvent' 2
,2 3
CancellationToken4 E
cancellationTokenF W
)W X
{ 
context 
. 
Events 
. 
Update 
( 
outboxEvent )
)) *
;* +
await 
context 
. 
SaveChangesAsync &
(& '
cancellationToken' 8
)8 9
;9 :
} 
} Ã)
¢/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Data/Repositories/ProductRepository.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Data" &
.& '
Repositories' 3
;3 4
internal 
class	 
ProductRepository  
(  !!
IApplicationDbContext! 6
context7 >
)> ?
:@ A
IProductRepositoryB T
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
 
Product

 
>

 
Add

 "
(

" #
Product

# *
product

+ 2
,

2 3
CancellationToken

4 E
cancellationToken

F W
=

X Y
default

Z a
)

a b
{ 
context 
. 
Products 
. 
Add 
( 
product $
)$ %
;% &
await 
context 
. 
SaveChangesAsync &
(& '
cancellationToken' 8
)8 9
;9 :
return 
product 
; 
} 
public 

async 
Task 
Delete 
( 
Product $
product% ,
,, -
CancellationToken. ?
cancellationToken@ Q
=R S
defaultT [
)[ \
{ 
context 
. 
Products 
. 
Remove 
(  
product  '
)' (
;( )
await 
context 
. 
SaveChangesAsync &
(& '
cancellationToken' 8
)8 9
;9 :
} 
public 

async 
Task 
< 
Product 
> 
Get "
(" #
int# &
id' )
,) *
CancellationToken+ <
cancellationToken= N
=O P
defaultQ X
)X Y
{ 
var 
entity 
= 
await 
context "
." #
Products# +
. 
Where 
( 
x 
=> 
x 
. 
Id 
== 
id  "
)" #
. 
AsNoTracking 
( 
) 
. 

FirstAsync 
( 
cancellationToken )
)) *
;* +
return 
entity 
; 
}   
public"" 

async"" 
Task"" 
<"" 
Product"" 
["" 
]"" 
>""  
List""! %
(""% &
int""& )
?"") *

categoryId""+ 5
,""5 6
int""7 :
currentPage""; F
,""F G
int""H K
pageSize""L T
,""T U
CancellationToken""V g
cancellationToken""h y
=""z {
default	""| É
)
""É Ñ
{## 
var$$ 
	skipCount$$ 
=$$ 
pageSize$$  
*$$! "
currentPage$$# .
;$$. /

IQueryable&& 
<&& 
Product&& 
>&& 
products&& $
=&&% &
context&&' .
.&&. /
Products&&/ 7
;&&7 8
if(( 

((( 

categoryId(( 
.(( 
HasValue(( 
)((  
{)) 	
products** 
=** 
products** 
.++ 
Where++ 
(++ 
x++ 
=>++ 
x++ 
.++ 

CategoryId++ (
==++) +

categoryId++, 6
)++6 7
;++7 8
},, 	
products// 
=// 
products// 
.00 
OrderBy00 
(00 
x00 
=>00 
x00 
.00 
Id00 
)00 
.11 
Skip11 
(11 
	skipCount11 
)11 
.22 
Take22 
(22 
pageSize22 
)22 
;22 
var44 
entities44 
=44 
await44 
products44 %
.55 
AsNoTracking55 
(55 
)55 
.66 
ToArrayAsync66 
(66 
cancellationToken66 +
)66+ ,
;66, -
return88 
entities88 
;88 
}99 
public;; 

async;; 
Task;; 
Update;; 
(;; 
Product;; $
product;;% ,
,;;, -
CancellationToken;;. ?
cancellationToken;;@ Q
=;;R S
default;;T [
);;[ \
{<< 
context== 
.== 
Products== 
.== 
Update== 
(==  
product==  '
)==' (
;==( )
await>> 
context>> 
.>> 
SaveChangesAsync>> &
(>>& '
cancellationToken>>' 8
)>>8 9
;>>9 :
}?? 
}@@ ê
í/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/DependencyInjection.cs
	namespace 	
Infrastructure
 
. 
Database !
;! "
public 
static 
class 
DependencyInjection '
{ 
public 

static 
IServiceCollection $+
ConfigureInfrastructureServices% D
(D E
this 
IServiceCollection 
services  (
,( )
SqlDatabaseOptions 

sqlOptions %
)% &
{ 
services 
. 
AddDbContext 
<  
ApplicationDbContext 2
>2 3
(3 4
(4 5
sp5 7
,7 8
options9 @
)@ A
=>B D
{ 	
options 
. 
AddInterceptors #
(# $
sp$ &
.& '
GetRequiredService' 9
<9 :#
ISaveChangesInterceptor: Q
>Q R
(R S
)S T
)T U
;U V
options 
. 
UseSqlServer  
(  !

sqlOptions! +
.+ ,'
SqlDatabaseConnectionString, G
)G H
;H I
} 	
)	 

;
 
services 
. 
	AddScoped 
< !
IApplicationDbContext ,
,, - 
ApplicationDbContext. B
>B C
(C D
)D E
. 
	AddScoped 
< #
ISaveChangesInterceptor .
,. /%
PopulateEventsInterceptor0 I
>I J
(J K
)K L
. 
	AddScoped 
< 
ICategoryRepository *
,* +
CategoryRepository, >
>> ?
(? @
)@ A
. 
	AddScoped 
< 
IProductRepository )
,) *
ProductRepository+ <
>< =
(= >
)> ?
. 
	AddScoped 
< #
IOutboxEventsRepository .
,. /"
OutboxEventsRepository0 F
>F G
(G H
)H I
;I J
return   
services   
;   
}!! 
}"" äY
ù/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Migrations/20241120174621_Init.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "

Migrations" ,
{ 
public		 

partial		 
class		 
Init		 
:		 
	Migration		  )
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str "
," #
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 6
,6 7
nullable8 @
:@ A
falseB G
)G H
. 

Annotation #
(# $
$str$ 8
,8 9
$str: @
)@ A
,A B
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 D
,D E
	maxLengthF O
:O P
$numQ S
,S T
nullableU ]
:] ^
false_ d
)d e
,e f
Image 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 F
,F G
nullableH P
:P Q
trueR V
)V W
,W X
ParentCategoryId $
=% &
table' ,
., -
Column- 3
<3 4
int4 7
>7 8
(8 9
type9 =
:= >
$str? D
,D E
nullableF N
:N O
trueP T
)T U
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 4
,4 5
x6 7
=>8 :
x; <
.< =
Id= ?
)? @
;@ A
table 
. 

ForeignKey $
($ %
name 
: 
$str I
,I J
column 
: 
x  !
=>" $
x% &
.& '
ParentCategoryId' 7
,7 8
principalTable &
:& '
$str( 4
,4 5
principalColumn '
:' (
$str) -
)- .
;. /
}   
)   
;   
migrationBuilder"" 
."" 
CreateTable"" (
(""( )
name## 
:## 
$str## 
,## 
columns$$ 
:$$ 
table$$ 
=>$$ !
new$$" %
{%% 
Id&& 
=&& 
table&& 
.&& 
Column&& %
<&&% &
int&&& )
>&&) *
(&&* +
type&&+ /
:&&/ 0
$str&&1 6
,&&6 7
nullable&&8 @
:&&@ A
false&&B G
)&&G H
.'' 

Annotation'' #
(''# $
$str''$ 8
,''8 9
$str'': @
)''@ A
,''A B
Discriminator(( !
=((" #
table(($ )
.(() *
Column((* 0
<((0 1
string((1 7
>((7 8
(((8 9
type((9 =
:((= >
$str((? M
,((M N
	maxLength((O X
:((X Y
$num((Z \
,((\ ]
nullable((^ f
:((f g
false((h m
)((m n
,((n o
CreatedDate)) 
=))  !
table))" '
.))' (
Column))( .
<)). /
DateTime))/ 7
>))7 8
())8 9
type))9 =
:))= >
$str))? J
,))J K
nullable))L T
:))T U
false))V [
)))[ \
,))\ ]
	Processed** 
=** 
table**  %
.**% &
Column**& ,
<**, -
bool**- 1
>**1 2
(**2 3
type**3 7
:**7 8
$str**9 >
,**> ?
nullable**@ H
:**H I
false**J O
)**O P
,**P Q
ProcessedDate++ !
=++" #
table++$ )
.++) *
Column++* 0
<++0 1
DateTime++1 9
>++9 :
(++: ;
type++; ?
:++? @
$str++A L
,++L M
nullable++N V
:++V W
true++X \
)++\ ]
,++] ^
	ProductId,, 
=,, 
table,,  %
.,,% &
Column,,& ,
<,,, -
int,,- 0
>,,0 1
(,,1 2
type,,2 6
:,,6 7
$str,,8 =
,,,= >
nullable,,? G
:,,G H
true,,I M
),,M N
,,,N O)
ProductUpdatedEvent_ProductId-- 1
=--2 3
table--4 9
.--9 :
Column--: @
<--@ A
int--A D
>--D E
(--E F
type--F J
:--J K
$str--L Q
,--Q R
nullable--S [
:--[ \
true--] a
)--a b
,--b c
Name.. 
=.. 
table..  
...  !
Column..! '
<..' (
string..( .
>... /
(../ 0
type..0 4
:..4 5
$str..6 E
,..E F
nullable..G O
:..O P
true..Q U
)..U V
,..V W
Price// 
=// 
table// !
.//! "
Column//" (
<//( )
decimal//) 0
>//0 1
(//1 2
type//2 6
://6 7
$str//8 G
,//G H
nullable//I Q
://Q R
true//S W
)//W X
}00 
,00 
constraints11 
:11 
table11 "
=>11# %
{22 
table33 
.33 

PrimaryKey33 $
(33$ %
$str33% 0
,330 1
x332 3
=>334 6
x337 8
.338 9
Id339 ;
)33; <
;33< =
}44 
)44 
;44 
migrationBuilder66 
.66 
CreateTable66 (
(66( )
name77 
:77 
$str77  
,77  !
columns88 
:88 
table88 
=>88 !
new88" %
{99 
Id:: 
=:: 
table:: 
.:: 
Column:: %
<::% &
int::& )
>::) *
(::* +
type::+ /
:::/ 0
$str::1 6
,::6 7
nullable::8 @
:::@ A
false::B G
)::G H
.;; 

Annotation;; #
(;;# $
$str;;$ 8
,;;8 9
$str;;: @
);;@ A
,;;A B
Name<< 
=<< 
table<<  
.<<  !
Column<<! '
<<<' (
string<<( .
><<. /
(<</ 0
type<<0 4
:<<4 5
$str<<6 D
,<<D E
	maxLength<<F O
:<<O P
$num<<Q S
,<<S T
nullable<<U ]
:<<] ^
false<<_ d
)<<d e
,<<e f
Description== 
===  !
table==" '
.==' (
Column==( .
<==. /
string==/ 5
>==5 6
(==6 7
type==7 ;
:==; <
$str=== L
,==L M
nullable==N V
:==V W
false==X ]
)==] ^
,==^ _
Image>> 
=>> 
table>> !
.>>! "
Column>>" (
<>>( )
string>>) /
>>>/ 0
(>>0 1
type>>1 5
:>>5 6
$str>>7 F
,>>F G
nullable>>H P
:>>P Q
true>>R V
)>>V W
,>>W X
Price?? 
=?? 
table?? !
.??! "
Column??" (
<??( )
decimal??) 0
>??0 1
(??1 2
type??2 6
:??6 7
$str??8 ?
,??? @
nullable??A I
:??I J
false??K P
)??P Q
,??Q R
Amount@@ 
=@@ 
table@@ "
.@@" #
Column@@# )
<@@) *
int@@* -
>@@- .
(@@. /
type@@/ 3
:@@3 4
$str@@5 :
,@@: ;
nullable@@< D
:@@D E
false@@F K
)@@K L
,@@L M

CategoryIdAA 
=AA  
tableAA! &
.AA& '
ColumnAA' -
<AA- .
intAA. 1
>AA1 2
(AA2 3
typeAA3 7
:AA7 8
$strAA9 >
,AA> ?
nullableAA@ H
:AAH I
falseAAJ O
)AAO P
}BB 
,BB 
constraintsCC 
:CC 
tableCC "
=>CC# %
{DD 
tableEE 
.EE 

PrimaryKeyEE $
(EE$ %
$strEE% 2
,EE2 3
xEE4 5
=>EE6 8
xEE9 :
.EE: ;
IdEE; =
)EE= >
;EE> ?
tableFF 
.FF 

ForeignKeyFF $
(FF$ %
nameGG 
:GG 
$strGG A
,GGA B
columnHH 
:HH 
xHH  !
=>HH" $
xHH% &
.HH& '

CategoryIdHH' 1
,HH1 2
principalTableII &
:II& '
$strII( 4
,II4 5
principalColumnJJ '
:JJ' (
$strJJ) -
)JJ- .
;JJ. /
}KK 
)KK 
;KK 
migrationBuilderMM 
.MM 
CreateIndexMM (
(MM( )
nameNN 
:NN 
$strNN 6
,NN6 7
tableOO 
:OO 
$strOO #
,OO# $
columnPP 
:PP 
$strPP *
)PP* +
;PP+ ,
migrationBuilderRR 
.RR 
CreateIndexRR (
(RR( )
nameSS 
:SS 
$strSS .
,SS. /
tableTT 
:TT 
$strTT !
,TT! "
columnUU 
:UU 
$strUU $
)UU$ %
;UU% &
}VV 	
	protectedYY 
overrideYY 
voidYY 
DownYY  $
(YY$ %
MigrationBuilderYY% 5
migrationBuilderYY6 F
)YYF G
{ZZ 	
migrationBuilder[[ 
.[[ 
	DropTable[[ &
([[& '
name\\ 
:\\ 
$str\\ 
)\\ 
;\\  
migrationBuilder^^ 
.^^ 
	DropTable^^ &
(^^& '
name__ 
:__ 
$str__  
)__  !
;__! "
migrationBuilderaa 
.aa 
	DropTableaa &
(aa& '
namebb 
:bb 
$strbb "
)bb" #
;bb# $
}cc 	
}dd 
}ee Ú
ô/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Infrastructure.Database/Options/SqlDatabaseOptions.cs
	namespace 	
Infrastructure
 
. 
Database !
.! "
Options" )
;) *
public 
class 
SqlDatabaseOptions 
{ 
public 

string '
SqlDatabaseConnectionString -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
=< =
null> B
!B C
;C D
} 