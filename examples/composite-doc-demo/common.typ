// Parti comuni del corso: dati, template, bibliografia.
#import "/lib.typ": *

#let meta = (title: [Computability], author: "Genos", year: [A.A. 2026/27])

// Documento completo: riferimenti mancanti = errore.
#let course-notes = notes.with(meta: meta)
// Singolo capitolo: riferimenti ad altri capitoli come segnaposto.
#let chapter-notes = notes.with(meta: meta, extra: (rule-missing-refs(),))

#let course-bib() = bibliography(path("refs.bib"), title: [Bibliografia])
