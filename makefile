all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g \
		PackageInfo.g \
		doc/SimplicialObjects.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/SimplicialObjects.tar.gz --exclude ".DS_Store" --exclude "*~" SimplicialObjects/doc/*.* SimplicialObjects/doc/clean SimplicialObjects/gap/*.{gi,gd} SimplicialObjects/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g} SimplicialObjects/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/SimplicialObjects

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.SimplicialObjects
	cp doc/manual.pdf ${WEBPOS}/SimplicialObjects.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/SimplicialObjects.tar.gz ${WEBPOS}/SimplicialObjects-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s SimplicialObjects-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/SimplicialObjects.tar.gz
