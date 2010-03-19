#############################################################################
##
##  SetsOfSimplices.gd       SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Installation stuff for sets of simplices.
##
#############################################################################

##  <#GAPDoc Label="IsSetOfSimplicesRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsSetOfSimplicesRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of simplicial objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSetOfSimplices"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSetOfSimplicesRep",
        IsSetOfSimplices,
        [ ListOfNonDegenerateSimplices ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfSetsOfSimplices",
        NewFamily( "TheFamilyOfSetsOfSimplices" ) );

# a new type:
BindGlobal( "TheTypeSetOfSimplices",
        NewType( TheFamilyOfSetsOfSimplices,
                IsSetOfSimplicesRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( ListOfNonDegenerateSimplices,
        "a set of simplices",
        [ IsSetOfSimplices ],
        
  function( Xn )
    
    return Xn!.ListOfNonDegenerateSimplices;
    
end );

##
InstallMethod( \[\],
        "a set of simplices and a positive integer",
        [ IsSetOfSimplices, IsPosInt ],
        
  function( Xn, p )
    
    return ListOfNonDegenerateSimplices( Xn )[p];
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( SetOfSimplices,
        "a nonnegative integer and a list of non-degenerate simplices",
        [ IsInt, IsList ],
        
  function( d, L )
    local Xn, type;
    
    if not ForAll( L, IsSimplex and IsNonDegenerate ) then
        Error( "the third argument is not a list of non-degenerate simplices\n" );
    fi;
    
    Xn := rec( ListOfNonDegenerateSimplices := L );
    
    type := TheTypeSetOfSimplices;
    
    ## Objectify:
    ObjectifyWithAttributes(
            Xn, type,
            Dimension, d,
            NrNonDegenerateSimplices, Length( L ) );
    
    return Xn;
    
end );

##
InstallMethod( SetOfSimplices,
        "a nonempty list of non-degenerate simplices",
        [ IsList ],
        
  function( L )
    
    if IsEmpty( L ) then
        Error( "the list of simplices is empty\n" );
    fi;
    
    return SetOfSimplices( Dimension( L[1] ), L );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "a set of simplices",
        [ IsSetOfSimplices ],
        
  function( o )
    local n;
    
    n := NrNonDegenerateSimplices( o );
    
    Print( "<A set of ", Dimension( o ), "-simplices containing " );
    
    if n = 0 then
        Print( "no" );
    elif n = 1 then
        Print( "a single" );
    else
        Print( n );
    fi;
    
    Print( " non-degenerate " );
    
    if n = 1 then
        Print( "simplex>" );
    else
        Print( "simplices>" );
    fi;
    
end );

##
InstallMethod( ViewObj,
        "a set of simplices",
        [ IsSetOfSimplices and IsEmpty ],
        
  function( o )
    local n;
    
    Print( "<An empty set of ", Dimension( o ), "-simplices>" );
    
end );

##
InstallMethod( Display,
        "a set of simplices",
        [ IsSetOfSimplices ],
        
  function( Xn )
    local o, s;
    
    o := ListOfNonDegenerateSimplices( Xn );
    
    Print( "[\n" );
    for s in o do
        Display( s );
    od;
    Print( "]\n\n" );
    
    Print( "the list of non-degenerate simplices in dimension ", Dimension( Xn ), "\n" );
    
end );

