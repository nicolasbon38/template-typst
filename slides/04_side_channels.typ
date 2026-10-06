#import "../theme/touying/theme-crx.typ": slide
#import "@preview/touying:0.7.4": utils
#import "../theme/inline-components.typ": pbs-inline


#slide(repeat:2, self => {
  let (uncover, only, alternatives) = utils.methods(self)

  [ This question has already been studied by the SCA community to compile *masked implementations*.]

  v(2em)

  alternatives[Previous works focused on minimizing the number of *AND* gates][#strike([Previous works focused on minimizing the number of *AND* gates])]

  v(1em)

  uncover("2-")[Instead, we want to minimize the number of #pbs-inline("")!]

})
