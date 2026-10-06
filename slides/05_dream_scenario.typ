#import "../theme/touying/theme-crx.typ": slide
#import "../theme/mannot/ciphertext.typ": ciphertextmath
#import "../theme/boxes.typ": questionbox, propertybox
#import "@preview/touying:0.7.4": utils



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
    #questionbox([In this case, how would we compute $arrow(beta)$ from the definition of $f$?])
  ]
})
