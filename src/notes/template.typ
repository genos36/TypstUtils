#import "/src/shared/rules/compose.typ": compose
#import "/src/shared/meta.typ": resolve-meta, document-args
#import "/src/notes/preset.typ": notes-preset

/// Template per gli appunti.
///
/// - meta: dati del documento (vedi `default-meta`): impostano i metadati
///   del PDF, la lingua e l'intestazione.
/// - rules: modifiche al preset per nome (dizionario di argomenti,
///   funzione sostitutiva, o none per disattivare).
/// - extra: regole aggiuntive del progetto, con priorità sul preset.
///
/// Uso tipico nel progetto (common.typ):
///   #let meta = (title: [Computability], author: "Genos", year: [2026/27])
///   #let course-notes = notes.with(meta: meta)
/// e poi nel documento principale:
///   #show: course-notes
#let notes(meta: (:), rules: (:), extra: (), body) = {
  let meta = resolve-meta(meta: meta)
  set document(..document-args(meta: meta))
  compose(
    preset: notes-preset(meta: meta),
    rules: rules,
    extra: extra,
    body,
  )
}