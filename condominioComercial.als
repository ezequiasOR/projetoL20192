module condominioComercial

sig Condominio {
  morador: set Morador,
  estacionamento: one Estacionamento
}

sig Cancela {}

sig Morador {
  veiculos: some Veiculo
}

sig Estacionamento {
  veiculos: some Veiculo,
  cancelas: some Cancela
}

sig Veiculo {
 // autorizacao: one Autorizacao
}
/*
abstract sig Autorizacao{
  validade: some dias
}

sig AutorizacaoProprietario extends Autorizacao {
  validade: #dias = 30
}

sig AutorizacaoVisita extends Autorizacao {
  validade: #dias = 1
}
*/

fact existenciaCondominio {					// existe um condominio
  all c:Condominio | #(c) = 1
}

fact qtdCancelas {							// a qtd de cancelas eh 2
  all e:Estacionamento | #(e.cancelas) = 2
}

fact qtdVagas {							// tem no minimo 0 vagas ocupadas e no maximo 30
  all e:Estacionamento | #(e.veiculos) > 0
  all e:Estacionamento | #(e.veiculos) < 31
}

/*
assert testMoradorSemVeiculos {
  all m:Morador | #(m.veiculos) > 0
}

assert testMoradorMaxVeiculos {
  all m:Morador | #(m.veiculos) < 4
}

assert testCondonimioMinQtdVagasOcupadas {
  all c:Condominio | #(c.vagas) > -1
}

check testMoradorSemVeiculos
check testMoradorMaxVeiculos
check testCondonimioMinQtdVagasOcupadas

ALGUNS TESTES QUE FALTAM:

  - um veiculo so pode pertencer a um morador
  - um veiculo tem que ter um dono (um morador)

*/

pred show[] {
}
run show
