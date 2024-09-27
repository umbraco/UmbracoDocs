---
description: >-
  uMS distributes visitors randomly across the different variants of your A/B
  tests.
---

# A/B Test Distribution Algorithm

The default algorithm is based on randomness. When visitors visit the website or a specific page with an A/B test, they get randomly assigned a variant. That variant is stored alongside the visitor's cookie and the same A/B test variant is shown as long as that cookie exists.

Because the algorithm is based on randomness the visitors are not equally distributed between the variants and slight differences can occur.

In the test shown below, the variant distribution is not a perfect 33,333% like what you could expect with three variants.

![]()

In a later sprint (or if you're really in need of this) we will implement other A/B test algorithms, such as round-robin, as well.
