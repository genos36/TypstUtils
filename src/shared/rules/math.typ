/// Aspetto delle formule.
///
/// - block-align: allineamento delle formule in blocco (`$ ... $` con
///   spazi), es. left, center.
#let rule-math(
  block-align: left,
) = body => {
  assert(type(block-align) == alignment, message: "rule-math: `block-align` deve essere un allineamento, es. left")
  show math.equation.where(block: true): set align(block-align)
  body
}