---
description: >-
  Umbraco Engage distributes visitors randomly across the different variants of
  your A/B tests.
---

# A/B Test Distribution Algorithm

The default algorithm is based on randomness. When visitors visit the website or a specific page with an A/B test, they get randomly assigned a variant. That variant is stored alongside the visitor's cookie and the same A/B test variant is shown as long as that cookie exists.

Because the algorithm is based on randomness the visitors are not equally distributed between the variants and slight differences can occur.

In the test shown below, the variant distribution is not a perfect 33,333% as you could expect with three variants.

![An A/B test with three variants where the distribution is not a perfect 33,333%.](<../../.gitbook/assets/engage-ab-test-33 (1).png>)
