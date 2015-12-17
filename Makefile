CC = lualatex

all: package tdspackage

package: manual/manual.pdf manual/template_teacher.pdf manual/template_student.pdf exercisesheet.cls
	zip -9 exercisesheet.zip \
		manual/manual.tex \
		manual/manual.pdf \
		manual/template_teacher.tex \
		manual/template_teacher.pdf \
		manual/template_student.tex \
		manual/template_student.pdf \
		exercisesheet.cls

tdspackage: manual/manual.pdf manual/template_teacher.pdf manual/template_student.pdf exercisesheet.cls
	mkdir -p .tmpzip/doc/latex/exercisesheet/
	mkdir -p .tmpzip/tex/latex/exercisesheet/
	cp manual/manual.pdf .tmpzip/doc/latex/exercisesheet/
	cp exercisesheet.cls .tmpzip/tex/latex/exercisesheet/
	cd .tmpzip; zip -9 -r exercisesheet-tds.zip *
	cp .tmpzip/exercisesheet-tds.zip .
	rm -r .tmpzip

manual/manual.pdf: manual/manual.tex
	cd manual; make

manual/template_teacher.pdf: manual/template_teacher.tex
	cd manual; make

manual/template_student.pdf: manual/template_student.tex
	cd manual; make

samples/sample.pdf: samples/sample.tex
	cd samples; make

