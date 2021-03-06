#!/bin/sh
# link or include this in .git/hooks/pre-commit to prevent accidental inclusion of a or an prior to
# cloze deletions that give away what has been deleted

ARTICLE_REJECTION="commit rejected: replace 'a' with 'a/an' for indefinite articles introducing cloze deletions.";
A_CLOZE_PATTERN='^+.*[aA] {{';
AN_CLOZE_PATTERN='^+.*[^/a-zA-Z][aA][nN] {{';
for cloze_pattern in "$A_CLOZE_PATTERN" "$AN_CLOZE_PATTERN"; do
    git diff --cached | grep "$cloze_pattern" && echo $ARTICLE_REJECTION && exit 1;
done

HTML_REJECTION="commit rejected: angle brackets or ampersands found. See README.md and re-commit with --no-verify if these brackets or ampersands are intended."
HTML_PATTERN='^+.*[<>&]'
git diff --cached | grep "$HTML_PATTERN" && echo $HTML_REJECTION && exit 1;

echo "Pre-commit succeeded."

exit 0
