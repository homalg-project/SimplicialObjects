LoadPackage( "SimplicialObjects" );

bb := Simplex( 0, [ ], [ ] );

s := function( d )
    local L;
    L := [ Simplex( d, [ ], ListWithIdenticalEntries( d, (1,2) ) ) ];
    return SetOfSimplices( L );
end;

f := function( i, d, s, l );
    
    if i = 0 then
        return Simplex( d - 1, [ ], s{[ 2 .. l ]} );
    elif i = d then
        return Simplex( d - 1, [ ], s{[ 1 .. l - 1 ]} );
    fi;
    
    return Simplex( d - 1, [ i - 1 ], s{[ 1 .. l - 2 ]} );
    
end;

KC2 := SimplicialSet( bb, s, f );

SetName( KC2, "KC2" );
