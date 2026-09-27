/// Nome dei capitoli per lingua, usato con `supplement: auto`.
#let chapter-names = (it: [Capitolo], en: [Chapter])

/// Titoli: numerazione, spaziatura e stile dei capitoli (livello 1).
///
/// - chapter-break: salto pagina prima di ogni capitolo.
/// - chapter-style: capitolo su due righe ("Capitolo N" e titolo grande);
///   se false resta lo stile normale.
/// - supplement: nome usato nei riferimenti e nel titolo dei capitoli;
///   auto → da `chapter-names` in base a `lang` (scelto alla creazione
///   della regola, senza context).
/// - lang: lingua usata con `supplement: auto`.
#let rule-headings(
  numbering: "1.1",
  above: 1.8em,
  below: 1em,
  chapter-break: true,
  chapter-style: true,
  supplement: auto,
  lang: "it",
) = body => {
  let chapter-name = if supplement == auto {
    chapter-names.at(lang, default: chapter-names.en)
  } else { supplement }

  set heading(numbering: numbering)
  show heading: set block(above: above, below: below)

  show heading.where(level: 1): set heading(supplement: chapter-name)

  show heading.where(level: 1): it => {
    if chapter-break { pagebreak(weak: true) }
    if not chapter-style { return it }
    block(above: 0em, below: 2em, stack(
      spacing: 1em,
      if it.numbering != none {
        text(size: 1.4em)[#it.supplement #counter(heading).display(it.numbering)]
      },
      text(size: 2em, weight: "bold", it.body),
    ))
  }
  body
}