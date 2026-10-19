# Win Areas
Define as áreas que os player precisam estar pra vencer.
Checa e faz ação de vencer se ambos os players estão nas suas areas

Uma cena simples um node2D, ele tem 2 area2D (uma pra cada player) cada uma com uma collisionShape
Cada area 2D checa se o player dela esta dentro dela
Se as duas estiverem retornando true pro playerEstaNaArea o winAreas carrega o proximo nível

Variaveis exportadas
Proximo nivel: o nome da cena que deve ser carregado quando os jogadors vencem
