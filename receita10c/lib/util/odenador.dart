class Ordenador{

  

  List ordenarCervejasPorNomeCrescente(List cervejas){

    List cervejasOrdenadas = List.of(cervejas);

    bool trocouAoMenosUm;

    do{

      trocouAoMenosUm = false;

      for (int i=0; i<cervejasOrdenadas.length-1; i++){

        var atual = cervejasOrdenadas[i];

        var proximo = cervejasOrdenadas[i+1];

        if (atual["name"].compareTo(proximo["name"]) > 0){

          var aux = cervejasOrdenadas[i];

          cervejasOrdenadas[i] = cervejasOrdenadas[i+1];

          cervejasOrdenadas[i+1] = aux;

          trocouAoMenosUm = true;

        }

      }

    }while(trocouAoMenosUm);



    return cervejasOrdenadas;

  }



  List ordenarCervejasPorNomeDecrescente(List cervejas){

    List cervejasOrdenadas = List.of(cervejas);

    bool trocouAoMenosUm;

    do{

      trocouAoMenosUm = false;

      for (int i=0; i<cervejasOrdenadas.length-1; i++){

        var atual = cervejasOrdenadas[i];

        var proximo = cervejasOrdenadas[i+1];

        if (atual["name"].compareTo(proximo["name"]) > 0){

          var aux = cervejasOrdenadas[i];

          cervejasOrdenadas[i] = cervejasOrdenadas[i+1];

          cervejasOrdenadas[i+1] = aux;

          trocouAoMenosUm = true;

        }

      }

    }while(trocouAoMenosUm);



    return cervejasOrdenadas;

  }



  List ordenarCervejasPorEstiloCrescente(List cervejas){

    List cervejasOrdenadas = List.of(cervejas);

    bool trocouAoMenosUm;

    do{

      trocouAoMenosUm = false;

      for (int i=0; i<cervejasOrdenadas.length-1; i++){

        var atual = cervejasOrdenadas[i];

        var proximo = cervejasOrdenadas[i+1];

        if (atual["style"].compareTo(proximo["style"]) > 0){

          var aux = cervejasOrdenadas[i];

          cervejasOrdenadas[i] = cervejasOrdenadas[i+1];

          cervejasOrdenadas[i+1] = aux;

          trocouAoMenosUm = true;

        }

      }

    }while(trocouAoMenosUm);



    return cervejasOrdenadas;

  }



  List ordenarCervejasPorEstiloDecrescente(List cervejas){

    List cervejasOrdenadas = List.of(cervejas);

    bool trocouAoMenosUm;

    do{

      trocouAoMenosUm = false;

      for (int i=0; i<cervejasOrdenadas.length-1; i++){

        var atual = cervejasOrdenadas[i];

        var proximo = cervejasOrdenadas[i+1];

        if (atual["style"].compareTo(proximo["style"]) > 0){

          var aux = cervejasOrdenadas[i];

          cervejasOrdenadas[i] = cervejasOrdenadas[i+1];

          cervejasOrdenadas[i+1] = aux;

          trocouAoMenosUm = true;

        }

      }

    }while(trocouAoMenosUm);



    return cervejasOrdenadas;

  }

List ordenarFuderoso(List objetos, Decididor decididor){
    List objetosOrdenados = List.of(objetos);

    bool trocouAoMenosUm;

    do{

      trocouAoMenosUm = false;

      for (int i=0; i<objetosOrdenados.length-1; i++){

        var atual = objetosOrdenados[i];

        var proximo = objetosOrdenados[i+1];

        if ( decididor.precisaTrocarAtualPeloProximo(atual,proximo) ){

          var aux = objetosOrdenados[i];

          objetosOrdenados[i] = objetosOrdenados[i+1];

          objetosOrdenados[i+1] = aux;

          trocouAoMenosUm = true;

        }

      }

    }while(trocouAoMenosUm);



    return objetosOrdenados;

  }

}
abstract class Decididor{

  bool precisaTrocarAtualPeloProximo(dynamic atual, dynamic proximo);

}