#import "/src/shared/custom-kinds.typ": kinds
#import "/src/shared/box.typ": callout

/// Aspetto dei marcatori (todo, ask): riquadro compatto con
/// "Da fare 3: testo" ed eventuali dettagli sotto.
///
/// - colors: colore per voce del registro.
/// - visible: se false i marcatori non compaiono nel testo (es. versione
///   da condividere); restano negli indici, se presenti.
#let rule-markers(
  colors: (
    todo: rgb("#c05a00"),
    ask: rgb("#7a4bb0"),
  ),
  visible: true,
) = body => {
  colors.pairs().fold(body, (acc, (name, color)) => {
    assert(name in kinds, message: "rule-markers: `" + name + "` non è nel registro dei kind")
    show figure.where(kind: kinds.at(name).kind): it => {
      if not visible { return none }
      let head = text(weight: "bold", fill: color.darken(25%))[#it.supplement #it.counter.display(it.numbering):]
      let detail = if it.body != [] { block(above: 0.5em, it.body) }
      align(start, callout(color: color, [#head #it.caption.body #detail]))
    }
    acc
  })
}