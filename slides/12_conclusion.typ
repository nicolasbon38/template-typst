#import "../theme/touying/theme-crx.typ": slide
#import "@preview/touying:0.7.4": utils



#slide(title:"Conclusion", repeat:2, self => {
  let (uncover, only, alternatives) = utils.methods(self)

  [
    #set align(left)
    #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] Improvement of TFHE homomorphic function evaluation at medium to large precision \
    #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] Conceptually simple, only basic building blocks used
    \
    #text(font: "Noto Color Emoji")[#emoji.arrow.r.filled] The heavy pre-computation can be re-used on any LUT of same size.

    #v(2em)
    #uncover("2")[
      #set align(center)
      #text(size: 2em, weight:"bold")[Thank you!]
    ]


  ]
})
