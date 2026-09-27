// Dati del documento, passati esplicitamente (niente context).
//
// Il progetto li definisce una volta, es. nel suo common.typ:
//   #let meta = (title: [Computability], author: "Genos", year: [2026/27])
// e li passa a chi ne ha bisogno (template, copertina...).

/// Campi riconosciuti e valori di default.
/// - title:   titolo del documento (di norma il nome del corso)
/// - author:  autore, stringa o array di stringhe (va nei metadati PDF)
/// - date:    datetime, none per non indicarla
/// - lang:    lingua del testo
/// - teacher: docente
/// - year:    anno accademico, es. [2026/27]
/// - degree:  corso di laurea
#let default-meta = (
  title: none,
  author: none,
  date: none,
  lang: "it",
  teacher: none,
  year: none,
  degree: none,
)

/// Unisce i dati del progetto ai default, rifiutando campi sconosciuti
/// (probabili errori di battitura).
#let resolve-meta(meta: (:)) = {
  assert(type(meta) == dictionary, message: "meta: deve essere un dizionario")
  for key in meta.keys() {
    assert(
      key in default-meta,
      message: "meta: campo sconosciuto `" + key + "`; disponibili: " + default-meta.keys().join(", "),
    )
  }
  let m = default-meta + meta
  assert(
    m.author == none or type(m.author) == str
      or (type(m.author) == array and m.author.all(a => type(a) == str)),
    message: "meta: `author` deve essere una stringa o un array di stringhe",
  )
  assert(
    m.date == none or type(m.date) == datetime,
    message: "meta: `date` deve essere un datetime, es. datetime(year: 2026, month: 10, day: 1)",
  )
  m
}

/// Argomenti per `set document(..)`: solo i campi presenti.
#let document-args(meta: (:)) = {
  let args = (:)
  if meta.title != none { args.insert("title", meta.title) }
  if meta.author != none { args.insert("author", meta.author) }
  if meta.date != none { args.insert("date", meta.date) }
  args
}