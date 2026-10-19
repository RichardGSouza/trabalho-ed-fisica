# Corda

`Script/corda.gd` - Node2D

Conecta os dois jogadores. Quando conectada, aplica força para mantê-los próximos.

## Constantes
- forca_maxima = 100
- forca_puxada = 100
- distancia_corda = 400

## Lógica
- Conectar: tecla "conectar corda" quando distância <= 200
- Se distância > 400: aplica força máxima nos dois
- Se um puxa: aplica força só no outro (distância > 60)
- Renderizada como Line2D entre os jogadores
