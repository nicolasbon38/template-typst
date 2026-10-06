#import "../theme/touying/theme-crx.typ": slide
#import "@preview/cetz:0.5.2"
#import "../theme/inline-components.typ": pbs-inline, pbs-example
#import "../theme/boxes.typ": questionbox, alertbox
#import "../theme/mannot/ciphertext.typ": plaintextmath



#slide(repeat: 6, self=>{
  let reveal(step, body) = if self.subslide >= step { body } else { hide(body) }


  questionbox([How to extend the basis of variables? (i.e., increase the number of columns in the matrix)])

  reveal(2)[
    *First idea:* we sample random functions $phi_(n+1), dots, phi_(s^n)$.
  ]

  v(0.3em)
  if self.subslide <=5{
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
  } else{
    // Step 6: the extended matrix-vector product, without coefficients.
    cetz.canvas({
      import cetz.draw: content, line

      let dimensioned(position, name, body, width, columns, plaintext: false) = {
        let symbol = $ lr(( #box(
          width: width,
          height: 4cm,
          inset: 4pt,
          align(center + horizon, text(size: 1.2em, body)),
        ) )) $
        let annotated = if plaintext { $ #plaintextmath(symbol) $ } else { symbol }
        content(position, name: name, annotated)
        line(
          (rel: (0, 0.3), to: name + ".north-west"),
          (rel: (0, 0.3), to: name + ".north-east"),
          stroke: 0.7pt,
          mark: (start: "<", end: ">"),
        )
        content((rel: (0, 0.65), to: name + ".north"), text(size: 0.7em, columns))
        line(
          (rel: (-0.3, 0), to: name + ".south-west"),
          (rel: (-0.3, 0), to: name + ".north-west"),
          stroke: 0.7pt,
          mark: (start: "<", end: ">"),
        )
        content((rel: (-0.65, 0), to: name + ".west"), text(size: 0.7em, $s^n$), angle: 90deg)
      }

      dimensioned((0, 0), "extended-matrix", $X$, 4cm, $s^n$)
      content((3.4, 0), $dot.op$)
      dimensioned((6.5, 0), "beta-vector", $beta$, 1.2cm, $1$, plaintext: true)
      content((9, 0), $=$)
      dimensioned((12, 0), "output-vector", $y$, 1.2cm, $1$)
    })
  }
})
