// Layout "pagina intera": una pagina dedicata, con una o più slide
// ridimensionate per riempirla (con più slide: stile dispensa).
//
// Nota: crea una nuova pagina, quindi va chiamato a livello principale
// del documento, non dentro block, box, liste o griglie.

#import "utils.typ": *

/// - deck: deck creato con `deck(...)`.
/// - ..pages: una o più pagine (posizionali, trattate come array).
/// - caption: auto (nome + pagine), none, o contenuto.
/// - columns: colonne della griglia con più pagine (auto: max 2).
/// - flipped: pagina orizzontale (adatta alle slide 16:9).
/// - margin: margini della pagina dedicata.
/// - caption-space: spazio riservato alla didascalia.
/// - frame, gap: auto → valori del deck.
/// - label: label della figura (`<label>` dopo la chiamata non funziona
///   qui, perché finirebbe sulla pagina).
#let slide-full(
  deck: none,
  ..pages,
  caption: auto,
  columns: auto,
  flipped: true,
  margin: 1.5cm,
  caption-space: 3em,
  frame: auto,
  gap: auto,
  label: none,
) = {
  check-deck(fn: "slide-full", deck: deck)
  let pages = pages.pos()
  check-pages(fn: "slide-full", pages: pages)
  let frame = resolve(value: frame, deck: deck, key: "frame")
  let gap = resolve(value: gap, deck: deck, key: "gap")
  let caption = resolve-caption(deck: deck, pages: pages, caption: caption)

  let cols = if columns == auto { calc.min(pages.len(), 2) } else { columns }
  let rows = calc.ceil(pages.len() / cols)

  page(flipped: flipped, margin: margin, layout(size => {
    // em → pt: servono lunghezze assolute per il confronto in fitted-image
    let gap = gap.to-absolute()
    let reserved = if caption == none { 0pt } else { caption-space.to-absolute() }
    let cell-w = (size.width - gap * (cols - 1)) / cols
    let cell-h = (size.height - reserved - gap * (rows - 1)) / rows

    let body = grid(
      columns: cols,
      gutter: gap,
      align: center + horizon,
      ..pages.map(n => fitted-image(
        deck: deck, n: n, max-w: cell-w, max-h: cell-h, frame: frame,
      )),
    )
    align(center + horizon, slide-figure(caption: caption, label: label, body))
  }))
}