#import "../../theme/touying/theme-crx.typ": slide
#import "@preview/touying:0.7.4": utils
#import "../../theme/boxes.typ": alertbox, propertybox



#slide(title:"Ring vs Field", repeat:3,  self => {
  let (uncover, only, alternatives) = utils.methods(self)

  alertbox(
    [We need to work in a *field* for Gauss elimination to work!]
  )

  uncover("2-")[
    #propertybox("Embedding",
      [We embed $ZZ_s$ into $FF_p$ (with $s lt.eq p)$]
    )
  ]

  uncover("3-")[
    #propertybox("",
      [This enable further optimizations, because the space of solutions for $beta$ increases.]
    )
  ]

})
