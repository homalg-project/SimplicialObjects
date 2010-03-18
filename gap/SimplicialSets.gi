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
##      (It is a subrepresentation of the &GAP; representation <Ref Filt="IsSimplicialObjectRep"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSimplicialSetRep",
        IsSimplicialObjectRep,
        [ "FunctorOnObjects", "Faces", "Degeneracies" ] );
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
# methods for operations:
#
####################################

