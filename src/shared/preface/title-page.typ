#import "/src/shared/meta.typ": resolve-meta

/// Copertina: pagina dedicata, senza intestazione, piè di pagina e numero.
/// I dati vengono da `meta` (vedi `default-meta`), passato esplicitamente.
///
/// - meta: dati del documento.
/// - subtitle: sottotitolo facoltativo.
/// - date-format: formato della data, se presente in meta.
/// - extra: contenuto aggiuntivo in fondo (es. una nota, un logo).
#let title-page(
  meta: (:),
  subtitle: none,
  date-format: "[day]/[month]/[year]",
  extra: none,
) = {
  let m = resolve-meta(meta: meta)
  let author = if type(m.author) == array { m.author.join(", ") } else { m.author }
  let line(value, size: 1em, weight: "regular") = if value != none {
    block(below: 0.8em, text(size: size, weight: weight, value))
  }

  page(header: none, footer: none, numbering: none, align(center + horizon, {
    line(m.degree, size: 1.1em)
    v(1.5em)
    line(m.title, size: 2.4em, weight: "bold")
    line(subtitle, size: 1.4em)
    v(2em)
    line(author, size: 1.2em)
    if m.teacher != none { line([Docente: #m.teacher]) }
    line(m.year)
    if m.date != none { line(m.date.display(date-format)) }
    if extra != none { v(3em); extra }
  }))
}