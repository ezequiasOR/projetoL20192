module condominioComercial

sig Portao {
  cancela: #cancela = 2
}

sig Morador {
  veiculos: some Veiculo
}

sig Estacionamento {
  veiculos: some Veiculo
  vaga: some Vagas
}

sig Veiculo {
  autorizacao: one Autorizacao
}

abstract Autorizacao{
  validade: some dias
}

sig AutorizacaoProprietario extends Autorizacao {
  validade: #dias = 30
}

sig AutorizacaoVisita extends Autorizacao {
  validade: #dias = 1
}

sig Condominio {
  morador: some Morador
  portao: one Portao
  estacionamento: one Estacionamento
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
