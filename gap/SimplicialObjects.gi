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

##  <#GAPDoc Label="FaceDegeneraciesComposition">
##  <ManSection>
##    <Attr Arg="i, etas " Name="FaceDegeneraciesComposition"/>
##    <Returns>a list</Returns>
##    <Description>
##      This function returns a 2-element list. The first entry is a possibly
##      empty list of nonnegative integers. The second entry is a nonnegative
##      integer or <C>fail</C>. The output describes the result of the composition
##      of the <A>i</A>th face map with the degeneracies given by the list <A>etas</A>.
##      The first entry of the output is the list of resulting degeneracies. The
##      second entry stands for a face map (integer) or the identity operator (fail).
##      <Example><![CDATA[
##  gap> FaceDegeneraciesComposition( 1, [ ] );
##  [ [  ], 1 ]
##  gap> FaceDegeneraciesComposition( 1, [ 2 ] );
##  [ [ 1 ], 1 ]
##  gap> FaceDegeneraciesComposition( 4, [ 2 ] );
##  [ [ 2 ], 3 ]
##  gap> FaceDegeneraciesComposition( 2, [ 2 ] );
##  [ [  ], fail ]
##  gap> FaceDegeneraciesComposition( 3, [ 2 ] );
##  [ [  ], fail ]
##  gap> FaceDegeneraciesComposition( 1, [ 4, 1, 0 ] );
##  [ [ 3, 0 ], fail ]
##  gap> FaceDegeneraciesComposition( 1, [ 4, 3, 2 ] );
##  [ [ 3, 2, 1 ], 1 ]
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
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

