// Riquadri visivi (callout): evidenziano un contenuto, senza numerazione
// né riferimenti. Sono anche la base grafica degli ambienti (envs).

/// Riquadro generico con barra laterale colorata e sfondo tenue.
///
/// - title: titolo in testa al riquadro, none per ometterlo.
/// - color: colore di barra, titolo e sfondo (schiarito).
/// - fill-lighten: quanto schiarire il colore per lo sfondo.
/// - breakable: il riquadro può spezzarsi tra pagine.
/// - body: contenuto.
#let callout(
  title: none,
  color: rgb("#2f6db5"),
  fill-lighten: 92%,
  breakable: true,
  body,
) = block(
  width: 100%,
  breakable: breakable,
  inset: (left: 10pt, right: 10pt, y: 8pt),
  radius: (right: 3pt),
  fill: color.lighten(fill-lighten),
  stroke: (left: 2.5pt + color),
  {
    if title != none {
      block(below: 0.65em, sticky: true, text(weight: "bold", fill: color.darken(25%), title))
    }
    body
  },
)

/// Nota di approfondimento.
#let note(title: [Nota], body) = callout(title: title, color: rgb("#2f6db5"), body)

/// Suggerimento, trucco, scorciatoia.
#let tip(title: [Suggerimento], body) = callout(title: title, color: rgb("#2e8540"), body)

/// Errore comune, caso limite, attenzione.
#let warning(title: [Attenzione], body) = callout(title: title, color: rgb("#c05a00"), body)

/// Domanda aperta, da chiarire con il docente.
#let question(title: [Domanda], body) = callout(title: title, color: rgb("#7a4bb0"), body)