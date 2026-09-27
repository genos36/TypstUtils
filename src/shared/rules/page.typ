/// Impostazioni di pagina.
#let rule-page(
  paper: "a4",
  margin: 2.5cm,
  numbering: "1",
  number-align: center,
) = body => {
  set page(paper: paper, margin: margin, numbering: numbering, number-align: number-align)
  body
}