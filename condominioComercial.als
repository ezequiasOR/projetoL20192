module condominioComercial

one sig Condominio{
  morador: set Morador,
  estacionamento: one Estacionamento

}

one sig Estacionamento {
  cancelas: some Cancela
}

sig Cancela {}

sig Morador {
}

fact existenciaCondominio {					// existe um condominio
  all c:Condominio | #(c) = 1
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
