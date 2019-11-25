module condominioComercial

one sig Condominio{
	morador:		some Morador,
	portao:		one Portao,
	estacionamento:	one Estacionamento
}

one sig Portao {
	cancelaE:	one Cancela,				// cancela de entrada 
	cancelaS: 	one Cancela,				// cancela de saida
	semaforoE: 	one Semaforo,				// semaforo de entrada
	semaforoS:	one Semaforo				// semaforo de saida
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

fun GetCondominioMorador[m:Morador]: one Condominio {
	morador.m
}

fun GetEstacionamentoVisitado[v:Visitante]: one Estacionamento {
	GetCondominioMorador[v.visita].estacionamento
}

fact todoMoradorPertenceAUmCondominio{
	all m:Morador | #morador.m = 1
}

fact cancelaEDifetenteDeCancelaS {
  all p:Portao | p.cancelaE != p.cancelaS
}

fact semaforoEDiferenteSemaforoS {
  all p:Portao | p.semaforoE != p.semaforoS
}

fact TodoSemaforoTaEmUmPortao {
  all s:Semaforo | s in Portao.semaforoE or s in Portao.semaforoS
}

fact TodaCancelaTaEmUmPortao {
  all c:Cancela | c in Portao.cancelaE or c in Portao.cancelaS
}

fact MoradorTemNoMinUmEAteTresVeiculos{
	all m: Morador | #proprietario.m > 0
	all m: Morador | #proprietario.m < 4
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

-- TODO: FALTA OS ASSERTS AQUI

pred show[] {
}
run show
