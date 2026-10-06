#import "../theme/touying/theme-crx.typ": slide
#import "../theme/inline-components.typ": pbs-inline, pbs-example
#import "../theme/boxes.typ": propertybox
#import "../theme/mannot/ciphertext.typ": ciphertextmath



#slide(self=>{
  [
    *Second idea:* we use multiplication to use fewer randomness:
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
