#  Migration to v9

## Breaking changes

- `Route` is now a `struct` rather than an `enum`. You can represent `Route` values as a `String` rather than cases. `Route._10A -> "10A" or Route(id: "10A")`. 

That's it! While just about every internal method signature has changed, public APIs are unchanged.

