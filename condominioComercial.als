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

fun GetCondominioMorador[m:Morador]: one Condominio {
	morador.m
}

fun GetGaragemVisitado[v:Visitante]: one Estacionamento {
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

fact MoradorTemAteTresVeiculos{
	all m: Morador | #proprietario.m <= 3
}

fact VisitanteTemApenasUmCarro{
	all v: Visitante | #proprietario.v= 1
}

fact VeiculoEDeMoradorOuDeVisitante{
	all v: Veiculo | v in Estacionamento.vagasMoradores => !(v in  Estacionamento.vagasVisitantes)
}

pred show[] {
}
run show
