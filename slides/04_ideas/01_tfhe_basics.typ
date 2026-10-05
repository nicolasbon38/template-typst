#import "../../theme/touying/theme-crx.typ": slide
#import "@preview/cetz:0.5.2"
#import cetz.draw: line, set-style
#import "../../theme/circuits/gates.typ": add-block, clearmult-block, pbs-block, connect
#import "../../theme/circuits/ciphertexts.typ": ciphertext-block, plaintext-block

#slide(title: [TFHE: the building blocks], self => {
  set align(center + horizon)


  let sum-demo-circuit = cetz.canvas({
    import cetz.draw: *

    let block-step = 4

    ciphertext-block((0, 2), "c1", $m_1$)
    ciphertext-block((0, 0), "c2", $m_2$)
    add-block((block-step, 1), "add")
    ciphertext-block((2 * block-step, 1), "c3", $m_1 + m_2$)

    connect((
      ("c1", "add"),
      ("c2", "add"),
      ("add", "c3"),
    ))
  })

  let clear-mult-demo-circuit = cetz.canvas({
    import cetz.draw: *

    let block-step = 4

    ciphertext-block((0, 2), "c1", $m$)
    plaintext-block((0, 0), "lambda", $lambda$)
    clearmult-block((block-step, 1), "clearmult")
    ciphertext-block((2 * block-step, 1), "c3", $lambda dot m$)

    connect((
      ("c1", "clearmult"),
      ("lambda", "clearmult"),
      ("clearmult", "c3"),
    ))
  })


  let pbs-demo-circuit = cetz.canvas({
    import cetz.draw: *

    let block-step = 4

    ciphertext-block((0, 0), "c1", $m$)
    pbs-block((block-step, 0), "pbs")
    ciphertext-block((2 * block-step, 0), "c3", $f(m)$)

    connect((
      ("c1", "pbs"),
      ("pbs", "c3"),
    ))
  })



  let sum = figure(
    sum-demo-circuit
  )

  let clear-mult = figure(
    clear-mult-demo-circuit
  )

  let pbs = figure(
    pbs-demo-circuit
  )


  let linear-op-summary = [
    #set text(size:1.3em)
    Speed #emoji.car.racing ,  Noise #text(font: "Noto Color Emoji")[#emoji.arrow.tr#"\u{fe0f}"]
  ]
  let pbs-summary = [
    #set text(size:1.3em)
    Speed  #emoji.snail ,  Noise #text(font: "Noto Color Emoji")[#emoji.arrow.br#"\u{fe0f}"]
  ]


  columns(2, gutter:20pt)[
    #stack(
      v(1fr),
      sum,
      v(1fr),
      clear-mult,
      v(1fr),
      linear-op-summary,
      v(1fr),
      dir: ttb,
      spacing: none,
    )

    #colbreak()

    #stack(
      v(1fr),
      pbs,
      v(1fr),
      pbs-summary,
      v(1fr),
    )
  ]

})
