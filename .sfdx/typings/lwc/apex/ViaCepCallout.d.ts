declare module "@salesforce/apex/ViaCepCallout.buscarCEP" {
  export default function buscarCEP(param: {CEP: any}): Promise<any>;
}
declare module "@salesforce/apex/ViaCepCallout.atualizarEnderecoConta" {
  export default function atualizarEnderecoConta(param: {idConta: any, jsonResposta: any}): Promise<any>;
}
