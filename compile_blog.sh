#!/usr/bin/env bash


rm blog.html
mkdir tmp || echo ""
rm tmp/*

rm blog.html

BLOG_LINKS=""

for i in `ls -1 blog_entries/*.md | sort -r`; do

	#Get HTML Encoded Title
	BLOG_CONTENT=$(markdown2 "$i")
	ORIG_FILE_NAME=$(basename "$i")
	OUTPUT_FILE_NAME=$(echo "$ORIG_FILE_NAME" | sed 's/\.md/\.html/')
	TITLE=$(echo "$BLOG_CONTENT"  | grep "<h3>" | head -n 1 | sed 's/<h3[^>]*>//g' | sed 's/<h3>//g')

	echo "$BLOG_CONTENT"  > tmp/"$OUTPUT_FILE_NAME"

	BLOG_LINKS=$(printf '%s%s\r\n' "${BLOG_LINKS}" "* [${TITLE}](blog/${OUTPUT_FILE_NAME})")
done
BLOG_LINKS=$(echo "$BLOG_LINKS" | markdown2)


#Place blog links in each blog
for i in `ls -1 tmp/*.html | sort -r`; do

        ORIG_FILE_NAME=$(basename "$i")
	OUT_FILE_NAME="$ORIG_FILE_NAME"

	while read -r templateline; do

	    if [[ "$templateline" == "!!BlogEntries!!" ]]; then
		cat "$i"
	    elif [[ "$templateline" == "!!BlogLinks!!" ]]; then
		echo "$BLOG_LINKS"
	    else
		echo "$templateline"
	    fi

   	done < blog_entries/blog.html.template > blog/"$OUT_FILE_NAME"

done;


while read -r templateline; do

    if [[ "$templateline" == "!!BlogEntries!!" ]]; then
	cat "$i"
    elif [[ "$templateline" == "!!BlogLinks!!" ]]; then
	echo "$BLOG_LINKS"
    else
	echo "$templateline"
    fi

done < index.html.template > index.html
