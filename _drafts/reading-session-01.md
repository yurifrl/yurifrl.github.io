---
layout: post
title: Reading Session One
description: TODO description
---

## Posts
- [Monads for the Curious Programmer, Part 1](#anchor-01)
- [Refactoring Towards Functional Programming in JavaScript](#anchor-02)
- [Data denormalization is broken](#anchor-03)
- [Learning The Clean Architecture and Applying it While Doing BDD](#anchor-04)
- [Hexagonal architecture](#anchor-05)
- [Clean JavaScript: Using use-case interactors](#anchor-06)
## Videos
- [Greg Young - CQRS and Event Sourcing - Code on the Beach 2014](#anchor-07)
## Books
- [Domain-Drive Design](#anchor-08)
- [Redis in Action](#anchor-09)
- [Professor Frisby's Mostly Adequate Guide to Functional Programming](#anchor-10)


# [Monads for the Curious Programmer, Part 1](https://bartoszmilewski.com/2011/01/09/monads-for-the-curious-programmer-part-1/)<a id="anchor-01"></a>

# [Refactoring Towards Functional Programming in JavaScript](http://rebootjeff.github.io/blog/2015/06/14/refactoring-towards-functional-programming-in-javascript/)<a id="anchor-02"></a>

Jeff Lee's introduction sugests to start with functional programing whiout the
"Hard" stuff, he sugests to cutting down on anonymous functions,
subdivide functions into tiny functions, and using the simples functional
programing concepts, such as curry and composition.

Then He sugests some Code smells, like:
- Anonymous callbacks:
  I belive his point is that is hard to compose callbacks,
  they don't feet well with compositions, i try to swap callbacks for promises,
  because i fell that promises are more composable
- Suboptimal parameter order:
  That is a nice tip, because inverting the
  parameters in a way that config like parameters are placed in the begining,
  currying is made easyer
- Loops:
  He sugests to use the native map, reduce and filter over for loops
  i go further, i just force miself to use ramda ones
- Localized mutaion:
  Mutations are things to be avoided, i try to avoid then
  the best as i can i can work around that, by passing state, i think it work
  ok, i manage to even use libraries that use common object whith state
- Side-effects from functions:

# [Data denormalization is broken](https://hackernoon.com/data-denormalization-is-broken-7b697352f405)<a id="anchor-03"></a>

# [Learning The Clean Architecture and Applying it While Doing BDD](http://code-zest.blogspot.com.br/2015/09/learning-clean-architecture-and.html)<a id="anchor-04"></a>

# [Hexagonal architecture](http://alistair.cockburn.us/Hexagonal+architecture)<a id="anchor-05"></a>

# [Clean JavaScript: Using use-case interactors](https://medium.com/@dtinth/clean-javascript-using-use-case-interactors-f3a50c138154#.7bi4wdnf0)<a id="anchor-06"></a>

# [Greg Young - CQRS and Event Sourcing - Code on the Beach 2014](https://www.youtube.com/watch?v=JHGkaShoyNs)<a id="anchor-07"></a>

# [Domain-Drive Design](http://www.infoq.com/resource/minibooks/domain-driven-design-quickly/en/pdf/DomainDrivenDesignQuicklyOnline.pdf)<a id="anchor-08"></a>

# [Redis in Action](https://redislabs.com/ebook/redis-in-action/foreword)<a id="anchor-09"></a>

# [Professor Frisby's Mostly Adequate Guide to Functional Programming](https://drboolean.gitbooks.io/mostly-adequate-guide/content/)<a id="anchor-10"></a>

