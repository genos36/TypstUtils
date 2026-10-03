// Elenchi di termini (/ Termine: descrizione).
//
// Separatore, rientri e spaziatura sono impostazioni native di `terms` e si
// cambiano con semplici set rule. Lo stile del termine invece no: Typst non
// espone il termine come elemento a sé, e lo rende avvolgendolo in `strong`.
// Per cambiarlo senza riscrivere l'impaginazione di `terms`:
//   1. si ricostruisce l'elenco con i termini già stilizzati;
//   2. si neutralizza lo `strong` che Typst aggiunge attorno al termine
//      (delta 0), ripristinandolo nelle descrizioni, così un *grassetto*
//      nel testo resta grassetto;
//   3. una label interna evita che la regola si riapplichi all'elenco
//      ricostruito (altrimenti ricorsione infinita).
// L'impaginazione resta quella nativa: rientri, `tight`, `spacing` e il
// rientro di prima riga dei paragrafi si comportano come di default.

#let _styled = <course-terms-styled>

/// - term-style: funzione `term => content` applicata a ogni termine.
///   Default `emph` (corsivo). Qualsiasi funzione va bene, anche composta:
///   `strong`, `smallcaps`, `t => text(fill: blue, emph(t))`...
///   none per lasciare il grassetto di default di Typst.
/// - separator: separatore tra termine e descrizione; auto = default Typst.
/// - indent: rientro dell'elenco; auto = default Typst.
/// - hanging-indent: rientro delle righe successive; auto = default Typst.
/// - strong-delta: peso del grassetto da ripristinare nelle descrizioni
///   (300 è il default di Typst; cambiarlo solo se lo si cambia altrove).
#let rule-terms(
  term-style: emph,
  separator: auto,
  indent: auto,
  hanging-indent: auto,
  strong-delta: 300,
) = body => {
  let settings = (:)
  if separator != auto { settings.insert("separator", separator) }
  if indent != auto { settings.insert("indent", indent) }
  if hanging-indent != auto { settings.insert("hanging-indent", hanging-indent) }
  set terms(..settings)

  if term-style == none { return body }

  show terms: it => {
    if it.at("label", default: none) == _styled { return it }
    set strong(delta: 0)
    let items = it.children.map(item => terms.item(
      term-style(item.term),
      { set strong(delta: strong-delta); item.description },
    ))
    [#terms(
      ..items,
      tight: it.tight,
      separator: it.separator,
      indent: it.indent,
      hanging-indent: it.hanging-indent,
      spacing: it.spacing,
    )#_styled]
  }
  body
}