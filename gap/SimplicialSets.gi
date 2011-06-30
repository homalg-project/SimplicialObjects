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
        local d, dg, data, commutation, face;
        
        d := Dimension( sigma );
        
        if d = 0 then
            Error( "there are no face maps for dimension 0\n" );
        elif i < 0 or i > d then
            Error( "The first argument must be a nonnegative integer less or equal to ", d, " but received ", i, "\n" );
        fi;
        
        dg := ListOfDegeneracies( sigma );
        data := DataForNonDegenerateSimplex( sigma );
        
        commutation := FaceDegeneraciesComposition( i, dg );
        
        face := commutation[2];
        
        if face = fail then
            return Simplex( d - 1, commutation[1], data );
        fi;
        
        data := f( face, d - Length( dg ), data );
        
        dg := DegeneraciesComposition( commutation[1], data[1] );
        
        return Simplex( d - 1, dg, data[2] );
        
    end;
    
    return facemaps;
    
end );

##
InstallMethod( RingOfAssociatedChainComplex,
        "a simplicial set",
        [ IsSimplicialSet ],
        
  X -> HOMALG_MATRICES.ZZ );

##
InstallMethod( AssociatedChainComplex,
        "a simplicial set",
        [ IsSimplicialSet ],
        
  function( X )
    local R, X0, l0, C;
    
    R := RingOfAssociatedChainComplex( X );
    
    X0 := X!.FunctorOnObjects( 0 );
    
    l0 := NrNonDegenerateSimplices( X0 );
    
    C := HomalgComplex( l0 * R );
    
    C!.SimplicialSet := X;
    
    ## d > 0
    C!.ObjectConstructor := d -> NrNonDegenerateSimplices( X[d] ) * R;
    
    ## i > 0
    C!.MorphismConstructor :=
      function( d )
        local Cd, Cd_1, boundary, one, Xd, Xd_1, l, n, i, fs, j;
        
        Cd := CertainObject( C, d );
        Cd_1 := CertainObject( C, d - 1 );
        
        boundary := HomalgInitialMatrix( Rank( Cd ), Rank( Cd_1 ), R );
        
        one := One( R );
        
        Xd := ListOfNonDegenerateSimplices( X[d] );
        
        if d = 1 then
            Xd_1 := ListOfNonDegenerateSimplices( X!.FunctorOnObjects( 0 ) );
        else
            Xd_1 := ListOfNonDegenerateSimplices( X[d - 1] );
        fi;
        
        l := Length( Xd );
        
        for n in [ 0 .. d ] do
            for i in [ 1 .. l ] do
                fs := FaceMaps( X )( n, Xd[i] );
                if IsNonDegenerate( fs ) then
                    j := Position( Xd_1, fs );
                    AddToMatElm( boundary, i, j, (-1)^n * one );
                fi;
            od;
        od;
        
        return HomalgMap( boundary, Cd, Cd_1 );
        
      end;
    
    return C;
    
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

##  <#GAPDoc Label="SimplicialSet">
##  <ManSection>
##    <Oper Arg="s, f" Name="SimplicialSet" Label="constructor for simplicial sets"/>
##    <Returns>a simplicial set</Returns>
##    <Description>
##      This constructor returns the simplicial set which is a functor with
##      functor on objects given by the function <A>s</A> depending on a dimension
##      (returning a list of data of non-degenerate simplices)
##      and face maps on non-degenerate simplices given by their internal data for
##      each dimension.
##      <#Include Label="K(C2,1)">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SimplicialSet,
        "a simplicial set",
        [ IsFunction, IsFunction ],
        
  function( s, f )
    local X, type;
    
    X := rec(
             FunctorOnObjects :=
               d -> SetOfSimplices( List( s( d ), data -> Simplex( d, [ ], data ) ) ),
             FaceOfNonDegenerateSimplex := f
             );
    
    type := TheTypeSimplicialSet;
    
    ## Objectify:
    Objectify( type, X );
    
    return X;
    
end );

##  <#GAPDoc Label="EilenbergMacLaneSpace">
##  <ManSection>
##    <Oper Arg="G[, i]" Name="EilenbergMacLaneSpace" Label="constructor for Eilenberg-MacLane space"/>
##    <Returns>a simplicial set</Returns>
##    <Description>
##      This constructor returns the standard simplicial set for the
##      Eilenberg-MacLane space <M>K(</M><A>G,i</A><M>)</M>. If the nonnegative
##      integer <A>i</A> is not specified it is set to <M>1</M>.
##      <#Include Label="K(S3,1)">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( EilenbergMacLaneSpace,
        "a finite group and an integer",
        [ IsGroup and IsFinite, IsInt ],

  function( G, i )
    local G_1, addElement, s, f, KG1;
    
    if i <> 1 then
        Error( "This case is not supported yet\n" );
    fi;
    
    G_1 := Filtered( AsList( G ), function( g ) return not IsOne( g ); end );
     
    addElement := function( l, element )
      return List( l, e -> Concatenation( e, [ element ] ) );
    end;
    
    s := function( d )
      local s_1;
      
      if d = 0 then
          return [ [ ] ];
      fi;
      
      s_1 := s( d - 1 );
      
      return Concatenation( List( G_1, g -> addElement( s_1, g ) ) );
      
    end;
    
    f := function( i, d, data )
      local g;
      
      if i = 0 then
          return [ [ ], data{[ 2 .. d ]} ];
      elif i = d then
          return [ [ ], data{[ 1 .. d - 1 ]} ];
      fi;
      
      g := data[i] * data[i + 1];
      
      if IsOne( g ) then
          return [ [ i - 1 ], Concatenation( data{[ 1 .. i - 1 ]}, data{[ i + 2 .. d ]} ) ];
      fi;
      
      return [ [ ], Concatenation( data{[ 1 .. i - 1 ]}, [ g ], data{[ i + 2 .. d ]} ) ];
      
    end;
    
    KG1 := SimplicialSet( s, f );
    
    if HasName( G ) then
        SetName( KG1, Concatenation( "K(", Name( G ), ",1)" ) );
    fi;
    
    return KG1;
    
end );

##
InstallMethod( EilenbergMacLaneSpace,
        "a finite group",
        [ IsGroup ],

  function( G )
    
    return EilenbergMacLaneSpace( G, 1 );
    
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

