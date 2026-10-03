#import "../common.typ": *

#let body = [
  = Macchine di Turing <cap:turing>
  Definite in @sipser; il limite è il teorema di @cap:rice.
]

// Da qui in giù: solo se questo file è l'entrypoint della compilazione.
// Quando main.typ lo importa, questo contenuto viene ignorato.
#show: chapter-notes
#body
#course-bib()
