<h1 align="center">📖 README</h1>

クラスメイトとプレイするための統合版サーバーの構成情報を管理するリポジトリです｡

## 🔧 技術的なメモ

### How to setup

1. [公式サイト](https://www.minecraft.net/ja-jp/download/server/bedrock)より､**Linux用**のサーバーソフトウェアをダウンロードする｡

2. ダウンロードしたファイルを解凍する｡

   ```bash
    unzip bedrock-server-1.21.61.01.zip -d server
   ```

3. 必要に応じて､ワールドデータなどを移行する｡

### MC CLI Usage

MC CLIは､マイクラ鯖の管理を容易にするためのシェルスクリプトです｡以下のようにして利用できます｡

```bash
./mc.sh help  # ヘルプを表示
./mc.sh start # サーバーを起動
./mc.sh stop  # サーバーを停止
```

### Backup Scipt

`backup.sh`というスクリプトを実行することでワールドのバックアップを行うことができます｡

```bash
./backup.sh # バックアップをbackupsディレクトリに作成します｡
```
