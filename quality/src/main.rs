use std::fs;
use walkdir::WalkDir;
use regex::Regex;
use std::collections::HashSet;
use reqwest::blocking::Client;

fn main() {
    let current_dir = std::env::current_dir().unwrap();
    let parent_dir = current_dir.parent().unwrap();
    println!("\n[*] Parent directory: {:?}", parent_dir);

    // 1. Affiche le nombre de fichiers, les fichiers qui ne sont pas au format markdown, et les 5 plus vieux fichiers
    let mut files = vec![];
    let mut non_markdown_files = vec![];

    for entry in WalkDir::new(&parent_dir).min_depth(1).max_depth(3) {
        let entry = entry.unwrap();
        let path = entry.path();

        // Vérifier si le fichier est dans un dossier à ignorer
        let mut dojo101_file = true;
        for ancestor in path.ancestors() {
            let dir_name = ancestor.file_name().unwrap_or_default().to_str().unwrap();
            if dir_name == "quality" || dir_name.starts_with('.') {
                dojo101_file = false;
                break;
            }
        }

        if path.is_file() && dojo101_file {
            files.push(path.to_path_buf());
            if path.extension().unwrap_or_default() != "md" {
                non_markdown_files.push(path.to_path_buf());
            }
        }
    }
    
    println!("\n[*] Number of files with dojo-101 content : {}", files.len());
    println!("\n[*] Non-markdown files: {:?}", non_markdown_files);

    files.sort_by_key(|path| {
        fs::metadata(path).unwrap().modified().unwrap()
    });

    println!("\n[*] 5 oldest files: {:?}", &files[..5.min(files.len())]);

    // 2. Vérifie qu'il n'y a pas de dossier dans les sous dossiers
    for entry in WalkDir::new(&parent_dir).min_depth(1).max_depth(1) {
        let entry = entry.unwrap();
        let path = entry.path();
        if path.is_dir() {
            let dir_name = path.file_name().unwrap().to_str().unwrap();
            if path.file_name().unwrap() == "quality" || dir_name.starts_with('.') { continue; }
            for sub_entry in WalkDir::new(path).min_depth(2).max_depth(2) {
                let sub_entry = sub_entry.unwrap();
                if sub_entry.path().is_dir() {
                    println!("\n[!] Sub-Directory contains sub-directory: {:?}", sub_entry.path());
                }
            }
        }
    }

    // 3. Affiche la liste des URLs contenues dans les fichiers markdown (en supprimant les doublons)
    let url_regex = Regex::new(r"https?://[^\s\)`]+").unwrap();
    let mut urls = HashSet::new();

    for path in files.iter().filter(|p| p.extension().unwrap_or_default() == "md") {
        let content = fs::read_to_string(path).unwrap();
        for cap in url_regex.captures_iter(&content) {
            urls.insert(cap[0].to_string());
        }
    }

    //println!("\n[*] Unique URLs in markdown files: {:?}", urls);

    // Vérifie la validité des URLs

    let client = Client::new();
    for url in &urls {
        match client.head(url).send() {
            Ok(response) => {
                if response.status().is_success() {
                    //println!("\n[*] URL is valid: {}", url);
                } else {
                    println!("\n[!] URL is not valid: {} (status: {})", url, response.status());
                }
            }
            Err(err) => {
                println!("F\n[!] Failed to check URL: {} (error: {})", url, err);
            }
        }
    }

}
