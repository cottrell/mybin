all:
	cat Makefile
toc:
	python TOC-Generator/tocgen.py README.md --inplace
