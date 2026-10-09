#import "../theme/touying/theme-crx.typ": slide
#import "../theme/inline-components.typ": pbs-inline, pbs-example
#import "../theme/boxes.typ": propertybox
#import "../theme/mannot/ciphertext.typ": ciphertextmath
#import "../theme/circuits/ciphertexts.typ": ciphertext-block
#import "../theme/circuits/gates.typ": pbs-block, add-block, connect
#import "@preview/touying:0.7.4": utils
#import "@preview/cetz:0.5.2"


#slide(repeat: 5, self => {
  let (uncover, only, alternatives) = utils.methods(self)
  let product-circuit = cetz.canvas({
    ciphertext-block((0, 1.2), "x", [$x$])
    ciphertext-block((0, -1.2), "y", [$y$])

    pbs-block(
      (3.5, 1.2),
      "pbs-plus",
      content: [PBS \
        $frac((x+y)^2, 4)$],
    )
    pbs-block(
      (3.5, -1.2),
      "pbs-minus",
      content: [PBS \
        $-frac((x-y)^2, 4)$],
    )

    add-block((7, 0), "sum")
    ciphertext-block((10, 0), "product", [$x dot.c y$])

    connect((
      ("x", "pbs-plus"),
      ("y", "pbs-plus"),
      ("x", "pbs-minus"),
      ("y", "pbs-minus"),
      ("pbs-plus", "sum"),
      ("pbs-minus", "sum"),
      ("sum", "product"),
    ))
  })

  [
    *Second idea:* we use multiplication to use fewer #pbs-inline("pbs-inline"):
  ]

  uncover("2-")[
    #propertybox(
      "A ciphertext-ciphertext product takes two PBS:",
      [$ciphertextmath(dot.op)$ #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] #pbs-inline("pbs-last") $times 2$]
    )
  ]


  only("3")[
    // A fixed stage keeps the heading in the same position on every subslide.
    #block(width: 100%, height: 9cm)[
        #set text(1.5em)
          #stack(
            spacing: 2em,
            align(center, [$x dot.c y = frac((x+y)^2, 4) - frac((x-y)^2, 4)$]),
            align(center, [#scale(100%, reflow: true, product-circuit)]),
          )
      ]
    ]

    only("4-")[
        #columns(2, gutter: 2em)[
      #grid(
        columns: (auto, auto, auto),
        align: (right + horizon, left + horizon, center + horizon),
        column-gutter: (0.4em, 0.7em),
        row-gutter: 0.5em,
        $x_(n+1)$, $= phi_(n+1)(x_1, dots, x_n)$, pbs-example("pbs-first"),
        $x_(n+2)$, $= phi_(n+2)(x_1, dots, x_(n+1))$, pbs-example("pbs-second"),
        [], $dots.v$, [],
        $x_(n+lambda)$, $= phi_(n+lambda)(x_1, dots, x_(n+lambda-1))$,
        pbs-example("pbs-last"),
      )

      #colbreak()

      #if self.subslide >= 5 [
        #grid(
            columns: (auto, auto, auto),
            align: (right + horizon, center + horizon, left + horizon),
            column-gutter: (0.5em, 0.25em),
            row-gutter: 0.5em,
            $x_(1,7) = x_1 dot.c x_7$, pbs-example("pbs-z-first"), $times 2$,
            $x_(3,n+2) = x_3 dot.c x_(n+2)$, pbs-example("pbs-z-second"), $times 2$,
            $dots.v$, [], [],
            $x_(n+1,s^n) = x_(n+1) dot.c x_(s^n)$, pbs-example("pbs-z-last"), $times 2$,
        )
      ]
        ]
      ]

})



#slide(title:"Full formula:", self=>{

  [$ f(ciphertextmath(bold(x))) =
    sum_(i=1)^(t)
      (sum_(j=1)^(n+lambda) beta_(i,j) dot.op ciphertextmath(x_j))
      ciphertextmath(dot.op)
      (sum_(k=1)^(n+lambda) d_(i,k) dot.op ciphertextmath(x_k))
    + sum_(k=1)^(n+lambda) beta_(t,j) dot.op ciphertextmath(x_j) $]

  propertybox("Cost of evaluation of the decomposition", [$ lambda + 2t $])

  propertybox("Bounds on the parameters (necessary to get a fulkl-rank matrix)", [$ s^n lt.eq (t+1)(n + lambda) $])

})
