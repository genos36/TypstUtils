#import "/lib.typ": *
#set page(height: auto)
#show: notes.with(rules: (
  // term-style ha default emph: qui solo il separatore
  terms: (separator: [: ]),
))
#set par(first-line-indent: (amount: 1.5em, all: true))

Paragrafo con rientro di prima riga, per verificare che l'elenco non lo erediti.

/ Decidibile: esiste una macchina che *si ferma sempre* e risponde correttamente. #lorem(20)
/ Semidecidibile: esiste una macchina che si ferma sulle istanze positive.
  / Annidato: un elenco dentro la descrizione.

// Righe vuote tra le voci: elenco non compatto (tight: false).
/ Largo: elenco non compatto.

/ Secondo: con più spazio tra le voci.

// Stile diverso cambiando solo l'invocazione
#show: rule-terms(term-style: t => text(fill: rgb("#2f6db5"), smallcaps(t)))
/ Riducibile: con uno stile personalizzato.
