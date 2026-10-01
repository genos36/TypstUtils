// Preset per gli appunti: sceglie regole e valori.
// Ogni voce: nome: (rule: factory, args: argomenti).
// L'ordine conta: a parità di elemento vince la regola che viene dopo.
//
// È una funzione di `meta` perché alcune regole usano i dati del
// documento (lingua, intestazione).

#import "/src/shared/rules/mod.typ": *
#import "/src/shared/meta.typ": default-meta

#let notes-preset(meta: default-meta) = (
  page: (rule: rule-page, args: (margin: 2.5cm)),
  text: (rule: rule-text, args: (lang: meta.lang, leading: 0.6em, spacing: 1em, justify: true)),
  lists: (rule: rule-lists, args: (:)),
  raw: (rule: rule-raw, args: (:)),
  math: (rule: rule-math, args: (:)),
  code: (rule: rule-code, args: (:)),
  tables: (rule: rule-tables, args: (:)),
  figures: (rule: rule-figures, args: (:)),
  links: (rule: rule-links, args: (:)),
  refs: (rule: rule-refs, args: (:)),
  headings: (rule: rule-headings, args: (lang: meta.lang)),
  envs: (rule: rule-envs, args: (:)),
  markers: (rule: rule-markers, args: (:)),
  // Intestazione: corso a sinistra, anno accademico a destra.
  // Vuota (quindi assente) se meta non li fornisce.
  header: (rule: rule-header, args: (left: meta.title, right: meta.year)),
  // Nessuna posizione: resta la numerazione standard di rule-page.
  footer: (rule: rule-footer, args: (:)),
)