# RUST basics et fonctions de sécurité

démo des fonctions de sécurité de RUST

## Ressources

* [RUST](https://www.rust-lang.org/)

* [Guide ANSSI](https://anssi-fr.github.io/rust-guide/)

* [Play rust (online)](https://play.rust-lang.org/)

## Compilation

```powershell
rustc.exe .\Rust-security.rs
```

## Toolchains

la version stable est recommandée

```powershell
rustup toolchain list
```

## Créer un projet avec dépendances

```powershell
cargo.exe new myproject
cargo add regex
```

Le code sera dans `main.rs`
Les versions des dépendances sont alors spécifié dans le fichier `Cargo.toml`, Cargo gère automatiquement le fichier `Cargo.lock`
Pour mettre à jour des dépendances : `cargo-update`


## Test & linter

[Clippy](https://github.com/rust-lang/rust-clippy)

Installé par défaut, si non `rustup component add clippy` (priviliger cette commande à `cargo` pour ne pas l'avoir en dépendance)

```
cargo clippy
```

## Test via CI/CD

### github actions

exemple avec Clippy et tests :

```yml
name: Rust

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

env:
  CARGO_TERM_COLOR: always
  RUSTFLAGS: "-Dwarnings"

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4
    - name: Run Clippy
      run: cargo clippy --all-targets --all-features
    - name: Build
      working-directory: ./quality
      run: cargo build --verbose
    - name: Run tests
      working-directory: ./quality
      run: cargo test --verbose
```

## Variables

```rust
let x = 5; // immuable
let mut y = 5; // la valeur pourra etre modifiée
let z = &x; // y est une référence à x, utilise la valeurs sans en prendre la possession
```

## lever une exception

```rust
panic!("crash and burn");
```


## Sécurité : Mémoire, Type, Threads

Démonstration des principales fonctions de sécurité :

```rust
use std::thread;
use std::sync::{Arc, Mutex};

fn main() {
    println!("1. Gestion de la mémoire sans garbage collector");
    memory_management();

    println!("2. Vérification de type au moment de la compilation");
    //type_checking(); leve une exception puisque le type de correspont pas, lorsque commenté un warning est levé à la compilation

    println!("3. Gestion des erreurs avec Result et Option");
    error_handling();

    println!("4. Absence de null");
    no_null();

    println!("5. Concurrency sans data races");
    concurrency();
}

// La gestion de la mémoire en Rust est effectuée sans garbage collector.
// Rust libère automatiquement la mémoire lorsque les variables sortent de la portée.
fn memory_management() {
    let _s = String::from("hello");  // Allocation de mémoire
}  // Ici, Rust libère automatiquement la mémoire


// Rust effectue une vérification de type stricte au moment de la compilation.
// Cette fonction échouera à la compilation car elle tente de parser une chaîne en entier.
fn type_checking() {
    let _x: i32 = "hello".parse().expect("Not an integer!"); //parse et converti la chaine dans le type addendu
}


// Rust encourage l'utilisation de Result et Option pour la gestion des erreurs.
// Ces types permettent de gérer explicitement les cas d'erreur et d'absence de valeur.
fn error_handling() {
    let _res: Result<i32, _> = "100".parse(); 
}


// Rust n'a pas de null, ce qui élimine une classe entière de bugs.
// Au lieu de cela, Rust utilise le type Option pour représenter une valeur qui peut être absente.
fn no_null() {
    let _opt: Option<i32> = "42".parse().ok();
}


fn concurrency() {
    // Rust permet la concurrence sans data races.
    // Cette fonction démontre comment créer un thread en Rust et attendre qu'il se termine.
    
    // Création d'un compteur qui sera partagé entre les threads.
    let counter = Arc::new(Mutex::new(0)); // Mutex assure qu'un seul thread peut modifier le compteur à la fois.
    let mut handles = vec![];

    // Création de 10 threads
    for _ in 0..10 {
        // Clonage du compteur pour chaque thread
        let counter = Arc::clone(&counter); // Arc permet à plusieurs threads de posséder le compteur.
        let handle = thread::spawn(move || {
            // Verrouillage du compteur pour modification
            let mut num = counter.lock().unwrap();

            // Incrémentation du compteur
            *num += 1;
            println!("Hi number {} from the spawned thread!", num);
        });
        // Ajout du handle du thread à la liste des handles
        handles.push(handle);
    }

    // Attente de la fin de tous les threads
    for handle in handles {
        handle.join().unwrap();
    }

    // Affichage du résultat final
    println!("Result: {}", *counter.lock().unwrap());
}
```
