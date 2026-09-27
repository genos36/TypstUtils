// Infrastruttura generica per disporre contenuto su tre posizioni:
// sinistra, centro, destra. Usata da header e footer, ma adatta a
// qualsiasi riga (es. intestazioni di copertina).

/// Riga a tre posizioni. Le colonne laterali hanno la stessa larghezza,
/// così il centro resta centrato anche con lati di lunghezza diversa.
///
/// - left, center, right: contenuto di ciascuna posizione (none = vuota).
///
/// Nota: i parametri oscurano gli allineamenti omonimi, per questo
/// all'interno si usano `start`, `end` e `std.center`.
#let three-slots(left: none, center: none, right: none) = grid(
  columns: (1fr, auto, 1fr),
  align(start, left),
  align(std.center, center),
  align(end, right),
)

/// True se nessuna posizione ha contenuto.
#let slots-empty(left: none, center: none, right: none) = (
  left == none and center == none and right == none
)