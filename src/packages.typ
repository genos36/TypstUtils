// Dipendenze esterne dal Typst Universe.
// Le versioni si cambiano solo qui; il resto del package importa da questo
// file, così non possono esserci due versioni diverse dello stesso package.
//
// Si importano solo i package effettivamente usati: ogni import viene
// scaricato e valutato anche se nessuna funzione lo usa.

#import "@preview/codly:1.3.0" as codly-lib
#import "@preview/codly-languages:0.1.10" as codly-languages-lib