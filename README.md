# Analisi di un sistema bancario con MySql

Lo scopo del progetto è creare una tabella denormalizzata usando MySql che contenga indicatori comportamentali sul cliente, calcolati sulla base delle transazioni e del possesso prodotti. L'obiettivo è creare le feature per un possibile modello di machine learning supervisionato.

## Descrizione allegati:

1.**db_bancario.sql**: codice MySql per creare le tabelle per accedere alle informazioni della banca. Tabelle e relative variabili:
- *cliente*: id_cliente, nome, cognome, data_nascita
- *conto*: id_conto, id_cliente, id_tipo_conto
- *transazioni*: data, id_tipo_trans, importo, id_conto
- *tipo_transazione*: id_tipo_transazione, dec_tipo_trans, segno
- *tipo_conto*: id_tipo_conto, desc_tipo_conto

2.**analisi_sistema_bancario.sql**: file MySql che contiene le analisi svolte.

## Descrizione analisi

Combinando le diverse tabelle all'interno del database 'db_bancario', ho generato ulteriori tabelle che saranno utilizzate per costruire la tabella denormalizzata finale. In particolare:

-*eta*: eta del cliente
-*tab_trans_uscita*: numero di transazioni in uscita su tutti i conti
-*tab_trans_entrata*: numero di transazioni in entrata su tutti i conti
-*imp_trans_uscita*: importo transato in uscita su tutti i conti
-*imp_trans_entrata*: importo transato in entrata su tutti i conti
-*num_tot_conti*: numero totale di conti posseduti
-*tipo_conti*: numero di conti posseduti per tipologia
-*num_trans_exit*: numero di transazioni in uscita per tipologia
-*num_trans_entrata*: numero di transazioni in entrata per tipologia
-*imp_uscita*: importo transato in uscita per tipologia di conto
-*imp_entrata*: importo transato in  entrata per tipologia di conto

## Requisiti e utilizzo
- MySql Workbench installato
- db_bancario.sql

## Contatti 
Per domande, suggerimenti o feedback, contattatemi pure alla mail alessiaagostini53@gmail.com.
