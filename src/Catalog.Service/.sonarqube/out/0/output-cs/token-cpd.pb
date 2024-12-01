Â
š/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Lunis.SharedLibs.Catalog.OutboxMessages/BaseMessage.cs
	namespace 	
Lunis
 
. 

SharedLibs 
. 
Catalog "
." #
OutboxMessages# 1
;1 2
[ 
JsonPolymorphic 
( &
UnknownDerivedTypeHandling +
=, -*
JsonUnknownDerivedTypeHandling. L
.L M%
FallBackToNearestAncestorM f
)f g
]g h
[ 
JsonDerivedType 
( 
typeof 
( !
ProductDeletedMessage -
)- .
,. /
$num0 1
)1 2
]2 3
[ 
JsonDerivedType 
( 
typeof 
( !
ProductUpdatedMessage -
)- .
,. /
$num0 1
)1 2
]2 3
public 
abstract 
class 
BaseMessage !
{		 
}

 ¼
˜/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Lunis.SharedLibs.Catalog.OutboxMessages/Constants.cs
	namespace 	
Lunis
 
. 

SharedLibs 
. 
Catalog "
." #
OutboxMessages# 1
;1 2
public 
static 
class 
	Constants 
{ 
public 

const 
string 
ProductsQueueName )
=* +
$str, E
;E F
} ’
¤/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Lunis.SharedLibs.Catalog.OutboxMessages/ProductDeletedMessage.cs
	namespace 	
Lunis
 
. 

SharedLibs 
. 
Catalog "
." #
OutboxMessages# 1
;1 2
public 
class !
ProductDeletedMessage "
:# $
BaseMessage% 0
{ 
public 

DateTime 
Date 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
	ProductId 
{ 
get 
; 
set  #
;# $
}% &
} ƒ	
¤/mnt/c/Users/Dzianis_Lukayenka/Documents/Learn_Test/NETMentoringProgramAdvanced/src/Catalog.Service/Lunis.SharedLibs.Catalog.OutboxMessages/ProductUpdatedMessage.cs
	namespace 	
Lunis
 
. 

SharedLibs 
. 
Catalog "
." #
OutboxMessages# 1
;1 2
public 
class !
ProductUpdatedMessage "
:# $
BaseMessage% 0
{ 
public 

DateTime 
Date 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
	ProductId 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
null' +
!+ ,
;, -
public		 

decimal		 
Price		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
}

 