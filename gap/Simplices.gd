#############################################################################
##
##  Simplices.gd             SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Declaration stuff for simplices.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsSimplex">
##  <ManSection>
##    <Filt Type="Category" Arg="sigma" Name="IsSimplex"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of simplices. <P/>
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsSimplex",
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

##  <#GAPDoc Label="IsDegenerate">
##  <ManSection>
##    <Prop Arg="M" Name="IsDegenerate"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the simplex is degenerate.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDegenerate",
        IsSimplex );

##  <#GAPDoc Label="IsNonDegenerate">
##  <ManSection>
##    <Prop Arg="M" Name="IsNonDegenerate"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the simplex is non-degenerate.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNonDegenerate",
        IsSimplex );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="Dimension:simplices">
##  <ManSection>
##    <Attr Arg="sigma" Name="Dimension" Label="for simplices"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The dimension of the simplex <A>sigma</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsSimplex );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "DataForNonDegenerateSimplex",
    [ IsSimplex ] );

DeclareOperation( "ListOfDegeneracies",
    [ IsSimplex ] );

# constructors:

DeclareOperation( "Simplex",
    [ IsInt, IsList, IsObject ] );

DeclareOperation( "Simplex",
    [ IsInt, IsObject ] );

