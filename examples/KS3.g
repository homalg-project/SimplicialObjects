##  <#GAPDoc Label="K(S3,1)">
##  Manually build the standard simplicial set of the Eilenberg-MacLane space <M>K(S_3,1)</M>.
##  <Example><![CDATA[
##  gap> S3 := SymmetricGroup( 3 );
##  Sym( [ 1 .. 3 ] )
##  gap> SetName( S3, "S3" );
##  gap> KS3 := EilenbergMacLaneSpace( S3 );
##  K(S3,1)
##  gap> KS3[1];
##  <A set of 1-simplices containing 5 non-degenerate simplices>
##  gap> Display( last );
##  [
##  ([ (2,3) ])
##  ([ (1,2) ])
##  ([ (1,2,3) ])
##  ([ (1,3,2) ])
##  ([ (1,3) ])
##  ]
##  
##  the list of non-degenerate simplices in dimension 1
##  gap> KS3[2];
##  <A set of 2-simplices containing 25 non-degenerate simplices>
##  gap> KS3[3][2];
##  <A non-degenerate 3-simplex>
##  gap> Display( last );
##  ([ (1,2), (2,3), (2,3) ])
##  gap> C := AssociatedChainComplex( KS3 );
##  <A non-zero graded homology object consisting of a single left module at degre\
##  e 0>
##  gap> m1 := CertainMorphism( C, 1 );
##  <A homomorphism of left modules>
##  gap> Display( m1 );
##  [ [  0 ],
##    [  0 ],
##    [  0 ],
##    [  0 ],
##    [  0 ] ]
##  
##  the map is currently represented by the above 5 x 1 matrix
##  gap> m2 := CertainMorphism( C, 2 );
##  <A homomorphism of left modules>
##  gap> Display( m2 );
##  [ [   2,   0,   0,   0,   0 ],
##    [   1,   1,   0,  -1,   0 ],
##    [   1,   0,   1,   0,  -1 ],
##    [   1,  -1,   0,   1,   0 ],
##    [   1,   0,  -1,   0,   1 ],
##    [   1,   1,  -1,   0,   0 ],
##    [   0,   2,   0,   0,   0 ],
##    [  -1,   1,   1,   0,   0 ],
##    [   0,   1,   0,   1,  -1 ],
##    [   0,   1,   0,  -1,   1 ],
##    [   1,  -1,   1,   0,   0 ],
##    [   0,   1,   1,   0,  -1 ],
##    [   0,   0,   2,  -1,   0 ],
##    [   0,   0,   1,   1,   0 ],
##    [  -1,   0,   1,   0,   1 ],
##    [   1,   0,   0,   1,  -1 ],
##    [  -1,   1,   0,   1,   0 ],
##    [   0,   0,   1,   1,   0 ],
##    [   0,   0,  -1,   2,   0 ],
##    [   0,  -1,   0,   1,   1 ],
##    [   1,   0,   0,  -1,   1 ],
##    [   0,   1,  -1,   0,   1 ],
##    [   0,  -1,   1,   0,   1 ],
##    [  -1,   0,   0,   1,   1 ],
##    [   0,   0,   0,   0,   2 ] ]
##  
##  the map is currently represented by the above 25 x 5 matrix
##  gap> H_2 := DefectOfExactness( m2, m1 );
##  <A left module presented by yet unknown relations for 3 generators>
##  gap> ByASmallerPresentation( H_2 );
##  <A cyclic torsion left module presented by 1 relation for a cyclic generator>
##  gap> Display( H_2 );
##  Z/< 2 > 
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "SimplicialObjects" );

S3 := SymmetricGroup( 3 );

SetName( S3, "S3" );

KS3 := EilenbergMacLaneSpace( S3 );

C := AssociatedChainComplex( KS3 );

m1 := CertainMorphism( C, 1 );

m2 := CertainMorphism( C, 2 );

H_2 := DefectOfExactness( m2, m1 );

ByASmallerPresentation( H_2 );
