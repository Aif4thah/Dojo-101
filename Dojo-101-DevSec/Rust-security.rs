// démo des fonctions de sécurité de RUST
// Compilation : rustc.exe .\Rust-security.rs
// author: @Taisen-Solutions

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
    let _x: i32 = "hello".parse().expect("Not an integer!"); //parse converti la chaine dans le type addendu
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