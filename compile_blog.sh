#!/usr/bin/env bash

while read -r templateline; do

    if [[ "$templateline" == "!!BlogEntries!!" ]]; then
        for i in `ls -1 blog_entries/*.md | sort -r`; do
            markdown2 "$i"
        done
    else
        echo "$templateline"
    fi

done < blog_entries/blog.html.template
