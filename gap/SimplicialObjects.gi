#############################################################################
##
##  SimplicialObjects.gd     SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Installation stuff for simplicial objects.
##
#############################################################################

##  <#GAPDoc Label="IsSimplicialObjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="S" Name="IsSimplicialObjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of simplicial objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSimplicialObject"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSimplicialObjectRep",
        IsSimplicialObject,
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
BindGlobal( "TheFamilyOfSimplicialObjects",
        NewFamily( "TheFamilyOfSimplicialObjects" ) );

# a new type:
BindGlobal( "TheTypeSimplicialObject",
        NewType( TheFamilyOfSimplicialObjects,
                IsSimplicialObjectRep ) );

####################################
#
# methods for operations:
#
####################################
