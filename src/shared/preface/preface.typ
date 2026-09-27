#import "/src/shared/preface/outlines.typ": make-outline

/// Parte introduttiva: contenuto iniziale (es. copertina) seguito dagli
/// indici, con pagine numerate a parte. Al termine la numerazione
/// riparte da 1 per il corpo del documento.
///
/// - outlines: specifiche degli indici, nell'ordine (vedi `make-outline`),
///   es. ("heading", "thm", (kind: "slide", title: [Slide citate])).
/// - numbering: numerazione delle pagine introduttive.
/// - body: contenuto iniziale, es. `title-page(meta: meta)`; può essere vuoto.
///
///   #preface(outlines: ("heading", "slide"))[#title-page(meta: meta)]
#let preface(outlines: ("heading",), numbering: "i", body) = {
  assert(type(outlines) == array, message: "preface: `outlines` deve essere un array, es. (\"heading\",)")
  set page(numbering: numbering)
  body
  for spec in outlines {
    pagebreak(weak: true)
    make-outline(spec: spec)
  }
  pagebreak(weak: true)
  counter(page).update(1)
}