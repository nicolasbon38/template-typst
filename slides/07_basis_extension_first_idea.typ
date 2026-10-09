#import "../theme/touying/theme-crx.typ": slide
#import "@preview/cetz:0.5.2"
#import "../theme/inline-components.typ": pbs-inline, pbs-example
#import "../theme/boxes.typ": questionbox, alertbox
#import "../theme/mannot/ciphertext.typ": plaintextmath



#slide(repeat: 5, self=>{
  let reveal(step, body) = if self.subslide >= step { body } else { hide(body) }


  questionbox([How to extend the basis of variables? (i.e., increase the number of columns in the matrix)])

  reveal(2)[
    *First idea:* we sample random functions $phi_(n+1), dots, phi_(s^n)$.
  ]

  v(0.3em)
  grid(
    columns: (auto, auto, auto),
    align: (right + horizon, left + horizon, center + horizon),
    column-gutter: (0.4em, 1em),
    row-gutter: 0.5em,
    reveal(2, $x_(n+1)$), reveal(2, $= phi_(n+1)(x_1, dots, x_n)$),
    reveal(2, pbs-example("pbs-first")),
    reveal(3, $x_(n+2)$), reveal(3, $= phi_(n+2)(x_1, dots, x_(n+1))$),
    reveal(3, pbs-example("pbs-second")),
    [], reveal(4, $dots.v$), reveal(4, $dots.v$),
    reveal(4, $x_(s^n)$), reveal(4, $= phi_(s^n)(x_1, dots, x_(s^n-1))$),
    reveal(4, pbs-example("pbs-last")),
  )

  reveal(5, alertbox([This costs one #pbs-inline("pbs-text") per function. Not efficient in practice.]))
})
