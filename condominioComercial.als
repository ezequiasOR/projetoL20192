module condominioComercial

sig Condominio {
	vagas: set Veiculo
}

sig Morador {
  veiculos: some Veiculo
}

sig Veiculo {}


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
