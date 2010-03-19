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
##    <Attr Arg="i, etas" Name="FaceDegeneraciesComposition"/>
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

##  <#GAPDoc Label="DegeneracyComposition">
##  <ManSection>
##    <Attr Arg="i, etas" Name="DegeneracyComposition"/>
##    <Returns>a list</Returns>
##    <Description>
##      Compute the composition of the <A>i</A>th degeneracy map with the list
##      of sorted degeneracy degrees <A>etas</A> and return the resulting list of sorted
##      degeneracy degrees.
##      <Example><![CDATA[
##  gap> DegeneracyComposition( 1, [ ] );
##  [ 1 ]
##  gap> DegeneracyComposition( 1, [ 0 ] );
##  [ 1, 0 ]
##  gap> DegeneracyComposition( 1, [ 1 ] );
##  [ 2, 1 ]
##  gap> DegeneracyComposition( 1, [ 2 ] );
##  [ 3, 1 ]
##  gap> DegeneracyComposition( 1, [ 3, 2, 0 ] );
##  [ 4, 3, 1, 0 ]
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( DegeneracyComposition,
  function( i, etas )
    local l, eta1;
    
    l := Length( etas );
    
    if l = 0 then
        return [ i ];
    fi;
    
    eta1 := etas[1];
    
    if i > eta1 then
        return Concatenation( [ i ], etas );
    fi;
    
    return Concatenation( [ eta1 + 1 ], DegeneracyComposition( i, etas{[ 2 .. l ]} ) );
    
end );

##  <#GAPDoc Label="DegeneraciesComposition">
##  <ManSection>
##    <Attr Arg="etas1, etas2" Name="DegeneraciesComposition"/>
##    <Returns>a list</Returns>
##    <Description>
##      Compute the composition of the two lists of sorted degeneracy degrees <A>etas1</A> and <A>etas2</A>.
##      The result is again a list of sorted degeneracy degrees.
##      degeneracy degrees.
##      <Example><![CDATA[
##  gap> DegeneraciesComposition( [ ], [ ] );
##  [  ]
##  gap> DegeneraciesComposition( [ ], [ 1 ] );
##  [ 1 ]
##  gap> DegeneraciesComposition( [ 1 ], [ ] );
##  [ 1 ]
##  gap> DegeneraciesComposition( [ 4, 2 ], [ 5, 3, 1 ] );
##  [ 7, 5, 4, 2, 1 ]
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( DegeneraciesComposition,
  function( etas1, etas2 )
    local l;
    
    l := Length( etas1 );
    
    if l = 0 then
        return etas2;
    elif IsEmpty( etas2 ) then
        return etas1;
    fi;
    
    return DegeneraciesComposition( etas1{[ 1 .. l - 1 ]}, DegeneracyComposition( etas1[l], etas2 ) );
    
end );

