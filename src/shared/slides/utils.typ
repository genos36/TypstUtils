// Funzioni di supporto comuni ai layout delle slide.
// Non esportate da lib.typ: sono dettagli interni.

#import "/src/shared/custom-kinds.typ": kinds, kind-figure

#let deck-tag = "course-deck"

/// Verifica che `deck` sia il risultato di `deck(...)`.
#let check-deck(fn: "", deck: none) = assert(
  type(deck) == dictionary and deck.at("tag", default: none) == deck-tag,
  message: fn + ": `deck` va creato con deck(file: path(\"...\"), ...)",
)

/// Verifica che le pagine siano interi positivi, almeno `min`.
#let check-pages(fn: "", pages: (), min: 1, max: none) = {
  assert(pages.len() >= min, message: fn + ": indica almeno una pagina")
  if max != none {
    assert(pages.len() <= max, message: fn + ": al massimo " + str(max) + " pagine")
  }
  assert(
    pages.all(n => type(n) == int and n > 0),
    message: fn + ": le pagine devono essere interi positivi",
  )
}

/// "p. 3", "pp. 3–5" o "pp. 3–5, 8": pagine consecutive compresse.
#let pages-label(pages: ()) = {
  if pages.len() == 1 { return [p. #pages.first()] }
  let runs = ()
  for n in pages {
    if runs.len() > 0 and runs.last().at(1) + 1 == n {
      runs.last().at(1) = n
    } else {
      runs.push((n, n))
    }
  }
  let parts = runs.map(((a, b)) => if a == b { str(a) } else { str(a) + "–" + str(b) })
  [pp. #parts.join(", ")]
}

/// Didascalia effettiva: `auto` → "<nome>, p. N", altrimenti quella data.
#let resolve-caption(deck: none, pages: (), caption: auto) = {
  if caption != auto { return caption }
  let where = pages-label(pages: pages)
  if deck.name != "" [#deck.name, #where] else { where }
}

/// Valore effettivo di un'opzione: `auto` → default del deck.
#let resolve(value: auto, deck: none, key: "") = {
  if value == auto { deck.at(key) } else { value }
}

/// Una pagina del PDF come immagine, con cornice opzionale.
#let page-image(deck: none, n: 1, width: 100%, frame: true) = {
  let img = image(deck.file, page: n, width: width)
  if frame { box(stroke: 0.5pt + luma(170), img) } else { img }
}

/// Una pagina ridimensionata per stare in un riquadro `max-w` × `max-h`,
/// mantenendo le proporzioni. Richiede contesto (usa `measure`).
#let fitted-image(deck: none, n: 1, max-w: 0pt, max-h: 0pt, frame: true) = {
  let natural = measure(image(deck.file, page: n))
  let ratio = natural.width / natural.height
  let w = calc.min(max-w, max-h * ratio)
  page-image(deck: deck, n: n, width: w, frame: frame)
}

/// Figura di kind slide, con label opzionale applicata alla figura stessa
/// (serve quando la figura è annidata in un layout e `<label>` dopo la
/// chiamata finirebbe sul contenitore invece che sulla figura).
#let slide-figure(caption: none, label: none, body) =kind-figure(kind: kinds.slide, caption: caption, body, label: label)