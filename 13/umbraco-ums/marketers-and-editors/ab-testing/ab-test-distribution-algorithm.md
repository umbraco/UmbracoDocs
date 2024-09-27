# A/B Test Distribution Algorithm

The default implemented algorithm is based on randomness. As soon as a visitor visits the website or the specific webpage with an A/B test they get randomly assigned a variant. That variant is stored alongside the visitors cookie and as long as the cookie exists the same A/B test variant is shown.

Because the algorithm is based on randomness the number of visitors are not equally distributed amongst all visitors and slight difference can occur.

In the test shown below, the variant distribution is not a perfect 33,333% like what you could expect with three variants.

![]()

In a later sprint (or if you're really in need of this) we will implement other A/B test algorithms, such as round-robin, as well.
