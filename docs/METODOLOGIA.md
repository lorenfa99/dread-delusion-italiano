# Metodologia di traduzione e revisione

## Obiettivo

Il progetto è stato trattato come una localizzazione completa, non come una sostituzione automatica di stringhe. L’inglese originale è rimasto la fonte semantica primaria; glossario, nomi canonici, vincoli di registro e convenzioni interne sono stati mantenuti per tutto il corpus.

La lavorazione si è svolta in due fasi distinte:

- produzione e revisione iniziale nell’interfaccia Web con **GPT‑5.6‑sol, livello high**;
- QA conclusivo nell’ambiente Codex con **GPT‑5.6‑sol, livello xhigh**.

## 1. Preparazione del corpus

Prima della traduzione sono stati individuati i diversi tipi di contenuto: dialoghi, descrizioni di oggetti, libri, missioni, dati generali, finali e testi di interfaccia. Per ciascun tipo sono stati considerati struttura, campi traducibili, marcatori, separatori e parti tecniche da non modificare.

È stato costruito un glossario di riferimento per personaggi, titoli, classi, fazioni, luoghi, oggetti, abilità e termini ricorrenti. Sono state inoltre definite le convenzioni per il Voi allocutivo, il Tu dei testi di sistema, il genere maschile del giocatore e la resa dei registri individuali.

## 2. Fase Web: cinque traduzioni indipendenti

Con GPT‑5.6‑sol (high) sono state prodotte cinque versioni indipendenti dello stesso materiale. Ogni profilo aveva una priorità diversa:

1. equilibrio generale tra fedeltà e naturalezza;
2. precisione semantica e conservazione dei dettagli;
3. scorrevolezza e idiomaticità dell’italiano;
4. voce dei personaggi, tono e registro;
5. approccio conservativo e minima deviazione dal testo.

I file più lunghi sono stati suddivisi in blocchi controllati. A ogni ricomposizione sono stati verificati ordine, numero di righe, identificativi, separatori, marcatori e campi non traducibili.

## 3. Adjudication e revisioni

Le cinque proposte non sono state scelte per maggioranza. Ogni riga è stata confrontata con l’originale e ricomposta selezionando la soluzione meglio sostenuta dal contesto. Questa fase ha prodotto una versione ensemble, sottoposta a:

- secondo passaggio semantico;
- revisione R1 per errori, omissioni e incoerenze;
- revisione R2 indipendente per grammatica, naturalezza, voce e uniformità;
- ricomposizione e controllo tecnico conclusivo della fase Web.

## 4. Fase Codex: QA riga per riga

L’intera fase Codex è stata eseguita con GPT‑5.6‑sol (xhigh). Il corpus è stato nuovamente inventariato e ogni sorgente inglese è stata associata alla corrispondente versione italiana. Per ogni coppia sono stati registrati schema, codifica, terminazioni di riga, campi traducibili e grado di affidabilità dell’associazione.

Ogni campo traducibile è stato poi sottoposto a due letture separate:

1. confronto source-first per significato, referenti, intensità, incertezza, numeri, destinazioni, ripetizioni e tono;
2. lettura italiana per grammatica, accordi, Voi/Tu, genere del giocatore, fluidità, sintassi, idiomaticità e voce.

È stato seguito un criterio di modifica minima: una frase valida non è stata riscritta per semplice preferenza stilistica. Ogni correzione è stata prima esplicitata, poi applicata con strumenti deterministici e infine convalidata.

## 5. Controlli linguistici approfonditi

Sono stati riesaminati con particolare attenzione:

- descrizioni di oggetti e dati generali, inclusi referenti pronominali e nomi di classi;
- libri, filastrocche e testi lunghi, per ritmo e naturalezza;
- missioni e finali, per chiarezza e continuità;
- tutti i principali gruppi di dialogo, per voce, tono e correttezza;
- espressioni modellate troppo da vicino sull’inglese;
- termini ripetuti, nomi, titoli, fazioni, luoghi e terminologia dell’interfaccia;
- Voi/Tu, accordo maschile del giocatore e differenza tra status sociale, professione e appartenenza;
- marcatori di formattazione che nel gioco cambiano soltanto il colore, senza imporre calchi sintattici o posizioni innaturali dell’apostrofo.

Dopo i singoli file è stato eseguito un audit trasversale dell’intero corpus. Le modifiche di coerenza sono state applicate soltanto quando sostenute dall’inglese o dalle convenzioni vincolanti.

## 6. Validazione tecnica

I validatori non hanno generato traduzioni. Sono serviti esclusivamente a controllare e applicare decisioni linguistiche già esplicite.

Per ogni file sono stati verificati:

- numero e ordine delle righe;
- identificativi e separatori;
- campi opachi non traducibili;
- marcatori, segnaposto, token di controllo, numeri e percentuali;
- codifica, BOM, terminazioni di riga e newline finale;
- integrità dei file sorgente e dei riferimenti mediante SHA‑256.

Il `resources.assets` finale è stato ricostruito con i 20 testi e il nuovo atlante del font. Un verificatore indipendente ha riletto il file generato e quello installato: **21 controlli su 21 superati** in entrambi i casi.

## 7. Risultati del QA finale

- file associati e verificati: **20/20**;
- righe fisiche riesaminate: **12.041**;
- righe corrette: **1.106**;
- campi linguistici corretti: **962**;
- riparazioni strutturali documentate: **163**;
- problemi nei validatori finali: **0**.

`DebugDialogue` è stato sottoposto soltanto alla validazione strutturale, perché non è contenuto destinato al gioco normale. Gli altri 19 file hanno ricevuto il controllo linguistico completo.

## Trasparenza sugli strumenti

La prima fase ha usato ChatGPT Web; la seconda ha usato Codex. Non sono stati impiegati sistemi di traduzione automatica, servizi di traduzione esterni o API di LLM esterni. Gli script hanno gestito inventario, applicazione delle correzioni, struttura, rapporti e checksum: le decisioni linguistiche sono state prese durante la revisione contestuale.
