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

check testMoradorSemVeiculos

TESTES QUE FALTAM:

  - um veiculo so pode pertencer a um morador
  - um morador pode ter no max 3 veiculos
  - um veiculo tem que ter um dono (um morador)

*/

pred show[] {
}
run show
