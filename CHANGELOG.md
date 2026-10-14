# Changelog

## v1.0.1 — 14 ottobre 2026

### Compatibilità

- Ricostruito `resources.assets` a partire dalla build Steam **25907859**.
- Conservati tutti i dati della nuova build estranei alla traduzione: dei 1.832
  oggetti nell'asset, cambiano solo i 20 testi e l'atlante del font; gli altri
  1.811 payload restano identici.
- Reinserito il font personalizzato con gli accenti, mantenendo la mappa dei
  glifi e i riferimenti aggiornati del gioco.
- Adattati due dialoghi con indicazioni su telescopi e cartografi e due codici
  nei documenti del Regno Meccanico alle fonti della build corrente.

### Testi

- Ulteriore revisione di naturalezza, calchi, fedeltà, omissioni e referenti in
  dialoghi, descrizioni, missioni, libri, finali e interfaccia.
- Uniformati termini ricorrenti, nomi di oggetti e ruoli legati alla bonifica.
- Sistemati accordi e riferimenti personali senza attribuire un genere non
  sostenuto dall'inglese o anticipare rivelazioni narrative.
- Riparati 12 campi con marcatori sbilanciati e adattata la formattazione di un
  dialogo riscritto nella nuova fonte inglese.
- Rispetto ai TXT distribuiti con la v1.0.0: **363 righe e 364 campi modificati
  in 18 file**. Le revisioni ripetute dello stesso campo non sono contate due volte.
- Chiariti tutti i cinque casi precedentemente privi di fonte o con differenze
  di versione grazie all'inglese estratto dal gioco aggiornato.

### Strumenti e verifiche

- Normalizzate in UTF-8 le sole copie inserite nell'asset. Il TXT delle missioni
  conserva la propria codifica CP1252, ma il contenuto distribuito viene letto
  come lo stesso testo Unicode, senza corrompere gli accenti.
- Aggiornato lo script facoltativo di ricostruzione per usare lo stesso passaggio.
- Validazione strutturale: **20/20 file**. Rilettura di testi e font nell'asset:
  **21/21 controlli**. Test automatici: **12/12**.
- Aggiornati checksum, documentazione e rapporto di compatibilità.

La verifica di compatibilità è tecnica; non è stata eseguita una nuova sessione
di prova interattiva in gioco. Installazione invariata: sostituire `resources.assets`
dopo aver conservato una copia dell'originale.

## v1.0.0 — 17 luglio 2026

- Prima pubblicazione della traduzione italiana e dello script facoltativo di
  ricostruzione degli asset, per la build Steam **22682990**.
- Pubblicati i 20 TXT italiani e la documentazione della metodologia e del QA.
- Rifiniti successivamente i sottotitoli introduttivi, mantenendo la stessa versione.
