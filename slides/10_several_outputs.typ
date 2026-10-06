#import "../theme/touying/theme-crx.typ": slide
#import "@preview/touying:0.7.4": utils
#import "../theme/boxes.typ": propertybox


#slide(title:"Generalization to several outputs", repeat:2,  self =>{
  let (uncover, only, alternatives) = utils.methods(self)

  propertybox("Naive method", [Each output can be processed independently])


  uncover("2-")[
    #propertybox("A better idea", [Output $n+1$ can re-use the basis of Output $n$, thus reducing the number of *PBS* at each step.])
  ]
})
