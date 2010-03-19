LoadPackage( "SimplicialObjects" );

bb := Simplex( 0, [ ], [ ] );

s := function( d )
    local L;
    L := [ Simplex( d, [ ], ListWithIdenticalEntries( d, (1,2) ) ) ];
    return SetOfSimplices( L );
end;

f := function( i, d, data );
    
    if i = 0 then
        return [ [ ], data{[ 2 .. d ]} ];
    elif i = d then
        return [ [ ], data{[ 1 .. d - 1 ]} ];
    fi;
    
    return [ [ i - 1 ], data{[ 1 .. d - 2 ]} ];
    
end;

KC2 := SimplicialSet( bb, s, f );

SetName( KC2, "KC2" );
