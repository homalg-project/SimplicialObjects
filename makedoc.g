##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/SimplicialObjects.bib" );
WriteBibXMLextFile( "doc/SimplicialObjectsBib.xml", bib );

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
         "../examples/Simplex.g",
         "../examples/KC2.g",
         "../examples/KS3.g",
         ];

MakeGAPDocDoc( "doc", "SimplicialObjectsForHomalg", list, "SimplicialObjectsForHomalg" );

GAPDocManualLab("SimplicialObjects");

quit;

