/// Font, lingua e paragrafi.
#let rule-text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "it",
  leading: 0.65em,
  spacing: 1.2em,
  justify: false,
) = body => {
  set text(font: font, size: size, lang: lang)
  set par(leading: leading, spacing: spacing, justify: justify)
  body
}