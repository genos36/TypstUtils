// Layout "figura": slide nel flusso del testo, una o più affiancate.

#import "utils.typ": *

/// - deck: deck creato con `deck(...)`.
/// - ..pages: una o più pagine (posizionali, trattate come array).
/// - caption: auto (nome + pagine), none, o contenuto.
/// - width: larghezza della figura.
/// - columns: colonne della griglia con più pagine (auto: max 2).
/// - frame, gap: auto → valori del deck.
/// - label: alternativa a `<label>` dopo la chiamata.
#let slide-fig(
  deck: none,
  ..pages,
  caption: auto,
  width: 100%,
  columns: auto,
  frame: auto,
  gap: auto,
  label: none,
) = {
  check-deck(fn: "slide-fig", deck: deck)
  let pages = pages.pos()
  check-pages(fn: "slide-fig", pages: pages)
  let frame = resolve(value: frame, deck: deck, key: "frame")
  let gap = resolve(value: gap, deck: deck, key: "gap")

  let body = if pages.len() == 1 {
    page-image(deck: deck, n: pages.first(), frame: frame)
  } else {
    let cols = if columns == auto { calc.min(pages.len(), 2) } else { columns }
    grid(
      columns: (1fr,) * cols,
      gutter: gap,
      ..pages.map(n => page-image(deck: deck, n: n, frame: frame)),
    )
  }

  slide-figure(
    caption: resolve-caption(deck: deck, pages: pages, caption: caption),
    label: label,
    block(width: width, body),
  )
}