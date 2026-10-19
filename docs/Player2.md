# Player 2

`Script/Player_2.gd` - CharacterBody2D

## Habilidade
Dash na direção que está olhando (DASH_SPEED = 1000, duração 0.3s)

## Constantes
- SPEED = 300
- GRAVITY = 1000
- JUMP_VELOCITY = -350
- ESCADA_VELOCIDADE = 150
- DASH_SPEED = 1000
- DASH_DURATION = 0.3

## Funções
- `resetarProSpawn()` - Volta ao spawn point (também reseta dash_timer e velocity)
- `morrer()` - Reseta os dois jogadores
- `checarColisaoEspinho()` - Verifica colisão com SpikeLayer
- `entrar_na_escada()` - Chamado ao entrar em uma escada (Area2D)
- `sair_da_escada()` - Chamado ao sair de uma escada (Area2D)
- `atualizarAnimacao(direction)` - Escolhe a animação conforme o estado

## Variáveis
- `forca_corda` - Força aplicada pela corda
- `direcao_olhando` - Direção do último movimento horizontal
- `na_escada` - Indica se o jogador está em uma escada (permite subir com pulo)
- `pode_dar_dash` - Controla se o dash está disponível (recarrega ao tocar o chão)
- `dash_timer` - Tempo restante do dash em andamento

## Animações
Usa `AnimatedSprite2D` com o recurso `sprites/garibaldo-verdinho/garibaldo_animations.tres`.

| Animação | Sprite |
|----------|--------|
| `idle` | `garibaldo-idle.png.png` |
| `walk` | `garibaldo-walking-sheet.png` (3 frames, extraída do `garibaldo-walking.gif`) |
| `jump` | `garibaldo-jump-sheet.png` (frames 0-1, extraída do `garibaldo-jump.gif`) |
| `fall` | `garibaldo-jump-sheet.png` (frame 2, extraída do `garibaldo-jump.gif`) |
| `dash` | `garibaldo-dash-sheet.png` (2 frames, extraída do `garibaldo-dash.gif`) |

A seleção é feita em `atualizarAnimacao(direction)`:
- durante o dash: `dash`
- no ar subindo: `jump`
- no ar caindo: `fall`
- no chão andando: `walk`
- parado: `idle`
