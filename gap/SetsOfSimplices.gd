#############################################################################
##
##  SetsOfSimplices.gd       SimplicialObjects package       Mohamed Barakat
##                                                                Ana Romero
##
##  Copyright 2010 Mohamed Barakat and Ana Romero
##
##  Declaration stuff for sets of simplices.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsSetOfSimplices">
##  <ManSection>
##    <Filt Type="Category" Arg="sigma" Name="IsSetOfSimplices"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of simplices. <P/>
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsSetOfSimplices",
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
# attributes:
#
####################################

##  <#GAPDoc Label="Dimension:setsofsimplices">
##  <ManSection>
##    <Attr Arg="Xn" Name="Dimension" Label="for sets of simplices"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      A set of <A>n</A>-simplices <A>Xn</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsSetOfSimplices );

##  <#GAPDoc Label="NrNonDegenerateSimplices">
##  <ManSection>
##    <Attr Arg="Xn" Name="NrNonDegenerateSimplices"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The number of non-degenerate simplices in the set of <A>n</A>-simplices <A>Xn</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NrNonDegenerateSimplices",
        IsSetOfSimplices );

##  <#GAPDoc Label="NrDegenerateSimplices">
##  <ManSection>
##    <Attr Arg="Xn" Name="NrDegenerateSimplices"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The number of degenerate simplices in the set of <A>n</A>-simplices <A>Xn</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NrDegenerateSimplices",
        IsSetOfSimplices );

##  <#GAPDoc Label="AssociatedSimplicialSet">
##  <ManSection>
##    <Attr Arg="Xn" Name="AssociatedSimplicialSet"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The simplicial set <M>X</M> of which <A>Xn</A> is the set of <A>n</A>-simplices.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AssociatedSimplicialSet",
        IsSetOfSimplices );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "SetOfSimplices",
    [ IsInt, IsList ] );

DeclareOperation( "SetOfSimplices",
    [ IsList ] );

# basic operations:

DeclareOperation( "ListOfNonDegenerateSimplices",
    [ IsSetOfSimplices ] );

DeclareOperation( "[]",
    [ IsSetOfSimplices, IsInt ] );

