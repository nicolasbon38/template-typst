#import "../theme/touying/theme-crx.typ": slide
#import "@preview/touying:0.7.4": utils



#slide(repeat:2, self => {
  let (uncover, only, alternatives) = utils.methods(self)

  [ This question has already been studied by the SCA community to compile *masked implementations*. \ ]

  v(2em)

  uncover("2-")[Previous works focused on minimizing the number of *AND* gates. \

    Instead, we want to minimize the number of *PBS*!]

})
