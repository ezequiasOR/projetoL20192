module condominioComercial

one sig Condominio{
  morador: set Morador,
  estacionamento: one Estacionamento
}

one sig Estacionamento {
  cancelas: some Cancela,
  veiculosEstac: some Veiculo
}

sig Cancela {}

abstract sig Pessoa {
  autorizacaoM: set AutorizacaoMorador,
  autorizacaoV: set AutorizacaoVisitante,
  veiculos: some Veiculo
}

sig Morador extends Pessoa {}

sig Visitante extends Pessoa {}

abstract sig Autorizacao{}

sig AutorizacaoMorador extends Autorizacao{}

sig AutorizacaoVisitante extends Autorizacao{}

sig Veiculo {}

fact todoVeiculoPertenceAUmaPessoa{
  all v: Veiculo | one v.~veiculos
}

fact todoMoradorPertenceAUmCondominio{
  all m: Morador | one m.~morador
}

fact qtdCancelas {							// a qtd de cancelas eh 2
  all e:Estacionamento | #(e.cancelas) = 2
}

fact todaAutMoradorPertenceAUmaPessoa{
    all a: AutorizacaoMorador | one a.~autorizacaoM
}

fact todaAutVisitantePertenceAUmaPessoa{
    all a: AutorizacaoVisitante | one a.~autorizacaoV
}

--fact qtdVagas {							// tem no minimo 0 vagas ocupadas e no maximo 30
--  all e:Estacionamento | #(e.veiculosEstac) > -1
--  all e:Estacionamento | #(e.veiculosEstac) < 31
--}

pred AutorizacaoMorador[m:Morador]{
    #m.autorizacaoM <= 1
    #m.autorizacaoV <= 0
}

pred AutorizacaoVisitante[v:Visitante]{
    #v.autorizacaoM <= 0
    #v.autorizacaoV <= 1
}

pred show[] {
}
run show
