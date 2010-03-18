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

# constructors:

DeclareConstructor( "SimplicialSet",
    [ IsSimplex, IsFunction, IsFunction ] );

DeclareConstructor( "SimplicialSet",
    [ IsFunction, IsFunction ] );

