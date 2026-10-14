# Dread Delusion — Traduzione italiana

Traduzione italiana completa e non ufficiale di *Dread Delusion*.

Versione corrente: **v1.0.1** — [novità e correzioni](CHANGELOG.md).

[Scarica l’ultima versione](https://github.com/lorenfa99/dread-delusion-italiano/releases/latest)

## Installazione

1. Chiudi il gioco e scarica `resources.assets` dalla release.
2. Su Steam apri **Dread Delusion → Gestisci → Sfoglia i file locali**.
3. Entra in `windows_content\Dread Delusion_Data`.
4. Conserva una copia del `resources.assets` originale e sostituiscilo con quello scaricato.

Per rimuovere la traduzione, ripristina la copia originale oppure verifica l’integrità dei file da Steam. Un aggiornamento del gioco può sovrascrivere la mod.

La v1.0.1 è ricostruita e validata tecnicamente sulla build Steam **25907859**.
La precedente v1.0.0, per la build **22682990**, rimane disponibile. Non usare
l'asset pronto di una release su una build diversa da quella indicata.

## Metodo

- cinque traduzioni indipendenti con profili diversi, prodotte sul Web con **GPT‑5.6‑sol (high)**;
- confronto e fusione ragionata delle versioni, seguiti da due revisioni complete;
- controllo finale riga per riga in Codex con **GPT‑5.6‑sol (xhigh)**, sempre a partire dall’inglese;
- audit di naturalezza, calchi, terminologia e coerenza tra file, più validazione strutturale deterministica.

Il controllo iniziale ha coperto **20 file e 12.041 righe**. La v1.0.1 include
ulteriori revisioni linguistiche e l'adattamento al gioco aggiornato. I dettagli
sono in [Metodologia](docs/METODOLOGIA.md) e [Controlli qualità](docs/QA.md).

## Materiale facoltativo

La cartella `translations` contiene i testi italiani validati. La cartella
`tools` contiene lo script per ricreare `resources.assets`: rileva Steam, mostra
il percorso trovato e permette di selezionare manualmente un'altra installazione.
Le copie inserite nell'asset sono preparate in UTF-8, per conservare gli accenti
anche nel diario. Questi strumenti servono solo a chi vuole modificare i testi:
per installare la traduzione basta scaricare l'asset pronto.

Il progetto è amatoriale e non affiliato agli autori o agli editori del gioco. È necessaria una copia regolarmente acquistata di *Dread Delusion*.
