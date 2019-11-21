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
  veiculos: some Veiculo
}

sig Morador extends Pessoa {}

sig Visitante extends Pessoa {}

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

--fact qtdVagas {							// tem no minimo 0 vagas ocupadas e no maximo 30
--  all e:Estacionamento | #(e.veiculosEstac) > -1
--  all e:Estacionamento | #(e.veiculosEstac) < 31
--}

pred show[] {
}
run show
