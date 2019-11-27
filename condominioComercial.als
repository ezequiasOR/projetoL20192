module condominioComercial

one sig Condominio{
	morador:		some Morador,
	portao:		one Portao,
	estacionamento:	one Estacionamento
}

one sig Portao {
	cancelaP:	one Cancela,			// primeira cancela
	cancelaS: 	one Cancela,			// segunda cancela
	semaforoE: 	one Semaforo,			// semaforo de entrada
	semaforoS:	one Semaforo			// semaforo de saida
}

sig Cancela {}

sig Semaforo {}

one sig Estacionamento {
	vagasMoradores:	 set Veiculo,
	vagasVisitantes:	 set Veiculo
}

sig Veiculo {
	proprietario: one Pessoa
}

abstract sig Pessoa {}

sig Morador extends Pessoa {}

sig Visitante extends Pessoa {
	visita: one Morador
}

abstract sig Autorizacao {}

sig AutorizacaoTrintaDias extends Autorizacao {
	veiculoMorador: one Veiculo
}

sig AutorizacaoUmDia extends Autorizacao {
	veiculoVisitante: one Veiculo
}

-- FUNCOES
fun GetCondominioMorador[m:Morador]: one Condominio {
	morador.m
}

fun GetEstacionamentoVisitado[v:Visitante]: one Estacionamento {
	GetCondominioMorador[v.visita].estacionamento
}

-- FACTS
fact todoMoradorPertenceAUmCondominio{
	all m:Morador | #morador.m = 1
}

fact cancelaPDifetenteDeCancelaS {
  all p:Portao | p.cancelaP != p.cancelaS
}

fact semaforoEDiferenteSemaforoS {
  all p:Portao | p.semaforoE != p.semaforoS
}

fact TodoSemaforoTaEmUmPortao {
  all s:Semaforo | s in Portao.semaforoE or s in Portao.semaforoS
}

fact TodaCancelaTaEmUmPortao {
  all c:Cancela | c in Portao.cancelaP or c in Portao.cancelaS
}

-- pode criar uma funcao que pega o morador que o visitante esta visitando
-- e fazer all v:Visitante | (#proprietario.v + #proprietario.(funcao) ) < 4
fact MoradorTemNoMinUmEAteTresVeiculos{
	all m: Morador | #proprietario.m > 0
	all m: Morador | #proprietario.m < 4
--	all v:Visitante | some m: Morador | (#proprietario.v + #proprietario.m) < 4
}

fact VisitanteTemApenasUmCarro{
	all v: Visitante | #proprietario.v= 1
}

fact VeiculoEDeMoradorOuDeVisitante{
	all v: Veiculo | v in Estacionamento.vagasMoradores => !(v in  Estacionamento.vagasVisitantes)
}

fact TodoVeiculoEstaNoEstacionamento {
	all m:Morador | proprietario.m in Estacionamento.vagasMoradores
	all v:Visitante | proprietario.v in Estacionamento.vagasVisitantes
}

fact todoVeiculoMorTemUmaAutoDeTrintaDias{
	all v:Veiculo | v in AutorizacaoTrintaDias.veiculoMorador => v.proprietario in  Condominio.morador
}

fact todoVeiculoVisTemUmaAutoDeUmDia{
	all v:Veiculo | v in AutorizacaoUmDia.veiculoVisitante => !(v.proprietario in  Condominio.morador)
}

fact todoVeiculoTemApenasUmaAutorizacao{
	all v:Veiculo | v in AutorizacaoTrintaDias.veiculoMorador or v in AutorizacaoUmDia.veiculoVisitante
}

fact AutorizacaoTemApenasUmVeiculo{
	all atd: AutorizacaoTrintaDias | #atd.veiculoMorador = 1
	all aud: AutorizacaoUmDia | #aud.veiculoVisitante = 1
	all vm: Veiculo | #veiculoMorador.vm <= 1
	all vv: Veiculo | #veiculoVisitante.vv <= 1
}

-- ASSERTS
assert visitanteTemApenasUmCarro{
	all v: Visitante | #proprietario.v= 1
}

assert moradorTemNoMinUmEAteTresVeiculos{
	all m: Morador | #proprietario.m > 0
	all m: Morador | #proprietario.m < 4
--	all v:Visitante | some m: Morador | (#proprietario.v + #proprietario.m) < 4 
}

assert veiculoEDeMoradorOuEDeVisitante{
	all v: Veiculo | v in Estacionamento.vagasMoradores => !(v in  Estacionamento.vagasVisitantes)
}

assert veiculoNaoEVisitanteEDeMorador {
	all e1:Estacionamento | all e2:Estacionamento | !(e1 = e2) => #(e2.vagasVisitantes & e1.vagasMoradores) = 0
}

assert todaCancelaEstaEmUmPortao {
	all c:Cancela | c in Portao.cancelaS or c in Portao.cancelaP
}

assert primeiraCancelaEDiferenteDaSegundaCancela{
	all p: Portao | p.cancelaP != p.cancelaS
}

assert veiculoTemApenasUmProprietario{
	all v: Veiculo | one v.proprietario
}

assert condominioTemApenasUmEstacionamento{
	all c: Condominio | one c.estacionamento 
}

assert condominioTemPeloMenosUmMorador{
	all c: Condominio | some c.morador
}

assert estacionamentoExisteApenasNoCondominio{
	all g: Estacionamento | #estacionamento.g = 1
}

assert condominioTemApenasUmPortao{
	all c: Condominio | one c.portao 
}

assert todoMoradorEstaEmUmCondominio {
	all m:Morador | #morador.m = 1
}

assert todoSemaforoEstaEmUmPortao {
	all s:Semaforo | s in Portao.semaforoE or s in Portao.semaforoS
}

assert semaforoDaEntradaEDiferenteDoSemaforoDaSaida{
	all p: Portao | p.semaforoE != p.semaforoS
}
/*
-- CHECKS
check visitanteTemApenasUmCarro for 30
check moradorTemNoMinUmEAteTresVeiculos for 30
check veiculoEDeMoradorOuEDeVisitante for 30
check veiculoNaoEVisitanteEDeMorador for 30
check todaCancelaEstaEmUmPortao for 30
check primeiraCancelaEDiferenteDaSegundaCancela for 30
check veiculoTemApenasUmProprietario for 30
check condominioTemApenasUmEstacionamento for 30
check condominioTemPeloMenosUmMorador for 30
check estacionamentoExisteApenasNoCondominio for 30
check condominioTemApenasUmPortao for 30
check todoMoradorEstaEmUmCondominio for 30
check todoSemaforoEstaEmUmPortao for 30
check semaforoDaEntradaEDiferenteDoSemaforoDaSaida for 30
*/
pred show[] {
}
run show
