Ü
/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/Common/BaseEntity.cs
	namespace 	
Domain
 
. 
Common 
; 
public 
abstract 
class 

BaseEntity  
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
} í
/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/Entities/Category.cs
	namespace 	
Domain
 
. 
Entities 
; 
public 
class 
Category 
: 

BaseEntity "
{ 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
? 
Image 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
? 
ParentCategoryId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public		 

Category		 
?		 
ParentCategory		 #
{		$ %
get		& )
;		) *
set		+ .
;		. /
}		0 1
public

 

IList

 
<

 
Category

 
>

 
ChildCategories

 *
{

+ ,
get

- 0
;

0 1
set

2 5
;

5 6
}

7 8
=

9 :
[

; <
]

< =
;

= >
public 

IList 
< 
Product 
> 
Products "
{# $
get% (
;( )
private* 1
set2 5
;5 6
}7 8
=9 :
[; <
]< =
;= >
} Þ
~/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/Entities/Product.cs
	namespace 	
Domain
 
. 
Entities 
; 
public 
class 
Product 
: 

BaseEntity !
{ 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

string 
Description 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
null. 2
!2 3
;3 4
public 

string 
? 
Image 
{ 
get 
; 
set  #
;# $
}% &
public 

decimal 
Price 
{ 
get 
; 
set  #
;# $
}% &
public		 

int		 
Amount		 
{		 
get		 
;		 
set		  
;		  !
}		" #
public 

int 

CategoryId 
{ 
get 
;  
set! $
;$ %
}& '
public 

Category 
Category 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
null- 1
!1 2
;2 3
} Ä	
~/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/Events/BaseEvent.cs
	namespace 	
Domain
 
. 
Events 
; 
public 
abstract 
class 
	BaseEvent 
:  !

BaseEntity" ,
{ 
public 

string 
Discriminator 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
null0 4
!4 5
;5 6
public 

DateTime 
CreatedDate 
{  !
get" %
;% &
set' *
;* +
}, -
=. /
DateTime0 8
.8 9
UtcNow9 ?
;? @
public 

bool 
	Processed 
{ 
get 
;  
set! $
;$ %
}& '
=( )
false* /
;/ 0
public		 

DateTime		 
?		 
ProcessedDate		 "
{		# $
get		% (
;		( )
set		* -
;		- .
}		/ 0
}

 Î
ˆ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/Events/ProductDeletedEvent.cs
	namespace 	
Domain
 
. 
Events 
; 
public 
class 
ProductDeletedEvent  
:! "
	BaseEvent# ,
{ 
public 

ProductDeletedEvent 
( 
)  
{ 
} 
public		 

ProductDeletedEvent		 
(		 
int		 "
id		# %
)		% &
{

 
	ProductId 
= 
id 
; 
} 
public 

int 
	ProductId 
{ 
get 
; 
set  #
;# $
}% &
} ¿
ˆ/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/Events/ProductUpdatedEvent.cs
	namespace 	
Domain
 
. 
Events 
; 
public 
class 
ProductUpdatedEvent  
:! "
	BaseEvent# ,
{ 
public 

ProductUpdatedEvent 
( 
)  
{! "
}# $
public 

ProductUpdatedEvent 
( 
int "
	productId# ,
,, -
string. 4
name5 9
,9 :
decimal; B
priceC H
)H I
{ 
	ProductId		 
=		 
	productId		 
;		 
Name

 
=

 
name

 
;

 
Price 
= 
price 
; 
} 
public 

int 
	ProductId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public 

decimal 
Price 
{ 
get 
; 
set  #
;# $
}% &
} |
z/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Domain/GlobalUsings.cs