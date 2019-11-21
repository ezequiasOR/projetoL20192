# Projeto de Lógica para Computação - 2019.2

## Sistema controle de entrada e saida de veiculos

**Descrição:** Você precisa desenvolver um sistema de controle de entrada e saída de veículos de um condomínio comercial. O condomínio possui apenas um portão de entrada e saída, e os veículos que estejam entrando ou saindo utilizam esse mesmo portão. Um morador pode ter um ou mais veículos - no máximo 3;

Uma autorização é dada para veículos do proprietário (vale por um mês), e o proprietário pode receber visitas com autorização (1 dia).

O portão é composto por duas cancelas. De maneira que ao entrar ou sair da garagem os seguintes eventos devem ocorrer:

    - o motorista deve esperar a primeira cancela abrir;
    - depois de aberta, avançar o veículo até a segunda cancela;
    - esperar a primeira cancela fechar;
    - esperar a segunda cancela abrir;
    - avançar com o veículo para dentro ou para fora da garagem.

Como só é possível transitar pela entrada apenas um veículo por vez, o acesso ao portão deve ser controlado por um semáforo de entrada e um de saída. Além disso, o estacionamento tem um número limitado de vagas, e só é possível entrar no estacionamento caso haja vagas disponíveis.
