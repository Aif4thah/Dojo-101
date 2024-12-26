## Rust (from C#)

compiler un fichier

```pwsh
rustc mon_programme.rs
```

## équivalent de dotnet

```pwsh
cargo [build|run]
```


## Variable assignement

C#

```csharp
var x = 5;
x = 6;
Console.WriteLine(x); // 6
```

RUST

```rust
let x = 5;
let x = 6; // x = 6 ne compilera pas
println!("{}", x); // 6
```

## Casting

C#

```csharp
double a = 1.2;
int b = (int)a;
```

RUST

```rust
let int_number: i32 = 1;
let long_number: i64 = int_number as _;
```

## Boucle et Conditions

C#

```csharp
using System;
using System.Text;

var values = new[] { 1, 2, 3, 4, 5 };
var output = new StringBuilder();

foreach (var value in values)
{
    if (output.Length > 0)
        output.Append(", ");
    output.Append(value);
}
Console.Write(output); // Prints: 1, 2, 3, 4, 5
```

RUST

```rust
use std::fmt::Write;

fn main() {
    let values = [1, 2, 3, 4, 5];
    let mut output = String::new();

    for value in values {
        if output.len() > 0 {
            output.push_str(", ");
        }
        // ! discard/ignore any write error
        _ = write!(output, "{value}");
    }

    println!("{output}");  // Prints: 1, 2, 3, 4, 5
}
```

## Structures (pas de classes en RUST)

C#

```csharp
struct Rectangle
{
    public Rectangle(int x1, int y1, int x2, int y2) =>
        (X1, Y1, X2, Y2) = (x1, y1, x2, y2);

    public int X1 { get; }
    public int Y1 { get; }
    public int X2 { get; }
    public int Y2 { get; }

    public int Length => Y2 - Y1;
    public int Width => X2 - X1;

    public (int, int) TopLeft => (X1, Y1);
    public (int, int) BottomRight => (X2, Y2);

    public int Area => Length * Width;
    public bool IsSquare => Width == Length;

    public override string ToString() => $"({X1}, {Y1}), ({X2}, {Y2})";
}
```

RUST

```rust
#![allow(dead_code)]

struct Rectangle {
    x1: i32, y1: i32,
    x2: i32, y2: i32,
}

impl Rectangle {
    pub fn new(x1: i32, y1: i32, x2: i32, y2: i32) -> Self {
        Self { x1, y1, x2, y2 }
    }

    pub fn x1(&self) -> i32 { self.x1 }
    pub fn y1(&self) -> i32 { self.y1 }
    pub fn x2(&self) -> i32 { self.x2 }
    pub fn y2(&self) -> i32 { self.y2 }

    pub fn length(&self) -> i32 {
        self.y2 - self.y1
    }

    pub fn width(&self)  -> i32 {
        self.x2 - self.x1
    }

    pub fn top_left(&self) -> (i32, i32) {
        (self.x1, self.y1)
    }

    pub fn bottom_right(&self) -> (i32, i32) {
        (self.x2, self.y2)
    }

    pub fn area(&self)  -> i32 {
        self.length() * self.width()
    }

    pub fn is_square(&self)  -> bool {
        self.width() == self.length()
    }
}

use std::fmt::*;

impl Display for Rectangle {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(f, "({}, {}), ({}, {})", self.x1, self.y2, self.x2, self.y2)
    }
}
```

## Lire les arguments

```rust
fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() > 1 {
        println!("Les arguments sont : {:?}", &args[1..]);
    } else {
        println!("Aucun argument n'a été passé au programme.");
    }
}
```


## ref

* [microsoft.github.io](https://microsoft.github.io/rust-for-dotnet-devs/latest/introduction.html)