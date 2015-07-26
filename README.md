# Easy graphs in markdown

I've had an idea on how to create Extensible graphs in markdown witha  very simplistic formatting language

Suggestions for improvements are welcome.

There's no working prototype yet. This is sort of an RFC. I'll start the prototype as soon as I actually have some spare time.

If the prototype is successful, and if it is as nice to use as I imagine it I'll write some sort of proper specification for the language, so that ayone can use it (if they like).

## General Idea

The graph extension specifies two sets of Elements. Edges and vertices (surprise). A graph is defined by a set of vertices with an identifier that can be connected using any number of edges with optional arrows.


## The language

### Vertices

Vertices are made of two components. Identifier and content. Where in theory content can be anything markdown can parse (might just look bad though). Whether this is actually possible depends on the program used to render the graph.

The proposed syntax is as follows:

```
[identifier]: single line content
```

or

```
[identifier]:
    multi
    line
    content
```

I haven't decided yet whether I want to require the identifier to start with a specific character do distinguish it. If anyone has some good pros and cons for that, or an idea of what that character should be, I'd be happy to hear it.

### Edges

Edges are defined as the connection between two vertices and written as such:

```
identifier_1 [edge_specifier] identifier_2
```

This may unfortunately require some special syntax to mark the lines that are edge specs. I'll know more once I try to write a prototype.

Each edge specification has to be on a new line (for readability).

**edge_specifier**s can be any number of (optionally space separated):

- **-** edge with no head
- **<-** edge with head towards identifier_1
- **->** edge with head towards identifier_2
- **<->** edge with head towards both identifiers

Example:

#### 1
```
a <- b
```

An edge from vertex a to vertex b, pointing to a

#### 2
```
a - b
```

An edge from vertex a to b pointing at neither

#### 3
```
a <--> b
```
or equivalent
```
a <- -> b
```

Two edges from a to b one pointing to a, one pointing to b.

#### 4
```
a -><-<-> b
```
or
```
a -> <- <-> b
```
or
```
a -> b
a <- b
a <-> b
```

Three edges from a to b, one pointing at a, one pointing at b, one pointing at both.

## Layout

The layout of the graph would be decided by the software used to render the graph, which in theory would be configurabe, if the input format for said program is known.