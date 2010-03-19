#############################################################################
##
##  SimplicialSets.gd        SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Declaration stuff for simplicial sets.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsSimplicialSet">
##  <ManSection>
##    <Filt Type="Category" Arg="X" Name="IsSimplicialSet"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of simplicial sets. <P/>
##      (It is a subcategory of the &GAP; representation <Ref Filt="IsSimplicialObject"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsSimplicialSet",
        IsSimplicialObject );
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
# attributes:
#
####################################

##  <#GAPDoc Label="FaceMaps">
##  <ManSection>
##    <Attr Arg="X" Name="FaceMaps"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      A function which encodes all face maps of the simplicial set <A>X</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FaceMaps",
        IsSimplicialSet );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

# constructors:

DeclareOperation( "SimplicialSet",
    [ IsSimplex, IsFunction, IsFunction ] );

DeclareOperation( "SimplicialSet",
    [ IsFunction, IsFunction ] );

DeclareOperation( "EilenbergMacLaneSpace",
    [ IsGroup, IsInt ] );
