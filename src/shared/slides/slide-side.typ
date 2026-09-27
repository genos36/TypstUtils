// Layout "affiancato": una slide su un lato, il testo sull'altro.
// Pensato per essere ripetuto, una chiamata per slide commentata.

#import "utils.typ": *

/// - deck: deck creato con `deck(...)`.
/// - page: la pagina da mostrare (una sola per chiamata).
/// - caption: auto (nome + pagina), none, o contenuto.
/// - width: larghezza della colonna della slide.
/// - side: `left` o `right`, lato della slide.
/// - gap: spazio tra slide e testo.
/// - breakable: se false (default) slide e testo restano sulla stessa
///   pagina; se true il testo lungo può continuare alla pagina dopo.
/// - frame: auto → valore del deck.
/// - label: label della figura (`<label>` dopo la chiamata finirebbe sul
///   blocco, non sulla figura).
/// - body: il testo di commento.
#let slide-side(
  deck: none,
  page: 0,
  caption: auto,
  width: 55%,
  side: left,
  gap: 1em,
  breakable: false,
  frame: auto,
  label: none,
  body,
) = {
  check-deck(fn: "slide-side", deck: deck)
  check-pages(fn: "slide-side", pages: (page,), max: 1)
  assert(side in (left, right), message: "slide-side: `side` deve essere left o right")
  let frame = resolve(value: frame, deck: deck, key: "frame")

  let fig = slide-figure(
    caption: resolve-caption(deck: deck, pages: (page,), caption: caption),
    label: label,
    page-image(deck: deck, n: page, frame: frame),
  )
  let (cols, cells, text-col) = if side == left {
    ((width, 1fr), (fig, body), 1)
  } else {
    ((1fr, width), (body, fig), 0)
  }

  block(breakable: breakable, grid(
    columns: cols,
    gutter: gap,
    align: (x, y) => top + if x == text-col { left } else { center },
    ..cells,
  ))
}