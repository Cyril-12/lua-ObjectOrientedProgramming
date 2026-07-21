
# Lua Class

> A lightweight object-oriented library for Lua built with metatables.

<p align="center">
  <img alt="Lua" src="https://img.shields.io/badge/Lua-5.4+-2C2D72?logo=lua">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-green">
  <img alt="Status" src="https://img.shields.io/badge/Status-Stable-success">
</p>

---

## Overview

Lua Class provides a minimal object-oriented abstraction while remaining close to Lua's native semantics. Classes are ordinary tables, inheritance is implemented through metatables, and instances are created by calling the class directly.

---

## Installation

```lua
local class = require("class")
```

---

## Quick Example

```lua
local class = require("class")

local Person = class {
    __name__ = "Person"
}

function Person:init(name)
    self.name = name
end

function Person:greet()
    print("Hello, " .. self.name)
end

local person = Person("Alice")

person:greet()
```

---

## Inheritance

```lua
local Student = class {
    __name__ = "Student",
    __super__ = Person
}

function Student:init(name, grade)
    Person.init(self, name)
    self.grade = grade
end
```

---

## Architecture

```text
              Object
                │
        ┌──────┴───────┐
        │                │
     Person           AnotherClass
        │
     Student
```

Instance creation

```text
class { ... }
      │
      ▼
 Class Object
      │
      ▼
 Class(...)
      │
      ▼
 Instance
      │
      ▼
  init(...)
```

---

## Specifications

* Lua 5.4+
* Prototype-based inheritance
* Constructor support through `init`
* Runtime type inspection
* Shared methods
* Reflection utilities
* No global variables
* Single-file implementation

---

## Project Structure

```text
.
├── .gitignore
├── LICENSE
├── README.md
├── class.lua
```

---

## License

Released under the MIT License.
