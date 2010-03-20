##  <#GAPDoc Label="K(C2,1)">
##  Manually build the standard simplicial set of the Eilenberg-MacLane space <M>K(C_2,1)</M>.
##  <Example><![CDATA[
##  gap> s := d -> [ ListWithIdenticalEntries( d, (1,2) ) ];
##  function( d ) ... end
##  gap> f :=
##  >      function( i, d, data );
##  >        
##  >        if i = 0 then
##  >            return [ [ ], data{[ 2 .. d ]} ];
##  >        elif i = d then
##  >            return [ [ ], data{[ 1 .. d - 1 ]} ];
##  >        fi;
##  >        
##  >        return [ [ i - 1 ], data{[ 1 .. d - 2 ]} ];
##  >        
##  >      end;
##  function( i, d, data ) ... end
##  gap> KC2 := SimplicialSet( s, f );
##  <A simplicial set>
##  gap> SetName( KC2, "K(C2,1)" );
##  gap> KC2;
##  K(C2,1)
##  gap> KC2[1];
##  <A set of 1-simplices containing a single non-degenerate simplex>
##  gap> Display( last );
##  [
##  ([ (1,2) ])
##  ]
##  
##  the list of non-degenerate simplices in dimension 1
##  gap> KC2[3];
##  <A set of 3-simplices containing a single non-degenerate simplex>
##  gap> Display( last );
##  [
##  ([ (1,2), (1,2), (1,2) ])
##  ]
##  
##  the list of non-degenerate simplices in dimension 3
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "SimplicialObjects" );

s := d -> [ ListWithIdenticalEntries( d, (1,2) ) ];

f := function( i, d, data );
    
    if i = 0 then
        return [ [ ], data{[ 2 .. d ]} ];
    elif i = d then
        return [ [ ], data{[ 1 .. d - 1 ]} ];
    fi;
    
    return [ [ i - 1 ], data{[ 1 .. d - 2 ]} ];
    
end;

KC2 := SimplicialSet( s, f );

SetName( KC2, "KC2" );
