#import "../lib.typ": *

#set page(numbering: "1")
#set text(lang: "it")

#let l03 = deck(file: path("slides/L03.pdf"), name: "L03")

= Figura nel testo
Pagina singola in @sl:uno, due pagine affiancate in @sl:due,
pagina intera in @sl:intera, affiancata al testo in @sl:side.

#slide-fig(deck: l03, 1) <sl:uno>
#slide-fig(deck: l03, 2, 3, caption: [Riduzione, in due passi]) <sl:due>

= Affiancate al testo
#slide-side(deck: l03, page: 2, label: <sl:side>)[
  Qui va il commento alla slide: definizioni, passaggi saltati dal
  docente, collegamenti con altre lezioni.
]
#slide-side(deck: l03, page: 3, side: right)[
  Stessa cosa con la slide a destra.
  #lorem(40)
]
#slide-side(deck: l03, page: 4, width: 45%, caption: none)[
  Senza didascalia e con colonna più stretta. #lorem(20)
]

= Pagina intera
#slide-full(deck: l03, 5, label: <sl:intera>)
#slide-full(deck: l03, 1, 2, 3, 4, caption: [Dispensa: pp. 1–4])

= Normale
#figure(rect[figura normale], caption: [Numerazione separata])

#slide-outline()