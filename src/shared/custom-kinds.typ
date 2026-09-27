// Registro centrale dei kind custom di figure usati dal package.
//
// Ogni kind è un dizionario con:
//   - kind:       la stringa usata in figure(kind: ...), con prefisso
//                 del package per evitare conflitti con altri package
//   - supplement: il testo mostrato nei riferimenti e nelle didascalie
//
// Per aggiungere un kind: una voce nel dizionario `kinds`, poi usare
// `kind-figure(kinds.<nome>, ...)` per creare le figure.

#let custom-prefix = "course-"

#let kinds = (
  slide: (kind: custom-prefix + "slide", supplement: [Slide]),
)

// Controllo di coerenza: nessuna stringa di kind duplicata.
#{
  let names = kinds.values().map(k => k.kind)
  assert.eq(
    names.len(),
    names.dedup().len(),
    message: "custom-kinds: due voci usano la stessa stringa di kind",
  )
}

// Crea una figura del kind indicato; gli argomenti extra
// (caption, placement, gap...) sono passati a figure.
#let kind-figure(kind:(:), body, ..args) = figure(
  body,
  kind: kind.kind,
  supplement: kind.supplement,
  ..args,
)

// Selettore per tutte le figure di un kind, utile per outline e show rule.
#let kind-selector(kind:(:)) = figure.where(kind: kind.kind)