#!/bin/bash

# Arquivo extraido de http://www.gutenberg.org/ebooks/1998
FILEIN=also-sprach-zarathustra.txt
read -n1 -r -p "Press any key to continue..." key

#
#   Atividades 1 - (I) Contagem de palavras em um determinado texto
#
echo ---------------------
echo Activity 1.1
echo ---------------------
#
#   Conta todas as palavras em um determinado texto. Passos:
#   1- Tokenizacao
#   2- Ordenamento das palavras
#   3- Conta os duplicados
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sort | uniq -c > ex1.out
cat ex1.out

echo ---------------------
echo Activity 1.2
echo ---------------------
#
#   Quebrar para trazer as N primeiras linhas. 
#   1- sed Nq < arquivo
#   
sed 15q < $FILEIN

echo ---------------------
echo Activity 1.3
echo ---------------------
#
#   Usando o sed para testar o comando tr.
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sed 12q 

echo ---------------------
echo Activity 1.4
echo ---------------------
#
#   Usando o sed para testar o comando tr, utilizando ordenacao lexicografica
#   sem considerar tokens repetidos.
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sort | sed 12q 

echo ---------------------
echo Activity 1.5
echo ---------------------
#
#   Usando o sed para testar o comando tr, utilizando ordenacao lexicografica
#   sem considerar tokens repetidos, realizando a contagem de cada uma das palavras.
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sort | uniq -c | sed 12q 


#
#   Atividades 2 - (II) Contagem de palavras em um determinado texto 
#

echo ---------------------
echo Activity 2.1
echo ---------------------
#
#   1- Converte todas as palavras do texto em caixa Alta
#   2- Conta todas as palavras em um determinado texto
#   
#   Isto eliminarah as diferencas entre tokens que representam a mesma palavra,
#   mas estao diferentes por conter caracteres maiusculos e minusculos
#
tr '[a-z]' '[A-Z]' < $FILEIN | tr -sc '[A-Z]' '[\012*]' | sort | uniq -c

echo ---------------------
echo Activity 2.2
echo ---------------------
#
#   1- Converte todas as palavras do texto em caixa Alta
#   2- Conta todas as palavras que possuem sequencias de vogais
#
tr '[a-z]' '[A-Z]' < $FILEIN | tr -sc 'AEIOU' '[\012*]' | sort | uniq -c

echo ---------------------
echo Activity 2.3
echo ---------------------
#
#   1- Converte todas as palavras do texto em caixa Alta
#   2- Conta todas as palavras que possuem sequencias de CONSOANTES
#
tr '[a-z]' '[A-Z]' < $FILEIN | tr -sc 'BCDFGHJKLMNPQRSTVWXYZ' '[\012*]' | sort | uniq -c


#
#   Atividades 3 - Ordenacao 
#
echo ---------------------
echo Activity 3.1
echo ---------------------
#
#   Ordena as palavras do texto por frequencia 
#   sort -nr = Ordem numerica reversa
#   (Foi colocado um limitador para exibir os 30 tokens mais frequentes no texto)
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sort | uniq -c | sort -nr | sed 30q
echo ---------------------
echo Activity 3.2
echo ---------------------
#
#   Ordena as palavras do texto pelo alfabeto, desconsiderando o tipo de caixa 
#   sort -f = Ordem sem considerar caixa
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sort | uniq -c | sort -f 
echo ---------------------
echo Activity 3.3
echo ---------------------
#
#   Ordena as palavras do texto pela ordem "ritmica" (inicia pelo ultimo caractere do
#   token) 
#   rev = Inverte os caracteres do token
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN | sort | uniq -c | rev | sort | rev 


#
#   Atividades 4 - Bigrams (pares de palavras) 
#
echo ---------------------
echo Activity 4.1
echo ---------------------
#
#   Contagem de bigrams:
#   1- Tokenizacao
#   2- Imprimir na mesma linha palavra1 e palavra1+1
#   3- Conta 
#   4- Seleciona os 10 bigramas mais frequentes
#
tr -sc '[A-Z][a-z]' '[\012*]' < $FILEIN > ex41.wrd 
tail -n+2 ex41.wrd > ex41.nwrd
paste ex41.wrd ex41.nwrd | sort | uniq -c  > ex41.bigg 
cat ex41.bigg
echo ---------------------
echo Activity 4.1.1 - top 10
echo ---------------------
sort -nr ex41.bigg | sed 10q

#
#   Atividades 5 - Trigrams 
#
echo ---------------------
echo Activity 5.1
echo ---------------------
bash ./trigram.sh < $FILEIN > out.trigram
cat out.trigram
rm out.trigram

#
#   Atividades 6 - grep & egrep - Filters 
#
echo ---------------------
echo Activity 6.1
echo ---------------------
#
#   Aplica uma determinada expressao regular que retorna as linhas que contem 
#   determinado texto (-i desconsidera case sensitive)
#
grep 'GOD is Dead' $FILEIN | sed 2q
grep -i 'GOD is Dead' $FILEIN | sed 2q

echo ---------------------
echo Activity 6.2
echo ---------------------
#
#   1- Aplica uma determinada expressao regular que retorna as linhas que contem 
#      determinado texto (-i desconsidera case sensitive)
#   2- Conta os trigramas
#
grep -i 'GOD is Dead' $FILEIN | bash trigram.sh | sort -nr | sed 10q

echo ---------------------
echo Activity 6.3 - grep
echo ---------------------
#
#   1- Utiliza o comando -v para buscar as linhas que NAO contem determinada
#      expressao;
#
grep -i -v 'saint' $FILEIN 

echo ---------------------
echo Activity 6.5 - grep
echo ---------------------
#
#   1- Conta a quantidade de vezes que a palavra saint aparece no texto ;
#
grep -i -c 'saint' $FILEIN 




