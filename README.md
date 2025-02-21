<h1 align="center">📖 README</h1>

クラスメイトとプレイするための統合版サーバーの構成情報を管理するリポジトリです｡

## 🔧 技術的なメモ

### 使用しているイメージ

サーバーは Docker を使用して構築しており､[itzg/minecraft-bedrock-server](https://hub.docker.com/r/itzg/minecraft-bedrock-server)を利用しています｡\
また､ワールドデータのバックアップには[kaieda/minecraft-bedrock-backup](https://hub.docker.com/r/kaiede/minecraft-bedrock-backup)を用いています｡

### サーバーに関して

| `項目名`                    | `設定値`           | `概要`                                                                                     |
| --------------------------- | ------------------ | ------------------------------------------------------------------------------------------ |
| `TZ`                        | `Asia/Tokyo`       | サーバーのタイムゾーン                                                                     |
| `EULA`                      | `TRUE`             | 利用規約への同意                                                                           |
| `SERVER_NAME`               | `4S Minecraft`     | サーバー選択時に表示されるテキスト                                                         |
| `GAMEMODE`                  | `survival`         | ゲームモード                                                                               |
| `FORCE_GAMEMODE`            | `true`             | クライアントで変更されたゲームモードを自戒接続時に強制的にサーバーのゲームモードと同期する |
| `DIFFICULTY`                | `normal`           | 難易度                                                                                     |
| `ALLOW_CHEATS`              | `false`            | チートコマンドを許可するか                                                                 |
| `MAX_PLAYERS`               | `50`               | プレイヤーの最大接続人数                                                                   |
| `ONLINE_MODE`               | `true`             | オンラインモード                                                                           |
| `ALLOW_LIST`                | `true`             | ホワイトリストを使用する                                                                   |
| `PLAYER_IDLE_TIMEOUT`       | `0`                | 放置プレイヤーの自動Kickを許可するか                                                       |
| `MAX_THREADS`               | `8`                | CPUの最大スレッド数                                                                        |
| `DEFAULT_PLAYER_PERMISSION` | `member`           | 参加したプレイヤーの規定の権限                                                             |
| `OPS`                       | `2535457866812073` | OP権限を付与するユーザー                                                                   |
| `OP_PERMISSION_LEVEL`       | `4`                | OP権限のレベル(Lv4ではサーバーの停止ができる)                                              |
| `LEVEL_NAME`                | `world`            | ワールドフォルダの名前                                                                     |
| `VERSION`                   | `LATEST`           | マイクラのバージョン｡`LATEST`の場合､コンテナ再起動時に自動的に更新する｡                    |

### 初回起動時

`setup.sh`を一応実行してください｡
