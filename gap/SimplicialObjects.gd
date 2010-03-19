#############################################################################
##
##  SimplicialObjects.gd     SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Declaration stuff for simplicial objects.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsSimplicialObject">
##  <ManSection>
##    <Filt Type="Category" Arg="S" Name="IsSimplicialObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of simplicial objects. <P/>
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsSimplicialObject",
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "[]",
    [ IsSimplicialObject, IsInt ] );

DeclareGlobalFunction( "FaceDegeneraciesComposition" );

