#import "/src/shared/custom-kinds.typ": kinds

/// Spaziatura sopra e sotto le figure dei kind indicati.
/// Si filtra per kind invece di agire su tutte le figure perché alcuni
/// package (es. glossarium) usano figure internamente.
#let rule-figures(
  kinds: (image, table, raw, kinds.slide.kind),
  spacing: 1.5em,
) = body => {
  kinds.fold(body, (acc, k) => {
    show figure.where(kind: k): set block(above: spacing, below: spacing)
    acc
  })
}