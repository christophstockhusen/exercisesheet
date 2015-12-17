CC = lualatex

all: manual.pdf

manual.pdf: manual.tex template_student.pdf template_teacher.pdf
	$(CC) manual.tex
	$(CC) manual.tex

template_student.pdf: template_student.tex
	$(CC) template_student.tex
	$(CC) template_student.tex

template_teacher.pdf: template_teacher.tex
	$(CC) template_teacher.tex
	$(CC) template_teacher.tex
