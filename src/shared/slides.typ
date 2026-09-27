// Inclusione di pagine dai PDF delle slide del docente.
//
// Uso tipico (lato progetto):
//   #let l03 = deck(file: path("slides/L03.pdf"), name: "L03")
//   #l03(12) <sl:halting>
//   #l03(12, 13, caption: [Riduzione]) <sl:riduzione>

#import "custom-kinds.typ": kinds, kind-figure, kind-selector

// Una singola pagina come immagine, con cornice opzionale.
#let _page(file: none, n: 1, frame: true) = {
  let img = image(file, page: n, width: 100%)
  if frame { box(stroke: 0.5pt + luma(170), img) } else { img }
}

// Testo "p. 3", "pp. 3–5" o "pp. 3–5, 8": le pagine consecutive
// vengono compresse in intervalli.
#let _pages-label(pages: ()) = {
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

/// Dichiara un PDF di slide e restituisce una funzione che ne mostra le pagine.
///
/// - file: il PDF, come `path(...)` (una stringa verrebbe risolta rispetto
///   al package, non al progetto) oppure come `bytes`. Obbligatorio.
/// - name: etichetta del deck usata nella didascalia automatica (es. "L03").
/// - width: larghezza di default della figura.
/// - frame: cornice sottile attorno a ogni pagina.
/// - gap: spazio tra le pagine quando se ne mostrano più di una.
#let deck(file: none, name: "", width: 100%, frame: true, gap: 0.8em) = {
  assert(
    type(file) in (path, bytes),
    message: "deck: `file` è obbligatorio e va passato con path(\"...\") o come bytes, non come stringa",
  )

  /// - ..pages: una o più pagine (argomenti posizionali, trattati come array).
  /// - caption: auto (nome + pagine), none, o contenuto.
  /// - columns: colonne della griglia quando le pagine sono più di una.
  (..pages, caption: auto, width: width, frame: frame, columns: auto) => {
    let pages = pages.pos()
    assert(pages.len() > 0, message: "deck: indica almeno una pagina, es. l03(12)")
    assert(
      pages.all(n => type(n) == int and n > 0),
      message: "deck: le pagine devono essere interi positivi",
    )

    let cap = if caption == auto {
      let where = _pages-label(pages: pages)
      if name != "" [#name, #where] else { where }
    } else { caption }

    let body = if pages.len() == 1 {
      _page(file: file, n: pages.first(), frame: frame)
    } else {
      let cols = if columns == auto { calc.min(pages.len(), 2) } else { columns }
      grid(
        columns: (1fr,) * cols,
        gutter: gap,
        ..pages.map(n => _page(file: file, n: n, frame: frame)),
      )
    }

    kind-figure(kind: kinds.slide, caption: cap, block(width: width, body))
  }
}

/// Indice delle sole slide citate nel documento.
#let slide-outline(title: [Slide citate]) = outline(
  title: title,
  target: kind-selector(kind: kinds.slide),
)