#import "@preview/mannot:0.4.0": core-mark
#import "../colors.typ": secondary, tertiary



// #let pat-ciphertext(color) = tiling(size: (10pt, 10pt), {
//   place(line(start: (0%, 0%), end: (0%, 100%), stroke:color+3pt))
// })


#let pat-linear(color) = gradient.linear(
  color.transparentize(70%),
  color.transparentize(50%),
  angle: 45deg
)

#let overlay-ciphertext(width, height, color, pattern, lock-size) = block(
  width: width,
  height: height,
  [
    #place(top + left)[
      #rect(
        width: 100%,
        height: 100%,
        fill: pattern,
        stroke: color+3pt,
        radius: 5pt
      )
    ]

    #place(
      bottom + right,
      dx: lock-size / 2,
      dy: lock-size / 2,
    )[
      #image(
        "../../assets/png/cadenas.png",
        width: lock-size,
      )
    ]
  ],
)


#let ciphertextmath(body, color: tertiary, lock-size: 17pt, outset: 6pt) = {
  let pat = pat-linear(color)

  let overlay(width, height, color) = overlay-ciphertext(width, height, color, pat, lock-size)

  let marked = core-mark(
    body,
    color: color,
    overlay: overlay,
    mark-outset: outset,
  )

  // Mannot's overlay does not contribute to the equation's layout width.
  h(outset + 1.5pt) + marked + h(outset + 1.5pt + lock-size / 2)
}





#let overlay-plaintext(width, height, color, pattern) = block(
  width: width,
  height: height,
  [
    #place(top + left)[
      #rect(
        width: 100%,
        height: 100%,
        fill: pattern,
        stroke: color+3pt,
        radius: 5pt
      )
    ]
  ],
)



#let plaintextmath(body, color: secondary, outset: 6pt) = {
  let pat = pat-linear(color)

  let overlay(width, height, color) = overlay-plaintext(width, height, color, pat)

  let marked = core-mark(
    body,
    color: color,
    overlay: overlay,
    mark-outset: outset,
  )

  h(outset + 1.5pt) + marked + h(outset + 1.5pt)
}
