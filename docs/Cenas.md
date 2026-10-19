# Cenas

## Cenas principais (Cenas/)

| Arquivo | Descrição |
|---------|-----------|
| `gameTileMap.tscn` | TileMap com TerrainLayer e SpikeLayer |
| `Player1.tscn` | Player 1 (CharacterBody2D + AnimatedSprite2D) |
| `Player2.tscn` | Player 2 (CharacterBody2D + AnimatedSprite2D) |
| `corda.tscn` | Corda (Node2D + Line2D) |
| `Escada.tscn` | Escada (Area2D + Sprite2D) - usada em algumas fases |
| `win_areas.tscn` | Áreas de vitória (2 Area2D) |

## Levels (Cenas/Levels/)

| Arquivo | Próximo nível |
|---------|--------------|
| `Level1.tscn` | Level2 |
| `Level2.tscn` | Level3 |
| `Level3.tscn` | Level4 |
| `Level4.tscn` | Level5 |
| `Level5.tscn` | Level6 |
| `Level6.tscn` | Level7 |
| `Level7.tscn` | Level8 |
| `Level8.tscn` | Level9 |
| `Level9.tscn` | Level10 |
| `Level10.tscn` | - (final) |

## Camera

`Script/camera_fit.gd` - Camera2D

Ajusta automaticamente o zoom e posição da câmera para encaixar os limites do TileMap.

- `margin` (exportado, padrão 1.1) - Margem ao redor do tilemap
- Calcula o bounding box de todas as TileMapLayers filhas de `../GameTileMap`
- Define `zoom` como o menor valor entre `viewport_width / (bounds_width * margin)` e `viewport_height / (bounds_height * margin)`
- Centraliza a câmera no centro do bounding box

## Estrutura de uma fase
```
Level (Node2D)
├── GameTileMap
│   ├── TerrainLayer (TileMapLayer)
│   └── SpikeLayer (TileMapLayer)
├── Player1
├── Player2
├── Corda
├── SpawnP1 (Marker2D)
├── SpawnP2 (Marker2D)
├── Camera2D (com camera_fit.gd)
├── WinAreas
│   ├── WinAreaP1 (Area2D)
│   └── WinAreaP2 (Area2D)
└── Escada (Area2D) — opcional, presente em algumas fases
```
