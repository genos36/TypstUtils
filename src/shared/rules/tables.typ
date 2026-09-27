/// Tabelle: righe alternate e comportamento ai cambi pagina.
///
/// - zebra: colore delle righe pari, none per disattivare.
/// - breakable: le figure-tabella possono spezzarsi tra pagine.
/// - keep-cells: una singola cella non viene mai spezzata.
#let rule-tables(
  inset: 8pt,
  zebra: gray.lighten(70%),
  breakable: true,
  keep-cells: true,
) = body => {
  set table(
    inset: inset,
    fill: (x, y) => if zebra != none and calc.even(y) { zebra } else { none },
  )
  show figure.where(kind: table): set block(breakable: breakable)
  show table.cell: it => if keep-cells { block(breakable: false, it) } else { it }
  body
}