/*
	Età
*/

create temporary table age as
select  id_cliente, nome, cognome, data_nascita,
timestampdiff(year, data_nascita, curdate()) as eta 
from cliente;

select * from age;

/*
	Numero di transazioni in uscita (dal 3 al 7) su tutti i conti
*/


create temporary table tab_trans_uscita as 
select 
	c.id_cliente,
    count(t.id_conto) as num_trans_uscita
from cliente c 
join conto co on c.id_cliente = co.id_cliente
join transazioni t on co.id_conto = t.id_conto 
join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
where tt.id_tipo_transazione between 3 and 7
group by c.id_cliente
order by c.id_cliente ASC;

select * from tab_trans_uscita; 

/*
	Numero di transazioni in entrata su tutti i conti
*/

create temporary table tab_trans_entrata as 
select 
	c.id_cliente,
    count(t.id_conto) as num_trans_entrata
from cliente c 
join conto co on c.id_cliente = co.id_cliente
join transazioni t on co.id_conto = t.id_conto 
join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
where tt.id_tipo_transazione between 0 and 2
group by c.id_cliente
order by c.id_cliente ASC;

select * from tab_trans_entrata;

/*
	Importo transato in uscita su tutti i conti
*/

create temporary table imp_trans_uscita as
select 
	c.id_cliente,
	sum(t.importo) as imp_uscita
from cliente c 
join conto co on c.id_cliente = co.id_cliente
join transazioni t on co.id_conto = t.id_conto
join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
where t.id_tipo_trans between 3 and 7
group by c.id_cliente
order by c.id_cliente ASC;

select * from imp_trans_uscita;

/*
	Importo transato in entrata su tutti i conti
*/

create temporary table imp_trans_entrata as
select 
	c.id_cliente,
	sum(t.importo) as imp_entrata
from cliente c 
join conto co on c.id_cliente = co.id_cliente
join transazioni t on co.id_conto = t.id_conto
join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
where t.id_tipo_trans between 0 and 2
group by c.id_cliente;

select * from imp_trans_entrata;

/* 
	Numero totale di conti posseduti
*/

create temporary table num_tot_conti as
select 
	c.id_cliente, 
	count(co.id_conto) as num_conti
from cliente c 
left join conto co on c.id_cliente = co.id_cliente
group by c.id_cliente;

select * from num_tot_conti;

/* 
	Numero di conti posseduti per tipologia (un indicatore per tipo)
*/

create temporary table tipo_conti as
select 
	c.id_cliente,
    sum(case when tc.desc_tipo_conto = 'Conto Base' then 1 else 0 end) as conto_base,
    sum(case when tc.desc_tipo_conto = 'Conto Business' then 1 else 0 end) as conto_business,
    sum(case when tc.desc_tipo_conto = 'Conto Privati' then 1 else 0 end) as conto_privati,
    sum(case when tc.desc_tipo_conto = 'Conto Famiglie' then 1 else 0 end) as conto_famiglie
from cliente c
left join conto co on c.id_cliente = co.id_cliente
left join tipo_conto tc on co.id_tipo_conto = tc.id_tipo_conto
group by c.id_cliente;

select * from tipo_conti;

/* 
	Numero di transazioni in uscita per tipologia (un indicatore per tipo)
*/

create temporary table num_trans_exit as
select 
	c.id_cliente,
    sum(case when tt.desc_tipo_trans = 'Acquisto su Amazon' then 1 else 0 end) as amazon,
    sum(case when tt.desc_tipo_trans = 'Rata mutuo' then 1 else 0 end) as rata_mutuo,
    sum(case when tt.desc_tipo_trans = 'Hotel' then 1 else 0 end) as hotel,
    sum(case when tt.desc_tipo_trans = 'Biglietto aereo' then 1 else 0 end) as biglietto_aereo,
    sum(case when tt.desc_tipo_trans = 'Supermercato' then 1 else 0 end) as supermercato
from cliente c 
left join conto co on c.id_cliente = co.id_cliente
left join transazioni t on co.id_conto = t.id_conto
left join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
group by c.id_cliente;

select * from num_trans_exit;

/*
	Numero di transazioni in entrata per tipologia (un indicatore per tipo)
*/

create temporary table num_trans_entrata as 
select
	c.id_cliente,
    sum(case when tt.desc_tipo_trans = 'Stipendio' then 1 else 0 end) as stipendio,
    sum(case when tt.desc_tipo_trans = 'Dividendi' then 1 else 0 end) as dividendi,
    sum(case when tt.desc_tipo_trans = 'Pensione' then 1 else 0 end) as pensione
from cliente c 
left join conto co on c.id_cliente = co.id_cliente
left join transazioni t on co.id_conto = t.id_conto
left join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
group by c.id_cliente;

select * from num_trans_entrata;

/*
	Importo transato in uscita per tipologia di conto (un indicatore per tipo)
*/


create temporary table imp_uscita as 
select 
	c.id_cliente,
     sum(case when tc.desc_tipo_conto = 'Conto Base' then t.importo else 0 end) as imp_conto_base,
    sum(case when tc.desc_tipo_conto = 'Conto Business' then t.importo else 0 end) as imp_conto_business,
    sum(case when tc.desc_tipo_conto = 'Conto Privati' then t.importo else 0 end) as imp_conto_privati,
    sum(case when tc.desc_tipo_conto = 'Conto Famiglie' then t.importo else 0 end) as imp_conto_famiglie
from cliente c 
left join conto co on c.id_cliente = co.id_cliente
left join transazioni t on co.id_conto = t.id_conto
left join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
left join tipo_conto tc on co.id_tipo_conto = tc.id_tipo_conto
where tt.segno = '-'
group by c.id_cliente
order by c.id_cliente ASC;

select * from imp_uscita;

/*
	Importo transato in entrata per tipologia di conto (un indicatore per tipo)
*/

create temporary table imp_entrata as 
select 
	c.id_cliente,
	sum(case when tc.desc_tipo_conto = 'Conto Base' then t.importo else 0 end) as imp_conto_base,
    sum(case when tc.desc_tipo_conto = 'Conto Business' then t.importo else 0 end) as imp_conto_business,
    sum(case when tc.desc_tipo_conto = 'Conto Privati' then t.importo else 0 end) as imp_conto_privati,
    sum(case when tc.desc_tipo_conto = 'Conto Famiglie' then t.importo else 0 end) as imp_conto_famiglie
from cliente c 
left join conto co on c.id_cliente = co.id_cliente
left join transazioni t on co.id_conto = t.id_conto
left join tipo_transazione tt on t.id_tipo_trans = tt.id_tipo_transazione
left join tipo_conto tc on co.id_tipo_conto = tc.id_tipo_conto
where tt.segno = '+'
group by c.id_cliente
order by c.id_cliente ASC;

select * from imp_entrata;





/*
	TABELLA DENORMALIZZATA 
*/

create temporary table tabella as 
select
	c.id_cliente as cliente_id,
    c.nome as nome,
    c.cognome as congnome,
    c.data_nascita as data_nascita,
    a.eta as eta,
    ttu.num_trans_uscita as num_trans_uscita,
    tte.num_trans_entrata as num_trans_entrata,
    itu.imp_uscita as imp_uscite,
    ite.imp_entrata as imp_entrata,
    ntc.num_conti as num_conti,
    tc.conto_base as conto_base,
    tc.conto_business as conto_business,
    tc.conto_privati as conto_privati,
    tc.conto_famiglie as conto_famiglie,
    ntu.Amazon as amazon,
    ntu.Rata_mutuo as rata_mutuo,
    ntu.Hotel as hotel,
    ntu.biglietto_aereo as biglietto_aereo,
    ntu.supermercato as supermercato,
    nte.stipendio as stipendio,
    nte.dividendi as dividendi,
    nte.pensione as pensione,
    iu.imp_conto_base as imp_usc_conto_base,
    iu.imp_conto_business as imp_usc_conto_business,
    iu.imp_conto_privati as imp_usc_conto_privati,
    iu.imp_conto_famiglie as imp_usc_conto_famiglie,
	ie.imp_conto_base as imp_ent_conto_base,
    ie.imp_conto_business as imp_ent_conto_business,
    ie.imp_conto_privati as imp_ent_conto_privati,
    ie.imp_conto_famiglie as imp_ent_conto_famiglie
from cliente c
left join age a on c.id_cliente = a.id_cliente
left join tab_trans_uscita ttu  on c.id_cliente = ttu.id_cliente
left join tab_trans_entrata tte on c.id_cliente = tte.id_cliente
left join imp_trans_uscita itu  on c.id_cliente = itu.id_cliente
left join imp_trans_entrata ite  on c.id_cliente = ite.id_cliente
left join num_tot_conti ntc  on c.id_cliente = ntc.id_cliente
left join tipo_conti tc  on c.id_cliente = tc.id_cliente
left join num_trans_exit ntu  on c.id_cliente = ntu.id_cliente
left join num_trans_entrata nte  on c.id_cliente = nte.id_cliente
left join imp_uscita iu on c.id_cliente = iu.id_cliente
left join imp_entrata ie  on c.id_cliente = ie.id_cliente
order by c.id_cliente ASC;


select * from tabella;