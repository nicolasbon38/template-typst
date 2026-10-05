#import "../../theme/touying/theme-crx.typ": slide
#import "../../theme/mannot/ciphertext.typ": ciphertextmath, plaintextmath
#import "../../theme/boxes.typ": questionbox, alertbox, propertybox
#import "../../theme/circuits/ciphertexts.typ": ciphertext-block
#import "../../theme/circuits/gates.typ": operator-block, connect, pbs-block
#import "@preview/touying:0.7.4": utils
#import "@preview/pinit:0.2.2": pin, pinit-point-to
#import "@preview/cetz:0.5.2"

#let pbs-example(label) = cetz.canvas({
  pbs-block((0, 0), label, content: [PBS])
})
#let pbs-inline(label) = box(
  baseline: 25%,
  scale(60%, reflow: true, pbs-example(label)),
)

#slide(title: "The Dream Scenario", repeat:2,  self => {
  let (uncover, only, alternatives) = utils.methods(self)
  set align(center+horizon)

  [
    #set text(size:2em)

    $ciphertextmath(y) = limits(sum)_(i=1)^n beta_i dot.op ciphertextmath(x_i) $
  ]


  alternatives[
    #propertybox("", [Only linear computation #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] #text(weight:"semibold", upper("No PBS Required !"))]
    )
  ][
    #questionbox([In this case, how would we compute the vector $beta$ from the definition of $f$?])
  ]
})



#slide(repeat:3, title: "This was linear algebra all along", self => {
  let (uncover, only, alternatives) = utils.methods(self)


  propertybox("",
    [We start from the truth table of $f$]
  )

  v(2em)


  uncover("2-")[
    #set grid(
      inset:0.4em,
      align:center,
      stroke:0.05em + self.colors.primary-dark,
    )

    #stack(
      dir:ltr,
      spacing: 20%,

      if self.subslide < 3 [
          #grid(
            columns:5,
            fill: (x, y) => if y==0{gray.lighten(40%)},

            grid.header(
              [$x_1$], [$x_2$], [$x_3$], [$x_4$], [$dots$]
            ),
            ..(0, 0, 0, 0, $dots$,
            1, 0, 0, 0, $dots$,
            0, 1, 0, 0, $dots$,
            $dots.v$, $dots.v$, $dots.v$, $dots.v$, $dots.down$).map(x => [#x])
          )
        ] else [
          #grid(
            columns:5,
            ..range(1, 5, inclusive: true).map(x => {
              range(1, 5, inclusive: true).map(y => {
                if x==5 and y==5{
                  [$dots.down$]
                }
                else if y == 5{
                  [$dots$]
                }
                else if x == 5{
                  [$dots.v$]
                }
                else{
                  [$x_(#y)^((#x))$]
                }
              })
            }).flatten()
          )
        ],

        if self.subslide < 3 [
          #grid(
            columns:1,
            fill: (x, y) => if y==0{gray.lighten(40%)},
            grid.header([$y$]),
            ..(1, 1, 0, $dots.v$).map(x => [#x])
          )
        ] else [
          #grid(
            columns:1,
            ..range(1, 5, inclusive: true).map(x => {
                if x == 5{
                  [$dots.v$]
                }
                else{
                  [$y^((#x))$]
                }
            }).flatten()
          )
        ]
      )
  ]
})

// Below: code to generate nice matrix and vectors automagically:

#let x-ij(i, j) = [$x_(#j)^((#i))$]


#let dots-version(x, y, xmax, ymax, symb-max-x, symb-max-y) = {
  let dots-x = xmax - 1
  let dots-y = ymax - 1
  let last-x = xmax
  let last-y = ymax

  if x == dots-x and y == dots-y {
    $dots.down$
  } else if x == dots-x {
    $dots.v$
  } else if y == dots-y {
    $dots$
  } else if x == last-x and y == last-y {
    x-ij(symb-max-x, symb-max-y)
  } else if y == last-y {
    x-ij(x, symb-max-y)
  } else if x == last-x {
    x-ij(symb-max-x, y)
  } else {
    x-ij(x, y)
  }
}

#let matrix(xmax, ymax, func: x-ij) = $mat(
  ..#range(1, xmax, inclusive:true).map(x =>
    range(1, ymax, inclusive:true).map(y => func(x, y))
  ),
)$

#let matrix-dots-version(
  xmax,
  ymax,
  symb-max-x: none,
  symb-max-y: none,
) = matrix(
  xmax,
  ymax,
  func: (x, y) => dots-version(
    x,
    y,
    xmax,
    ymax,
    symb-max-x,
    symb-max-y,
  ),
)



#let vec-symb(imax, symb) = math.vec(
  ..range(1, imax, inclusive:true).map(i => math.attach(symb, b: [$#i$])),
)

#let vec-symb-ciphertext(imax, symb) = math.vec(
  ..range(1, imax, inclusive:true).map(i => ciphertextmath(math.attach(symb, b: [$#i$]))),
)


#let vec-symb-with-dots(imax, symb, last-index) = math.vec(
  ..range(1, imax, inclusive:true).map(i => {
    if i == imax - 1 {
      $dots.v$
    } else if i == imax {
      math.attach(symb, b: last-index)
    } else {
      math.attach(symb, b: [$#i$])
    }
  }),
)

#let vec-symb-ciphertext-with-dots(imax, symb, last-index) = math.vec(
  ..range(1, imax, inclusive:true).map(i => {
    if i == imax - 1 {
      $dots.v$
    } else if i == imax {
      math.attach(symb, b: last-index)
    } else {
      math.attach(symb, b: [$#i$])
    }
  }),
)



#let sn = math.attach($s$, tr: $n$)

#let n-rows = 6
#let n-cols = 4

#let matrix-a = matrix-dots-version(
  n-rows,
  n-cols,
  symb-max-x: sn,
  symb-max-y: $n$,
)
#let vec-beta = vec-symb-with-dots(n-cols, $beta$, $n$)
#let vec-y = vec-symb-ciphertext-with-dots(n-rows, $y$, sn)






#slide(repeat:3, self => {

  set text(size:1em)

  set math.mat(gap:20pt)
  set math.vec(gap:20pt)

  let sized-matrix = cetz.canvas({
    import cetz.draw: *

    content((0, 0), matrix-a, name: "matrix")

    line(
      (rel: (0, 0.6), to: "matrix.north-west"),
      (rel: (0, 0.6), to: "matrix.north-east"),
      mark: (start: "<", end: ">"),
      stroke: 0.7pt,
    )
    content((rel: (0, 1), to: "matrix.north"), text(size: 0.9em, $n$))

    line(
      (rel: (-0.3, 0), to: "matrix.south-west"),
      (rel: (-0.3, 0), to: "matrix.north-west"),
      mark: (start: "<", end: ">"),
      stroke: 0.7pt,
    )
    content((rel: (-0.7, 0), to: "matrix.west"), text(size: 0.9em, $s^n$), angle: 90deg)
  })

  let beta-vector = if self.subslide >= 2 { plaintextmath(vec-beta) } else { vec-beta }
  $ #sized-matrix dot.op #beta-vector = #vec-y $

  let (uncover, only, alternatives) = utils.methods(self)

  alternatives[][
    #propertybox("", [$plaintextmath(beta)$ just need to be pre-computed from $f$ \ #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] Only cleartext computations!])
  ][
    #alertbox([Problem: in practice $n << s^n$. So the rank of the matrix is not sufficient to find a solution.])
  ]
})


#slide(repeat: 5, self=>{
  let (uncover, only, alternatives) = utils.methods(self)
  let reveal(step, body) = if self.subslide >= step { body } else { hide(body) }


  questionbox([How to extend the basis of variables? (i.e., increase the number of columns in the matrix)])

  reveal(2)[
    *First idea:* we sample random functions $phi_(n+1), dots, phi_(s^n)$.
  ]

  v(0.5em)
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


#slide(self=>{
  [
    *Second idea:* we use multiplication to use fewer randomness
  ]

  grid(
    columns: (auto, auto, auto),
    align: (right + horizon, left + horizon, center + horizon),
    column-gutter: (0.4em, 1em),
    row-gutter: 0.5em,
    $x_(n+1)$, $= phi_(n+1)(x_1, dots, x_n)$,pbs-example("pbs-first"),
    [], $dots.v$, $dots.v$,
    $x_(n+lambda)$, $= phi_(n+lambda)(x_1, dots, x_(n+lambda-1))$,
    pbs-example("pbs-last"),
  )

  $ f(ciphertextmath(bold(x))) =
    sum_(i=0)^(t-1)
      (sum_(j=0)^(L-1) beta_(i,j) dot.op ciphertextmath(x_j))
      ciphertextmath(dot.op)
      (sum_(k=0)^(L-1) d_(i,k) dot.op ciphertextmath(x_k))
    + sum_(j=0)^(L-1) beta_(t,j) dot.op ciphertextmath(x_j) $

  propertybox(
    "A ciphertext-ciphertext product takes two PBS:",
    [$ciphertextmath(dot.op)$ #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] #pbs-inline("pbs-last") $times 2$]
  )
})


#slide(self=>{

  [$ f(ciphertextmath(bold(x))) =
    sum_(i=0)^(t-1)
      (sum_(j=0)^(L-1) beta_(i,j) dot.op ciphertextmath(x_j))
      ciphertextmath(dot.op)
      (sum_(k=0)^(L-1) d_(i,k) dot.op ciphertextmath(x_k))
    + sum_(j=0)^(L-1) beta_(t,j) dot.op ciphertextmath(x_j) $]


  propertybox("Bounds on the parameters", [TODO])


  propertybox("Cost of evaluation of the decomposition", [TODO])



})
