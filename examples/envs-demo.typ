#import "/lib.typ": *

#let meta = (
  title: [Computability],
  author: "Genos",
  teacher: [Prof. Rossi],
  year: [A.A. 2026/27],
  degree: [Laurea Magistrale in Computer Science],
  date: datetime(year: 2026, month: 10, day: 1),
)
#show: notes.with(meta: meta)

#preface(outlines: ("heading", "thm", (kind: "definition", depth: 1), "slide"))[
  #title-page(meta: meta, subtitle: [Appunti del corso])
]

= Indecidibilità
Rimandi: @def:tm, @thm:rice, @lem:red, @ex:halt.

#definition(title: [Macchina di Turing])[
  Una macchina di Turing è una tupla $(Q, Sigma, Gamma, delta, q_0, q_"acc", q_"rej")$.
] <def:tm>

#theorem(title: [Rice])[
  Ogni proprietà non banale dei linguaggi riconosciuti è indecidibile.
] <thm:rice>

#proof[
  Per riduzione dal problema della fermata. #lorem(30)
]

#lemma[#lorem(20)] <lem:red>
#corollary[#lorem(10)]

#example[Il problema della fermata $H$.] <ex:halt>

#note[#lorem(15)]
#tip[#lorem(10)]
#warning(title: [Errore comune])[#lorem(12)]
#question[Vale anche per i trasduttori?]

#theorem(title: [Lungo])[#lorem(700)]

= Riducibilità
#theorem[#lorem(15)]
