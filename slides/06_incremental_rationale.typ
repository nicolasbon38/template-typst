#import "../theme/touying/theme-crx.typ": slide
#import "../theme/mannot/ciphertext.typ": ciphertextmath, plaintextmath
#import "../theme/boxes.typ": alertbox, propertybox
#import "@preview/touying:0.7.4": utils
#import "@preview/cetz:0.5.2"





#slide(repeat:2, title: "This was linear algebra all along", self => {
  let (uncover, only, alternatives) = utils.methods(self)

  v(2em)

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

        grid(
          columns:5,
          fill: (x, y) => if y==0{gray.lighten(40%)},

          grid.header(
            [$x_1$], [$x_2$], [$x_3$], [$x_4$], [$dots$]
          ),
          ..(0, 0, 0, 0, $dots$,
          1, 0, 0, 0, $dots$,
          0, 1, 0, 0, $dots$,
          $dots.v$, $dots.v$, $dots.v$, $dots.v$, $dots.down$).map(x => [#x])
        ),
        grid(
          columns:1,
          fill: (x, y) => if y==0{gray.lighten(40%)},
          grid.header([$y$]),
          ..(1, 1, 0, $dots.v$).map(x => [#x])
        )
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

#let matrix-with-extension(
  xmax,
  ymax,
  func: x-ij,
  ymax-extension,
) = $mat(
  ..#range(1, xmax, inclusive:true).map(x => {
    let extension = if x == xmax - 1 {
      ($dots.v$, $dots.down$, $dots.v$)
    } else {
      let row = if x == xmax { $s^n$ } else { x }
      (x-ij(row, $n+1$), $dots$, x-ij(row, ymax-extension))
    }
    range(1, ymax, inclusive:true).map(y => func(x, y)) + extension
  }),
  augment: ymax,
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


#let matrix-dots-version-with-extension(
  xmax,
  ymax,
  symb-max-x: none,
  symb-max-y: none,
) = matrix-with-extension(
  xmax,
  ymax,
  symb-max-y,
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


#let matrix-a-extended = matrix-dots-version-with-extension(
  n-rows,
  n-cols,
  symb-max-x: sn,
  symb-max-y: sn,
)


#let vec-beta = vec-symb-with-dots(n-cols, $beta$, $n$)
#let vec-y = vec-symb-ciphertext-with-dots(n-rows, $y$, sn)






#slide(repeat:4, title: "This was linear algebra all along",  self => {

  set text(size:1em)

  set math.mat(gap:10pt)
  set math.vec(gap:10pt)

  v(2em)

  let sized-matrix = cetz.canvas({
    import cetz.draw: content, line
    content((0, 0), matrix-a, name: "matrix")

    line(
      (rel: (0, -0.6), to: "matrix.south-west"),
      (rel: (0, -0.6), to: "matrix.south-east"),
      mark: (start: ">", end: ">"),
      stroke: 0.7pt,
    )
    content((rel: (0, -0.2), to: "matrix.south"), text(size: 0.9em, fill:black, $n$))

    line(
      (rel: (-0.3, 0), to: "matrix.south-west"),
      (rel: (-0.3, 0), to: "matrix.north-west"),
      mark: (start: ">", end: ">"),
      stroke: 0.7pt,
    )
    content((rel: (-0.7, 0), to: "matrix.west"), text(size: 0.9em, fill:black, $s^n$), angle: 90deg)
  })

  let beta-vector = if self.subslide >= 2 { plaintextmath(vec-beta) } else { vec-beta }

  let sized-matrix-with-extension = cetz.canvas({
    import cetz.draw: content, line
    content((0, 0), matrix-a-extended, name: "matrix")

    line(
      (rel: (0, -0.6), to: "matrix.south-west"),
      (rel: (0, -0.6), to: "matrix.south-east"),
      mark: (start: ">", end: ">"),
      stroke: 0.7pt,
    )
    content((rel: (0, -0.2), to: "matrix.south"), text(size: 0.9em, fill:black, $s^n$))

    line(
      (rel: (-0.3, 0), to: "matrix.south-west"),
      (rel: (-0.3, 0), to: "matrix.north-west"),
      mark: (start: ">", end: ">"),
      stroke: 0.7pt,
    )
    content((rel: (-0.7, 0), to: "matrix.west"), text(size: 0.9em, fill:black, $s^n$), angle: 90deg)
  })

  let displayed-matrix = if self.subslide == 4 {
    sized-matrix-with-extension
  } else {
    sized-matrix
  }
  $ #displayed-matrix dot.op #beta-vector = #vec-y $

  let (uncover, only, alternatives) = utils.methods(self)

  alternatives[][
    #propertybox("", [$plaintextmath(beta)$ is pre-computed from $f$ with *Gaussian elimination*. \ #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] The inverted matrix can be re-used for *any* $f$ of same size])
  ][
    #alertbox([Problem: in practice $n << s^n$. So the rank of the matrix is not sufficient to find a solution.])
  ][
    #propertybox("The solution", [#text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] We extend the matrix with synthetic variables!])
  ]
})
