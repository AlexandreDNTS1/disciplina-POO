class Produto:
    def __init__(self, codigo, nome, preco):
        self.codigo = codigo
        self.nome = nome
        self.preco = preco

class Item:
    def __init__(self, produto, quantidade):
        self.produto = produto
        self.quantidade = quantidade

    def calcular_subtotal(self):
        return self.produto.preco * self.quantidade

class Venda:
    def __init__(self):
        self.itens = []

    def adicionar_item(self, item):
        self.itens.append(item)

    def calcular_total(self):
        total = 0
        for item in self.itens:
            total += item.calcular_subtotal()
        return total


# Exemplo de utilização:

# Criar produtos
produto1 = Produto(1, 'Camiseta', 29.90)
produto2 = Produto(2, 'Calça', 59.90)

# Criar itens
item1 = Item(produto1, 2)
item2 = Item(produto2, 1)

# Criar venda
venda = Venda()

# Adicionar itens à venda
venda.adicionar_item(item1)
venda.adicionar_item(item2)

# Calcular o total da venda
total_venda = venda.calcular_total()

print(f"O valor total da venda é: R$ {total_venda:.2f}")