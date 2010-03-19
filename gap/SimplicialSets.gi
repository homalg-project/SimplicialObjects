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
    
    X := rec(
             BasePoint := basepoint,
	     FunctorOnObjects :=
	       d -> SetOfSimplices( List( s( d ), data -> Simplex( d, [ ], data ) ) ),
	     FaceOfNonDegenerateSimplex := f
	     );
    
    type := TheTypeSimplicialSet;
    
    ## Objectify:
    Objectify( type, X );
    
    return X;
    
end );

##
InstallMethod( EilenbergMacLaneSpace,
        "a finite group and an integer",
	[ IsGroup and IsFinite, IsInt ],

  function( G, i )
    local bb, G_1, addElement, s, f, KG1;
    
    if i <> 1 then
        Error( "This case is not supported yet\n" );
    fi;
    
    bb := Simplex( 0, [ ], [ ] );
    
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
      
      g := data[i - 1] * data[i];
      
      if IsOne( g ) then
          return [ [ i - 1 ], Concatenation( data{[ 1 .. i - 2 ]}, data{[ i + 1 .. d ]} ) ];
      fi;
      
      return [ [ ], Concatenation( data{[ 1 .. i - 2 ]}, [ g ], data{[ i + 1 .. d ]} ) ];
      
    end;
    
    KG1 := SimplicialSet( bb, s, f );
    
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

