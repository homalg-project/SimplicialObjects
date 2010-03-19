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
##  [ (2,3) ]
##  [ (1,2) ]
##  [ (1,2,3) ]
##  [ (1,3,2) ]
##  [ (1,3) ]
##  ]
##  
##  the list of non-degenerate simplices in dimension 1
##  gap> KS3[2];
##  <A set of 2-simplices containing 25 non-degenerate simplices>
##  gap> KS3[3][2];
##  <A non-degenerate 3-simplex>
##  gap> Display( last );
##  [ (1,2), (2,3), (2,3) ]
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "SimplicialObjects" );

S3 := SymmetricGroup( 3 );

SetName( S3, "S3" );

KS3 := EilenbergMacLaneSpace( S3 );

