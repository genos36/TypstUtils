#import "/src/shared/custom-kinds.typ": kinds
#import "/src/shared/rules/styles.typ": style-internal-ref

/// Stile dei riferimenti (@label) a titoli e figure dei kind indicati.
/// Gli altri riferimenti (equazioni, citazioni...) restano invariati.
#let rule-refs(
  kinds: (image, table, raw, kinds.slide.kind),
  headings: true,
  style: style-internal-ref,
) = body => {
  show ref: it => {
    let el = it.element
    let styled = el != none and (
      (headings and el.func() == heading)
        or (el.func() == figure and el.kind in kinds)
    )
    if styled { style(it) } else { it }
  }
  body
}