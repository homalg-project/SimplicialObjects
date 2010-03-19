#############################################################################
##
##  SimplicialSets.gd        SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Installation stuff for simplicial objects.
##
#############################################################################

##  <#GAPDoc Label="IsSimplicialSetRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="X" Name="IsSimplicialSetRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of simplicial objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSimplicialSet"/>
##       and a subrepresentation of the &GAP; representation <Ref Filt="IsSimplicialObjectRep"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSimplicialSetRep",
        IsSimplicialObjectRep and IsSimplicialSet,
        [ "FunctorOnObjects", "FaceOfNonDegenerateSimplex" ] );
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
BindGlobal( "TheFamilyOfSimplicialSets",
        NewFamily( "TheFamilyOfSimplicialSets" ) );

# a new type:
BindGlobal( "TheTypeSimplicialSet",
        NewType( TheFamilyOfSimplicialSets,
                IsSimplicialSetRep ) );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( FaceMaps,
        "a simplicial set",
        [ IsSimplicialSet ],
        
  function( X )
    local f, facemaps;
    
    if not IsBound( X!.FaceOfNonDegenerateSimplex ) then
        TryNextMethod( );
    fi;
    
    f := X!.FaceOfNonDegenerateSimplex;
    
    facemaps := function( i, sigma )
        local d, dg, data;
        
        d := Dimension( sigma );
        dg := ListOfDegeneracies( sigma );
        data := DataForNonDegenerateSimplex( sigma );
        
        
        
    end;
    
    return facemaps;
    
end );

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
InstallMethod( SimplicialSet,
        "a simplicial set",
        [ IsSimplex and IsNonDegenerate, IsFunction, IsFunction ],
        
  function( basepoint, s, f )
    local X, type;
    
    X := rec( BasePoint := basepoint, FunctorOnObjects := s, FaceOfNonDegenerateSimplex := f );
    
    type := TheTypeSimplicialSet;
    
    ## Objectify:
    Objectify( type, X );
    
    return X;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "a simplicial set",
        [ IsSimplicialSet ],
        
  function( o )
    
    Print( "<A simplicial set>" );
    
end );

##
InstallMethod( Display,
        "a simplicial set",
        [ IsSimplicialSet ],
        
  function( o )
    
    if IsBound( o!.name ) then
        Print( o!.name, "\n" );
    else
        Print( o!.FunctorOnObjects, "\n" );
    fi;
    
end );

