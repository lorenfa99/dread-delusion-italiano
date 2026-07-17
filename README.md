# Dread Delusion — Traduzione italiana

Traduzione italiana non ufficiale e completa di *Dread Delusion*.

[Scarica l’ultima versione](https://github.com/lorenfa99/dread-delusion-italiano/releases/latest)

## Installazione

1. Chiudi il gioco e scarica `resources.assets` dalla release.
2. Su Steam apri **Dread Delusion → Gestisci → Sfoglia i file locali**.
3. Entra in `windows_content\Dread Delusion_Data`.
4. Conserva una copia del `resources.assets` originale e sostituiscilo con quello scaricato.

Per rimuovere la traduzione, ripristina la copia originale oppure verifica l’integrità dei file da Steam. Un aggiornamento del gioco può sovrascrivere la mod.

La prima release è verificata sulla build Steam **22682990**.

## Metodo

- cinque traduzioni indipendenti con profili diversi, prodotte sul Web con **GPT‑5.6‑sol (high)**;
- confronto e fusione ragionata delle versioni, seguiti da due revisioni complete;
- controllo finale riga per riga in Codex con **GPT‑5.6‑sol (xhigh)**, sempre a partire dall’inglese;
- audit di naturalezza, calchi, terminologia e coerenza tra file, più validazione strutturale deterministica.

Il controllo finale ha coperto **20 file e 12.041 righe**. I dettagli sono in [Metodologia](docs/METODOLOGIA.md) e [Controlli qualità](docs/QA.md).

## Materiale facoltativo

La cartella `translations` contiene i testi italiani validati. La cartella `tools` contiene lo script per ricreare `resources.assets`: rileva Steam, mostra il percorso trovato e permette di selezionare manualmente un’altra installazione.

Il progetto è amatoriale e non affiliato agli autori o agli editori del gioco. È necessaria una copia regolarmente acquistata di *Dread Delusion*.
