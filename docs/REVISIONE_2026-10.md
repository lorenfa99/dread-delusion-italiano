# Revisione di ottobre 2026

La v1.0.1 incorpora le revisioni linguistiche successive alla prima pubblicazione
e l'adattamento alla build Steam 25907859. Rispetto ai TXT della v1.0.0 sono
modificate 363 righe e 364 campi in 18 file. Il registro conserva 439 operazioni:
alcuni campi sono stati rivisti più volte e alcune scelte sono state ripristinate
dopo il confronto con la fonte aggiornata.

| File | Righe | Campi |
| --- | ---: | ---: |
| AcademyDialogue | 6 | 6 |
| ArtifactQuestDialogue | 0 | 0 |
| DebugDialogue | 0 | 0 |
| Dialogue_CharacterQuests | 8 | 8 |
| Dialogue_Clockwork | 131 | 131 |
| Dialogue_Endless | 50 | 50 |
| Dialogue_Endless_Mines | 4 | 4 |
| Dialogue_GameEndings | 12 | 12 |
| Dialogue_GodHunt | 6 | 6 |
| Dialogue_HighConfessor | 8 | 8 |
| Dialogue_Isles | 6 | 6 |
| Dialogue_MainQuest | 24 | 24 |
| Dialogue_Pwyll | 10 | 10 |
| FactionDialogue | 4 | 4 |
| HallowQuestDialogue | 9 | 9 |
| bookData | 6 | 6 |
| delusionItemText | 16 | 17 |
| delusionTasks | 44 | 44 |
| generalData | 17 | 17 |
| shopsHallowDialogue | 2 | 2 |
| Totale | 363 | 364 |

## Criteri

Le proposte sono state confrontate con l'inglese e con il contesto, evitando
riscritture meramente ornamentali. Sono stati verificati referenti, informazioni
implicite, titoli, nomi, registri, Voi/Tu, termini ricorrenti e prosa lunga.
Non si applicano equivalenze universali a parole che richiedono una resa diversa
secondo la scena; i riferimenti personali non devono inventare un genere né
anticipare rivelazioni narrative.

Il controllo successivo delle correzioni non viene presentato come una nuova
lettura indipendente di ogni campo rimasto invariato. Le coperture linguistiche
e il giudizio di naturalezza non sono dimostrabili mediante soli hash o conteggi.

## Nuova fonte e compatibilità

Estratti 43 TextAsset dal gioco installato. I 20 file italiani coincidono con
le chiavi, le righe, gli schemi e le colonne non traducibili della build corrente.
Il confronto con gli inglesi precedentemente forniti distingue spazi, refusi,
Unicode, marcatori e modifiche effettive delle indicazioni di gioco.

Le fonti della build chiariscono tutti i cinque casi rimasti aperti: sottotitoli
INTRO_SUB1–38, altre 89 chiavi di interfaccia, righe di debug e relativi campi,
istruzioni del controller e due valori tecnici delle task. Non occorre inventare
o cancellare dati per allineare i file.

Nel file ricostruito cambiano soltanto i 20 testi e l'atlante personalizzato.
I metadati del font e il suo riferimento aggiornato sono conservati; tutti gli
altri 1.811 oggetti sono identici al nuovo originale. Le copie di staging UTF-8
mantengono lo stesso testo Unicode e i terminatori dei TXT.

## Verifiche

- Validatori strutturali: 20/20, zero errori.
- Rilettura testi e font: 21/21.
- Bilanciamento dei marcatori e ricostruzione cronologica delle correzioni: PASS.
- Test del validatore: 7/7. Test della preparazione UTF-8: 5/5.
- Fonti, backup e originale del gioco installato: invariati.
- Questioni aperte della revisione precedente: zero.

I controlli sono tecnici e contestuali; non è stata svolta una nuova prova
interattiva in gioco e non viene dichiarata una perfezione linguistica assoluta.
Gli script non invocano servizi di traduzione automatica o API LLM esterne.

Il [rapporto tecnico](BUILD_25907859_QA.json) contiene identificativi, conteggi
e hash dei payload verificati, senza pubblicare gli originali inglesi o i backup.
