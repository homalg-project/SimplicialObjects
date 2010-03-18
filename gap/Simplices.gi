#############################################################################
##
##  SimplicialSets.gd        SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Installation stuff for simplices.
##
#############################################################################

##  <#GAPDoc Label="IsSimplexRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsSimplexRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of simplicial objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSimplex"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSimplexRep",
        IsSimplex,
        [  ] );
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
BindGlobal( "TheFamilyOfSimplices",
        NewFamily( "TheFamilyOfSimplices" ) );

# a new type:
BindGlobal( "TheTypeSimplex",
        NewType( TheFamilyOfSimplices,
                IsSimplexRep ) );

####################################
#
# methods for operations:
#
####################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Simplex,
        "a list and object",
        [ IsInt, IsList, IsObject ],
        
  function( d, L, o )
    local sigma, type;
    
    sigma := rec( Degeneracies := L, NonDegenerateSimplex := o );
    
    type := TheTypeSimplex;
    
    if L = [ ] then
        
        ## Objectify:
        ObjectifyWithAttributes(
                sigma, type,
                IsDegenerate, false,
                IsNonDegenerate, true,
                Dimension, d );
        
    else
        
        ## Objectify:
        ObjectifyWithAttributes(
                sigma, type,
                IsDegenerate, true,
                IsNonDegenerate, false,
                Dimension, d );
        
    fi;
    
    return sigma;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsSimplex ],
        
  function( o )
    
    Print( "<A " );
    
    if HasIsDegenerate( o ) then
        if IsDegenerate( o ) then
            Print( "degenerate" );
        else
            Print( "non-degenerate" );
        fi;
    fi;
    
    Print( " simplex>" );
    
end );

##
InstallMethod( Display,
        "for homalg matrices",
        [ IsSimplex ],
        
  function( o )
    
    Print( o!.NonDegenerateSimplex, "\n" );
    
end );

