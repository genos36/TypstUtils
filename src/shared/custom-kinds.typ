// Registro centrale dei kind custom di figure usati dal package.
//
// Ogni kind è un dizionario con:
//   - kind:       la stringa usata in figure(kind: ...), con prefisso
//                 del package per evitare conflitti con altri package
//   - supplement: il testo di default mostrato nei riferimenti e nelle
//                 didascalie (sovrascrivibile per singola figura)
//   - outline:    titolo di default dell'indice di quel kind
//
// Più ambienti possono condividere un kind, e quindi la numerazione:
// teorema, lemma, corollario e proposizione usano tutti `thm`, ognuno con
// il proprio supplemento ("Teorema 1", "Lemma 2", "Corollario 3").
//
// Per aggiungere un kind: una voce nel dizionario `kinds`, poi usare
// `kind-figure(kind: kinds.<nome>)[...]` per creare le figure.

#let custom-prefix = "course-"

#let kinds = (
  slide: (kind: custom-prefix + "slide", supplement: [Slide], outline: [Slide citate]),
  thm: (kind: custom-prefix + "thm", supplement: [Teorema], outline: [Teoremi]),
  definition: (kind: custom-prefix + "definition", supplement: [Definizione], outline: [Definizioni]),
  example: (kind: custom-prefix + "example", supplement: [Esempio], outline: [Esempi]),
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

#let _check-kind(fn, kind) = assert(
  type(kind) == dictionary and "kind" in kind and "supplement" in kind,
  message: fn + ": `kind` deve essere una voce di `kinds` (es. kinds.slide)",
)

/// Crea una figura del kind indicato.
///
/// - kind: voce del registro, es. `kinds.slide`.
/// - ..args: argomenti nominali passati a `figure` (caption, placement, gap...).
///   Un `supplement` esplicito sostituisce quello del registro.
/// - body: contenuto della figura.
#let kind-figure(kind: none, ..args, body) = {
  _check-kind("kind-figure", kind)
  assert(args.pos().len() == 0, message: "kind-figure: accetta solo argomenti nominali oltre al contenuto")
  let named = args.named()
  let supplement = named.remove("supplement", default: kind.supplement)
  figure(body, kind: kind.kind, supplement: supplement, ..named)
}

/// Selettore per tutte le figure di un kind, utile per outline e show rule.
#let kind-selector(kind: none) = {
  _check-kind("kind-selector", kind)
  figure.where(kind: kind.kind)
}