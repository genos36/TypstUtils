/// Marcatori degli elenchi puntati, uno per livello di annidamento.
#let rule-lists(
  markers: (sym.bullet, sym.bullet.tri, sym.dash),
) = body => {
  set list(marker: markers)
  body
}