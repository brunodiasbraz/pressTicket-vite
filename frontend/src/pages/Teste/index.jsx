import { Card } from "@material-ui/core";

const Teste = ({ wallet, cpf }) => {
  return (
    <Card>
      <h1>TESTE PRESSTICKET MODULE FEDERATION </h1>
      <h3>CARTEIRA: {wallet} </h3>
      <h5>CPF: {cpf} </h5>
    </Card>
  );
};

export default Teste;
