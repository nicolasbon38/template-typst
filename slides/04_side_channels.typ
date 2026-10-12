#import "../theme/touying/theme-crx.typ": slide
#import "@preview/touying:0.7.4": utils
#import "../theme/inline-components.typ": pbs-inline


#slide(repeat:2, self => {
  let (uncover, only, alternatives) = utils.methods(self)

  [ This question is already studied in the CHES community, but targeting different metrics.]

  v(2em)

  alternatives[An usual goal is to minimize the number of *AND* gates.][#strike([An usual goal is to minimize the number of *AND* gates.])]

  v(1em)

  uncover("2-")[Instead, we want to minimize the number of #pbs-inline("")!]

})
