#import "/src/shared/custom-kinds.typ": kinds

// Risolve un nome di kind: prima nel registro ("slide" → "course-slide"),
// altrimenti la stringa è usata così com'è (kind definiti dal progetto).
#let _resolve-kind(k) = if type(k) == str and k in kinds { kinds.at(k).kind } else { k }

// Titolo di default: quello del registro se il kind ne ha uno,
// altrimenti auto (Typst usa "Indice").
#let _default-title(k) = if type(k) == str and k in kinds { kinds.at(k).at("outline", default: auto) } else { auto }

// Selettore dei contenuti da elencare.
#let _target(k) = {
  if k == "heading" or k == heading { heading }
  else { figure.where(kind: _resolve-kind(k)) }
}

/// Crea un indice a partire da una specifica:
///
/// - stringa: nome di kind; "heading" per i titoli, un nome del registro
///   (es. "slide", "thm", con il titolo di indice del registro) o una
///   stringa di kind qualsiasi.
/// - tipo built-in: `heading`, `image`, `table`, `raw`.
/// - dizionario: `kind` (default "heading") diventa il `target`, il resto va
///   a `outline`, es. (kind: "slide", title: [Slide], depth: 1).
/// - content: un `outline(...)` già costruito, usato così com'è.
#let make-outline(spec: "heading") = {
  if type(spec) == content { return spec }
  if type(spec) in (str, function) {
    return outline(title: _default-title(spec), target: _target(spec))
  }
  assert(
    type(spec) == dictionary,
    message: "make-outline: `spec` deve essere stringa, tipo, dizionario o content, ricevuto " + str(type(spec)),
  )
  let args = spec
  let k = args.remove("kind", default: "heading")
  assert("target" not in args, message: "make-outline: usa `kind`, non `target`")
  let title = args.remove("title", default: _default-title(k))
  outline(title: title, target: _target(k), ..args)
}
