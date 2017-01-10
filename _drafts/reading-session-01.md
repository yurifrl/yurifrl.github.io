---
layout: post
title: Reading Session One
description: TODO description
---

## Posts
- [Refactoring Towards Functional Programming in JavaScript](#anchor-01)
- [Data denormalization is broken](#anchor-02)
- [Learning The Clean Architecture and Applying it While Doing BDD](#anchor-03)
- [Hexagonal architecture](#anchor-04)
- [Clean JavaScript: Using use-case interactors](#anchor-05)

## Videos
- [Greg Young - CQRS and Event Sourcing - Code on the Beach 2014](#anchor-06)

## Books
- [Domain-Drive Design](#anchor-07)
- [Redis in Action](#anchor-08)
- [Professor Frisby's Mostly Adequate Guide to Functional Programming](#anchor-09)

# [Refactoring Towards Functional Programming in JavaScript](http://rebootjeff.github.io/blog/2015/06/14/refactoring-towards-functional-programming-in-javascript/)
<hr id="#anchor-01">

Jeff Lee's introduction sugests to start with functional programing whiout the
"Hard" stuff, he sugests to cutting down on anonymous functions,
subdivide functions into tiny functions, and using the simples functional
programing concepts, such as curry and composition.

Then He sugests some Code smells, like:
- Anonymous callbacks
    I belive he's point is that is hard to compose callbacks, they don't feet
    well with compositions, i try to swap callbacks for promises, because i
    fell that promises are more composable
- Suboptimal parameter order
    That is a nice tip, because inverting the parameters in a way that config
    like parameters are placed in the begining, currying is made easyer
- Loops
    He sugests to use the native map, reduce and filter over for loops
    i go further, i just force miself to use ramda ones
- Localized mutaion
    Mutations are things to be avoided, i try to avoid then the best as i can
    i can work around that, by passing state, i think it work ok, i manage to
    even use libraries that use common object whith state
- Side-effects from functions

# [Data denormalization is broken](https://hackernoon.com/data-denormalization-is-broken-7b697352f405)
<hr id="#anchor-02">

# [Learning The Clean Architecture and Applying it While Doing BDD](http://code-zest.blogspot.com.br/2015/09/learning-clean-architecture-and.html)
<hr id="#anchor-03">

# [Hexagonal architecture](http://alistair.cockburn.us/Hexagonal+architecture)
<hr id="#anchor-04">

# [Clean JavaScript: Using use-case interactors](https://medium.com/@dtinth/clean-javascript-using-use-case-interactors-f3a50c138154#.7bi4wdnf0)
<hr id="#anchor-05">

# [Greg Young - CQRS and Event Sourcing - Code on the Beach 2014](https://www.youtube.com/watch?v=JHGkaShoyNs)
<hr id="#anchor-06">

# [Domain-Drive Design](http://www.infoq.com/resource/minibooks/domain-driven-design-quickly/en/pdf/DomainDrivenDesignQuicklyOnline.pdf)
<hr id="#anchor-07">

# [Redis in Action](https://redislabs.com/ebook/redis-in-action/foreword)
<hr id="#anchor-08">

# [Professor Frisby's Mostly Adequate Guide to Functional Programming](https://drboolean.gitbooks.io/mostly-adequate-guide/content/)
<hr id="#anchor-09">

