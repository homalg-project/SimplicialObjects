##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "SimplicialObjects" );

LoadPackage( "GAPDoc" );

list := [
         "../gap/SimplicialObjectsForHomalg.gd",
         "../gap/SimplicialObjectsForHomalg.gi",
         "../gap/SimplicialObjects.gd",
         "../gap/SimplicialObjects.gi",
         "../gap/Simplices.gd",
         "../gap/Simplices.gi",
         "../gap/SetsOfSimplices.gd",
         "../gap/SetsOfSimplices.gi",
         "../gap/SimplicialSets.gd",
         "../gap/SimplicialSets.gi",
         ];

MyTestManualExamples :=
function ( arg )
    local  ex, bad, res, a;
    if IsRecord( arg[1] )  then
        ex := ManualExamplesXMLTree( arg[1], "Single" );
    else
        ex := ManualExamples( arg[1], arg[2], arg[3], "Single" );
    fi;
    bad := Filtered( ex, function ( a )
            return TestExamplesString( a ) <> true;
        end );
    res := [  ];
    for a  in bad  do
        Print( "===========================\n" );
        PrintFormattedString( a );
        Add( res, TestExamplesString( a, true ) );
    od;
    return res;
end;

size := SizeScreen( );
SizeScreen([80]);

MyTestManualExamples( DirectoriesPackageLibrary( "SimplicialObjects", "doc" )[1]![1], "SimplicialObjectsForHomalg.xml", list );

GAPDocManualLab("SimplicialObjects");

SizeScreen( size );

quit;

