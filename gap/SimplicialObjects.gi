#############################################################################
##
##  SimplicialObjects.gd     SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Installation stuff for simplicial objects.
##
#############################################################################

##  <#GAPDoc Label="IsSimplicialObjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="S" Name="IsSimplicialObjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of simplicial objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSimplicialObject"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSimplicialObjectRep",
        IsSimplicialObject,
        [ "FunctorOnObjects", "FaceMorphisms", "DegeneracyMorphisms" ] );
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
BindGlobal( "TheFamilyOfSimplicialObjects",
        NewFamily( "TheFamilyOfSimplicialObjects" ) );

# a new type:
BindGlobal( "TheTypeSimplicialObject",
        NewType( TheFamilyOfSimplicialObjects,
                IsSimplicialObjectRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( \[\],
        "a simplicial object and a nonnegative integer",
        [ IsSimplicialObjectRep, IsInt ],
        
  function( S, d )
    
    return S!.FunctorOnObjects( d );
    
end );

##
InstallGlobalFunction( FaceDegeneraciesComposition,
  function( i, etas )
    local l, eta1, fdc;
    
    l := Length( etas );
    
    if l = 0 then
        return [ etas, i ];
    fi;
    
    eta1 := etas[1];
    
    if i = fail then
        return [ etas, fail ];
    elif i < eta1 then
        fdc := FaceDegeneraciesComposition( i, etas{[ 2 .. l ]} );
        return [ Concatenation( [ eta1 - 1 ], fdc[1] ), fdc[2] ];
    elif i > eta1 + 1 then
        fdc := FaceDegeneraciesComposition( i - 1, etas{[ 2 .. l ]} );
        return [ Concatenation( [ eta1 ], fdc[1] ), fdc[2] ];
    else    # i = eta1 or i = eta1 + 1
        return [ etas{[ 2 .. l ]}, fail ];
    fi;
    
end );

