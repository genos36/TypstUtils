// Dichiarazione di un PDF di slide e indice delle slide.

#import "/src/shared/slides/utils.typ": deck-tag
#import "/src/shared/custom-kinds.typ": kinds, kind-selector

/// Dichiara un PDF di slide. Restituisce un dizionario da passare
/// alle funzioni di layout come `deck:`.
///
/// - file: il PDF, come `path(...)` o `bytes`. Obbligatorio. Una stringa
///   verrebbe risolta rispetto al package, non al progetto.
/// - name: etichetta del deck nelle didascalie automatiche (es. "L03").
/// - frame: cornice sottile di default attorno alle pagine.
/// - gap: spazio di default tra pagine affiancate.
#let deck(file: none, name: "", frame: true, gap: 0.8em) = {
  assert(
    type(file) in (path, bytes),
    message: "deck: `file` è obbligatorio e va passato con path(\"...\") o come bytes, non come stringa",
  )
  (tag: deck-tag, file: file, name: name, frame: frame, gap: gap)
}

/// Indice delle sole slide citate nel documento.
#let slide-outline(title: kinds.slide.outline) = outline(
  title: title,
  target: kind-selector(kind: kinds.slide),
)