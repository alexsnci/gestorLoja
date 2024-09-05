unit uInterface.categorias;

interface
  uses System.JSON;
  type
    ICategorias = interface
        function get(valor:String):TJsonArray;
        function post(dados : String):String;
    end;

implementation

end.
