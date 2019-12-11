all:
	touch blog.html && rm blog.html
	./compile_blog.sh > blog.html
