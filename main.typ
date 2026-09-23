#import "theme/config.typ": slides, slide
#import "theme/boxes.typ": questionbox, propertybox
#import "theme/title-slide.typ": title-slide
#import "theme/begin-section-slide.typ": begin-section
#import "theme/begin-subsection-slide.typ": begin-subsection



#show: slides

#let section-counter = counter("section")
#let subsection-counter = counter("subsection")
#let current-section = state("current-section", [])



#show heading.where(level: 1): section => [
  #section-counter.step()
  #subsection-counter.update(0)
  #current-section.update(section.body)
  #begin-section(
    number: context section-counter.display("1"),
    title: section.body,
  )
]


#show heading.where(level: 2): subsection => [
  #subsection-counter.step()
  #begin-subsection(
    number: context section-counter.display("1"),
    subnumber: context subsection-counter.display("1"),
    section-title: context current-section.get(),
    title: subsection.body,
  )
]



#title-slide(
  title: [Decomposition of Large Look-Up Tables for Fast Homomorphic Evaluation],
  subtitle: [],
  author: [Sonia Belaïd, *Nicolas Bon*, Matthieu Rivain],
  date: [October 14, 2026],
  venue: [CHES 2026, Antalya, Turkey],
)


= Introduction

== First Idea

#slide(include "slides/01_intro_demo/01_01_coucou.typ")

= Demo of boxes

#slide(include "slides/02_test_boxes/02_01_question.typ")
#slide(include "slides/02_test_boxes/02_02_remark.typ")

= Demo of cetz

#slide(include "slides/03_test_cetz/03_01_torus.typ")
