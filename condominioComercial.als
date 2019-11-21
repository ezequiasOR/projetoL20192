module condominioComercial

one sig Condominio{
  morador: set Morador,
  estacionamento: one Estacionamento
}

one sig Estacionamento {
  cancelas: some Cancela
}

sig Cancela {}

abstract sig Pessoa {
  veiculos: some Veiculo
}

sig Morador extends Pessoa {}

sig Visitante extends Pessoa {}

sig Veiculo {}

fact todoVeiculoPertenceAUmMorador{
  all v: Veiculo | one v.~veiculos
}

fact todaCancelaPertenceAUmEstacionamento{
  all c: Cancela | one c.~cancelas
}

fact todoMoradorPertenceAUmCondominio{
  all m: Morador | one m.~morador
}

fact qtdCancelas {							// a qtd de cancelas eh 2
  all e:Estacionamento | #(e.cancelas) = 2
}

pred show[] {
}
run show
