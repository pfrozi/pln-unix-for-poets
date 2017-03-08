tr -sc "[A-Z][a-z]" "[\012*]" > $$words 
tail -n+2 $$words > $$nextwords 
tail -n+3 $$words > $$nextwords2
paste $$words $$nextwords $$nextwords2 | sort | uniq -c
# remove  
rm $$words $$nextwords $$nextwords2
