class Categoria {
  int codigo;
  String nome;

  Categoria(this.codigo, this.nome);
}

class ListaCategoria {
  List<Categoria> obtertodascategorias() {
    //Criar uma lista, mas depois poe acesso ao DAO
    final List<Categoria> _categorias = []..length = 2;
    final Categoria _categoria = null;

    _categoria.codigo = 1;
    _categoria.nome = 'Bebidas';
    _categorias.add(_categoria);

    _categoria.codigo = 2;
    _categoria.nome = 'Padaria';
    _categorias.add(_categoria);

    return _categorias;
  }
}
