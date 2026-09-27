#import "/lib.typ": *

// Nel progetto reale queste righe stanno in common.typ
#let meta = (
  title: [Computability],
  author: "Genos",
  year: [A.A. 2026/27],
  date: datetime(year: 2026, month: 10, day: 1),
)
#let course-notes = notes.with(
  meta: meta,
  rules: (
    page: (margin: 2cm),
    footer: (left: [Genos], right: page-num(numbering: "1 / 1")),
  ),
  extra: (body => { set text(size: 10.5pt); body },),
)

#show: course-notes


#let l03 = deck(file: path("slides/L03.pdf"), name: "L03")

= Macchine di Turing
Rimandi: @sec:def, @cap:ridu, @sl:tm, @tab:conf.
Link esterno: #link("https://typst.app")[typst.app]; link interno: #link(<sec:def>)[definizione].

== Definizione <sec:def>
#lorem(400)

- primo livello
  - secondo livello
    - terzo livello

Codice inline `delta(q, a)` e a blocchi:
```python
def step(q, a): return delta[(q, a)]
```

$ f(n) = n^2 $

#slide-fig(deck: l03, 1) <sl:tm>

#figure(
  table(columns: 3, [Stato], [Simbolo], [Azione], [q0], [0], [R], [q1], [1], [L], [q2], [\_], [halt]),
  caption: [Configurazioni],
) <tab:conf>

= Riducibilità <cap:ridu>
#lorem(60)


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