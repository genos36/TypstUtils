#import "/src/shared/custom-kinds.typ": kinds
#import "/src/shared/box.typ": callout

/// Aspetto degli ambienti (teoremi, definizioni, esempi): riquadri con
/// titolo "Teorema 3 (Rice)." e contenuto allineato a sinistra.
///
/// - colors: colore per voce del registro (thm, definition, example, exercise).
/// - spacing: spazio sopra e sotto ogni ambiente.
#let rule-envs(
  colors: (
    thm: rgb("#2f6db5"),
    definition: rgb("#2e8540"),
    example: luma(110),
    exercise: rgb("#00838f"),
  ),
  spacing: 1.2em,
) = body => {
  colors.pairs().fold(body, (acc, (name, color)) => {
    assert(name in kinds, message: "rule-envs: `" + name + "` non è nel registro dei kind")
    show figure.where(kind: kinds.at(name).kind): it => {
      let heading = [#it.supplement #it.counter.display(it.numbering)]
      if it.caption != none { heading += [ (#it.caption.body)] }
      block(above: spacing, below: spacing, breakable: true,
        align(start, callout(title: [#heading.], color: color, it.body)))
    }
    acc
  })
}