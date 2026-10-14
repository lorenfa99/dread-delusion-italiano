# Controlli qualità

## v1.0.1 — build Steam 25907859

**PASS tecnico** sui 20 file di traduzione e sul nuovo `resources.assets`.

| Voce | Risultato |
| --- | ---: |
| TXT validati | 20/20 |
| Righe fisiche verificate | 12.041 |
| File modificati rispetto alla v1.0.0 | 18 |
| Righe / campi modificati rispetto alla v1.0.0 | 363 / 364 |
| Riparazioni di marcatori preesistenti | 12 |
| Adeguamenti dei marcatori a una nuova fonte | 1 |
| Errori finali dei validatori | 0 |
| Rilettura testi e font nell'asset | 21/21 |
| Oggetti dell'asset non modificati | 1.811/1.832 |
| Test del validatore / della preparazione UTF-8 | 7/7 + 5/5 |
| Questioni aperte della revisione precedente | 0 |

La nuova base è stata copiata dal gioco installato e verificata mediante SHA-256.
Sono stati estratti 43 TextAsset e riassociati tutti i 20 file traducibili.
Righe, chiavi, colonne tecniche e dati delle altre lingue coincidono con la build.
Il confronto di ogni oggetto del file ricostruito conferma che cambiano soltanto
i testi previsti e l'atlante del font. I metadati e il nuovo riferimento al font
di fallback restano quelli del gioco aggiornato.

I 20 payload distribuiti sono UTF-8 valido e corrispondono agli stessi testi
Unicode dei TXT. La normalizzazione riguarda le copie di staging: originali
inglesi, backup e codifica dei TXT non sono stati riscritti. Il gioco installato
è rimasto invariato.

SHA-256 del nuovo `resources.assets`:

`5FF7684DC3E648BEFB2772A9ADBB4BD1A8F9A76CA33EF5E4051FBBF05F4FCDAF`

Dettagli: [revisione di ottobre](REVISIONE_2026-10.md),
[rapporto tecnico della build](BUILD_25907859_QA.json) e [changelog](../CHANGELOG.md).
Questi controlli non equivalgono a una nuova prova interattiva in gioco o a una
garanzia di perfezione linguistica assoluta.

## Archivio: QA della lavorazione iniziale

**PASS** — tutti i file distribuiti superano i controlli applicabili.

| Voce | Risultato |
|---|---:|
| File verificati | 20/20 |
| Righe riesaminate | 12.041 |
| Righe corrette | 1.106 |
| Campi linguistici corretti | 962 |
| Riparazioni strutturali | 163 |
| Errori finali dei validatori | 0 |
| Controlli dentro `resources.assets` | 21/21 |

### Categorie di intervento iniziali

| Categoria | Interventi |
|---|---:|
| Naturalezza, calchi, espressioni idiomatiche, registro e voce | 404 |
| Grammatica, accordi, allocuzione e forme d’azione | 181 |
| Glossario, terminologia e coerenza | 155 |
| Significato, referenti e tono | 119 |
| Punteggiatura, marcatori, maiuscole e controlli | 103 |
| Struttura tecnica | 163 |

### Verifiche conclusive iniziali

- struttura, campi opachi, marcatori, numeri e segnaposto: PASS;
- codifica, BOM, newline e terminazioni di riga: PASS;
- glossario, nomi, titoli, fazioni, luoghi e terminologia UI: completato;
- Voi/Tu e accordo maschile del giocatore: completato;
- dialoghi ripetuti e termini ricorrenti: completato;
- audit generale dei calchi inglesi: completato;
- hash congelati degli input e dei riferimenti: invariati;
- ricostruzione e rilettura del `resources.assets`: PASS.

Il file attualmente conservato nella release v1.0.0, dopo la rifinitura dei
sottotitoli introduttivi, ha SHA-256:

`15C1E0BADD8B85FD0A73A2711E8B5F97BA44CCFC9F09C6E2F9BAAA9F1F16A281`
