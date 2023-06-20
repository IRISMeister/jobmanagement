# jobmanagement

# 導入方法
```bash
$ git clone https://github.com/IRISMeister/jobmanagement.git
$ cd jobmanagement/main
$ docker compose build
```
# 実行方法
```bash
$ docker compose up -d
```
管理ポータルにアクセスします。ユーザ名/パスワードは _SYSTEM/SYSです。

プロダクション画面  
http://localhost:9203/csp/job/EnsPortal.ProductionConfig.zen?$NAMESPACE=JOB&PRODUCTION=Task.Production1  

リモートでのタスク実行のターゲットとなるIRISサーバ#1  
http://localhost:9204/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK  

リモートでのタスク実行のターゲットとなるIRISサーバ#2  
http://localhost:9205/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK  

# 停止方法
```bash
$ docker compose stop
or
$ docker compose down
```
# 各ジョブの処理内容

共通事項として、BP/JobXは、タスクを呼び出す際には、BP/CallTaskに対してリクエストを出す、もしくはBP/CallTaskを実行する他のBPを呼び出すかのいずれかとなります。
## job01 

### 起動方法

[job01](../job/src/SysTask/job01.cls)は、コンテナ起動直後より[タスクマネージャ](http://localhost:9203/csp/sys/op/%25CSP.UI.Portal.TaskInfo.zen?$ID1=1000)->[BP/Direct](../job/src/Task/Service/Direct.cls)経由で5分間隔で自動実行されています。

### 処理内容

BP/CallTask経由でtask1(ターゲット:BO/Task1_REST,MyTask.NewClass1), task2(ターゲット:BO/Task1_REST,MyTask.NewClass2), task3(ターゲット:BO/Task2_REST,MyTask.NewClass3)を順番に同期実行。ただし、task3だけは遅延実行(taskインスタンス上でのタスクをJOBコマンドで実行し、遅延応答(トークン)を返却します)を行っています。

BO/Task1_RESTはRESTクライアントを使用して、IRISサーバ#1のRESTサービスを起動します。 その結果、IRISサーバ#1では[MyTask.NewClass1](../task/src/MyTask/NewClass1.cls)と[MyTask.NewClass2](../task/src/MyTask/NewClass2.cls)が、各々実行されます。その動作結果はグローバルに保存されます。 

BO/Task2_RESTはRESTクライアントを使用して、IRISサーバ#2のRESTサービスを起動します。 その結果、IRISサーバ#2では[MyTask.NewClass3](../task/src/MyTask/NewClass3.cls)が実行されます。その動作結果はグローバルに保存されます。 


```mermaid
sequenceDiagram

participant /TaskComplete
participant BS/Direct
participant BP/job01
participant BP/CallTask
participant BO/Task1_REST
participant BO/Task2_REST

BS/Direct->>+BP/job01: Request

BP/job01->>+BP/CallTask: Task1@BO/Task1_REST

BP/CallTask->>+BO/Task1_REST: invoke Task1

BO/Task1_REST->>+/Task1_REST/Task:REST Req
/Task1_REST/Task-->>-BO/Task1_REST:REST Resp
BO/Task1_REST-->>-BP/CallTask: Response
BP/CallTask-->>-BP/job01: Response

BP/job01->>+BP/CallTask: Task2@BO/Task1_REST
BP/CallTask->>+BO/Task1_REST: invoke Task2
BO/Task1_REST->>+/Task1_REST/Task:REST Req
/Task1_REST/Task-->>-BO/Task1_REST:REST Resp
BO/Task1_REST-->>-BP/CallTask: Response
BP/CallTask-->>-BP/job01: Response

BP/job01->>+BP/CallTask: Task3@BO/Task2_REST
BP/CallTask->>+BO/Task2_REST: Invoke Task3
BO/Task2_REST->>+/Task2_REST/Task:REST Req
/Task2_REST/Task->>+BG Job:Job Command
/Task2_REST/Task-->>-BO/Task2_REST:REST Resp(Immediate)
BO/Task2_REST-->>-BP/CallTask:Resp(Deffered)
BG Job->>-/TaskComplete:REST Req(Token)
activate /TaskComplete
/TaskComplete->>BP/CallTask:Deffered Resp(Token)
deactivate /TaskComplete
BP/CallTask-->>-BP/job01: Response

BP/job01-->>-BS/Direct: Response
```

### 処理結果

その結果、IRISサーバ#1(コンテナ task)上には、同一時刻帯に下記の2個(job01は5分ごとに自動起動されるので、時間経過とともに数は増えます)のグローバルが保存されます。

```
docker compose exec task1 iris session iris -UTASK
TASK>zw ^MyTask
^MyTask=30
^MyTask(1)=$lb("05/23/2023 12:30:00","MyTask.NewClass1","1","abc",0,"","","")
^MyTask(2)=$lb("05/23/2023 12:30:00","MyTask.NewClass2",1,"abc",0,"","","")
^MyTask(3)=$lb("05/23/2023 12:35:00","MyTask.NewClass1","18","abc",0,"","","")
^MyTask(4)=$lb("05/23/2023 12:35:00","MyTask.NewClass2",18,"abc",0,"","","")
^MyTask(5)=$lb("05/23/2023 12:40:00","MyTask.NewClass1","35","abc",0,"","","")
^MyTask(6)=$lb("05/23/2023 12:40:00","MyTask.NewClass2",35,"abc",0,"","","")
^MyTask(7)=$lb("05/23/2023 12:45:00","MyTask.NewClass1","52","abc",0,"","","")
^MyTask(8)=$lb("05/23/2023 12:45:00","MyTask.NewClass2",52,"abc",0,"","","")
```

その結果、IRISサーバ#2(コンテナ task2)上には、同一時刻帯に下記の1個(job01は5分ごとに自動起動されるので、時間経過とともに数は増えます)のグローバルが保存されます。

```
docker compose exec task2 iris session iris -UTASK

TASK>zw ^MyTask
^MyTask=15
^MyTask(1)=$lb("05/23/2023 12:30:00","MyTask.NewClass3",1,"abc",0,"","","")
^MyTask(2)=$lb("05/23/2023 12:35:00","MyTask.NewClass3",18,"abc",0,"","","")
^MyTask(3)=$lb("05/23/2023 12:40:00","MyTask.NewClass3",35,"abc",0,"","","")
^MyTask(4)=$lb("05/23/2023 12:45:00","MyTask.NewClass3",52,"abc",0,"","","")
```

## job02

> 以降のジョブのマニュアル起動および結果の確認作業は、job01の自動起動が有効のままだと分かりにくくなるので、いったん[タスクスケジュール](http://localhost:52873/csp/sys/op/%25CSP.UI.Portal.TaskSchedule.zen?$NAMESPACE=JOB&$NAMESPACE=JOB)でjob01を一時停止するのが良いです。

### 起動方法

```
$ docker compose exec job iris session iris -U job job02   (BP/job02)
```

### 処理内容

BP/job02aを非同期呼び出し後、指定された時間("PT5S", 5秒)だけBPを停止、その後,BP/job02bを非同期実行し、双方の完了を待つ。双方が正常終了した場合にのみ、task1(ターゲット:Task1_REST,MyTask.NewClass1)を起動する。  

BP/job02aはtask1(ターゲット:Task1_REST,MyTask.SlowTask)を実行します。  
> MyTask.SlowTaskは10秒間sleepして、時間がかかる処理を再現しています。

BP/job02bはtask1(ターゲット:Task1_REST,MyTask.FastTask)を実行します。  

下記のトレースにおいて、job02->job02aへのCallへの応答はその10秒後になっている(SlowTaskが10秒かかるため)こと、job02->job02bへのCall発生はjob02aへのコールの5秒後(PT5Sの指定による)となっていること(その応答は即時になっている)、job02->CallTaskへのCallは、双方が完了した後となっていることが確認出来ます。

![](images/job02.png)


### 処理結果

その結果、taskホスト(コンテナ)上には、下記の3個のグローバルが保存されます。
> タイムスタンプはタスクの完了時刻。

```
docker compose exec task1 iris session iris -UTASK
TASK>zw ^MyTask
^MyTask=3
^MyTask(1)=$lb("05/22/2023 14:58:04","MyTask.FastTask","1","abc",0,"","","")
^MyTask(2)=$lb("05/22/2023 14:58:09","MyTask.SlowTask","1","abc",0,"","","")
^MyTask(3)=$lb("05/22/2023 14:58:09","MyTask.NewClass1",1,"abc",0,"","","")
```

## job03

ほぼBP/job02と同じ処理ですが簡易版です。BP/job02はBP/job02a, BP/job02bの呼び出しを行っていますが、job03はBP/CallTaskを直接使用しています。

### 起動方法

```
$ docker compose exec job iris session iris -U job job03   (BP/job03)
```

### 処理内容

task1(ターゲット:BO/Task1_REST,MyTask.SlowTask), task2(ターゲット:BO/Task1_REST,MyTask.FastTask)を非同期(並列)で実行し、双方の完了を待つ。双方が正常終了した場合にのみ, task3(ターゲット:BO/Task1_REST,MyTask.NewClass1)を同期実行。

### 処理結果

その結果、taskホスト(コンテナ)上には、下記の3個のグローバルが保存されます。

```
docker compose exec task1 iris session iris -UTASK
TASK>zw ^MyTask
^MyTask(4)=$lb("05/22/2023 15:24:45","MyTask.FastTask","22","abc",0,"","","")
^MyTask(5)=$lb("05/22/2023 15:24:55","MyTask.SlowTask","22","abc",0,"","","")
^MyTask(6)=$lb("05/22/2023 15:24:55","MyTask.NewClass1",22,"abc",0,"","","")
```

## job04 

### 起動方法

```
$ docker compose exec job iris session iris -U job job04   (BP/job04)
```

job04はワークフローが介在します。そのためBPの処理は[ユーザポータル](http://localhost:9203/csp/job/_DeepSee.UserPortal.Home.zen)にて、人によるアクションがとられるまで保留されます。その結果、端末は応答待ち状態になります。

### 処理内容

BP/CallTask経由でtask1(ターゲット:BO/Task1_REST,MyTask.NewClass1)を同期実行します。その後、ワークフローを起動して、オペレータの指示待ち状態になります。指示が得られ次第、, task2(ターゲット:BO/Task1_REST,MyTask.NewClass2)を同期実行します。

![](images/wf1.png)

ワークフロー受信箱に届いているメッセージを選択し、その保留状態を解除すれば、処理が再開します。

### 処理結果

```
docker compose exec task1 iris session iris -UTASK
TASK>zw ^MyTask
^MyTask(3)=$lb("05/22/2023 16:18:12","MyTask.NewClass1","15","abc",0,"","","")
^MyTask(4)=$lb("05/22/2023 16:19:38","MyTask.NewClass2",15,"abc",0,"","","")
```

## forceError
### 起動方法

```
$ docker compose exec job iris session iris -U job forceError  (BP/job01)
```

### 処理内容

job01を使用しますが、forceErrorを使用すると、疑似的にアプリケーションレベルのエラーを発生させることができます。MyTask.NewTask2.cls内で強制的にゼロ除算エラーを発生させます。エラー情報は、ワークフローの要求に変換され、オペレータの指示待ち状態になります。そのため処理は、オペレータにより何らかのアクションがとられるまで保留されます。

![](images/wf2.png)

ワークフロー受信箱に届いているメッセージを選択し、対処方法を指示すれば、処理が再開します。

![](images/up.png)

対処の選択肢には、再実行(エラーが発生したコール、今回のケースではMyTask.NewTask2.clsを呼び出す2番目のBP/CallTask->Task1_RESTコール、から再実行する)、継続(エラーを無視して継続する、今回のケースではMyTask.NewTask3.clsを呼び出す、BP/CallTask->Task2_RESTコールから処理を継続する)、中止(残りの処理の実行を中止して、BP/job01を終了する)があります。

> 今回のゼロ除算エラーは何度実行しても発生するので、「継続」を選択します。これで先ほど保留されていたBPが再開し、次の処理(BO/Task2_RESTの呼び出し)に進み、端末に結果が表示されます。

```
output=6@Task.Response.CallJob  ; <OREF>
+----------------- general information ---------------
|      oref value: 6
|      class name: Task.Response.CallJob
|           %%OID: $lb("289","Task.Response.CallJob")
| reference count: 2
+----------------- attribute values ------------------
|       %Concurrency = 1  <Set>
|            EndTime = "2023-05-17 16:21:21"
|    JobErrorMessage = ""
|          JobStatus = "OK"
|          StartTime = "2023-05-17 16:09:59"
+-----------------------------------------------------
$
```
## 強制的なエラーの発生と管理アラート

特定のIRISサーバを停止することで、通信相手がダウンしている状況を発生させることが出来ます。

### 起動方法

```
$ docker compose exec task1 iris stop iris quietly
```
この場合、所定の回数リトライ後にBOがタイムアウトを起こし、[管理アラート](http://localhost:9203/csp/job/EnsPortal.ManagedAlerts.zen?$NAMESPACE=JOB&$NAMESPACE=JOB&)が発生します。

> 対処内容に応じて適宜、内容を更新することを想定した機能です。

![](images/alert1.png)

BPの処理については、先ほどと同様に、ユーザポータルでワークフロー受信箱に届いているメッセージを選択し、対処方法を指示すれば、処理が再開します。

## ファイル待ち

様々なファイル待ちのケース。

1. 単一ローカルファイル待ち
job05File
2. 複数ローカルファイル待ち
job06Files
3. 複数ローカルフォルダ待ち
job07Folders
4. 単一SFTPファイル待ち
job08RemoteFile
5. 複数SFTPファイル待ち
job09RemoteFiles
6. 複数SFTPフォルダ待ち(未完)
job10RemoteFolders

フォルダ待ちは割り切って、送信元がトリガとなるファイル(*.sem)を作成してくれるものとする。
理由：受信側で行うと、監視フォルダが増えると高くつく。FileWatcher的アプローチもダウン時に取りこぼしが生じるので不安定になる。
つまり、送信元が下記のようなファイルを作成することを期待する。

送信元A
folderA/1.txt
folderA/2.txt
folderA/3.txt
common/folderA.txt <=中身は空で良い。トリガファイル。これを監視する。
送信元B
folderB/1.txt
folderB/2.txt
common/folderB.txt <=中身は空で良い。トリガファイル。これを監視する。
送信元X
    ・
    ・
    ・
共通
common/folderA.txt
common/folderB.txt

これならcommon/をEnslib.Fileで監視するだけで済む。

各外部システム別に用意したFTPアカウント(sftp_user1など)が共通の場所(common/)を更新する必要が生じる。適切なアクセス権設定を要する。

# 単一ローカルファイル待ち

手元ファイルを外部にSFTPするなど(その他RESTでも何でも良い)をトリガに、その応答がしばらくしてから(非同期で)ローカルファイルにPutされるような連携を想定。

```
docker compose exec job iris session iris -UJOB job05File
```
あるいは、job05FileをSMPでTEST実行する。いずれもブロックされる。

下記のSQLで待ちファイルが登録されていることを確認で出来る。
```
SELECT FileName, Token FROM Task_Data.WaitFile
FileName	Token
/home/sftp_user1/incoming/in/100.res.txt    5|Task.Production1
```
待っているファイルを作成してあげることでブロック状態が解消される。ファイル名が一致していれば、内容は何でも良い。

1. 外部システムの動作を、task1からsftp経由でjobにファイルをputすることで再現する方法
```
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
sftp> put commit.txt incoming/in/100.res.txt
```

2. 待っているファイルを直接ローカルに作成する方法。
```
docker compose exec job bash -c 'echo "abc" > /home/sftp_user1/incoming/in/100.res.txt'
```

# 複数ローカルファイル待ち

```
docker compose exec job iris session iris -UJOB job06Files
```

1. 外部システムの動作を、task1からsftp経由でjobにファイルをputすることで再現する方法
```
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
sftp> put commit.txt incoming/in/100.res.txt
sftp> put commit.txt incoming/in/200.res.txt
```

2. 待っているファイル群を直接ローカルに作成する方法。
```
docker compose exec job bash -c 'echo "abc" > /home/sftp_user1/incoming/in/100.res.txt'
docker compose exec job bash -c 'echo "abc" > /home/sftp_user1/incoming/in/200.res.txt' 
```

# 複数ローカルフォルダ待ち

```
docker compose exec job iris session iris -UJOB job07Folders
```
このタイミングで、待ちフォルダが登録される
```
SELECT FolderName, Token FROM Task_Data.WaitFolder
FolderName	Token
/home/sftp_user1/incoming/folder1/	5|Task.Production1
/home/sftp_user2/incoming/folder1/	6|Task.Production1
```

1. 外部システムの動作を、task1およびtask2からsftp経由でjobにファイルをputすることで再現する方法

```
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
sftp> put commit.txt incoming/folder1/1.txt
sftp> put commit.txt incoming/folder1/2.txt
sftp> put commit.txt incoming/folder1/3.txt
sftp> put commit.txt incoming/folder1/4.txt
sftp> ! echo "/home/sftp_user1/incoming/folder1/" > done.sem
sftp> put done.sem incoming/common/done.sem
docker compose exec task2 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user2@job
sftp> put commit.txt incoming/folder1/1.txt
sftp> put commit.txt incoming/folder1/2.txt
sftp> put commit.txt incoming/folder1/3.txt
sftp> ! echo "/home/sftp_user2/incoming/folder1/" > done.sem
sftp> put done.sem incoming/common/done.sem
```

2. 待っているフォルダ群を直接ローカルに作成する方法。

```
./commit-files.sh
```

# 単一SFTPファイル待ち

```
docker compose exec job iris session iris -UJOB job08RemoteFile
```

アプリケーションによるファイルの作成を再現。
```
docker compose exec task1 bash -c 'echo "あいうえお" > /home/irisowner/outgoing/100.res.txt'
```

補足事項。Jobサーバからは下記のようにリモートファイルとして見える。
```
docker compose exec job sshpass -p "irisowner" sftp -o "StrictHostKeyChecking no" irisowner@task1
sftp> ls outgoing
outgoing/100.res.txt
```

# 複数SFTPファイル待ち

```
docker compose exec job iris session iris -UJOB job09RemoteFiles
```

アプリケーションによるファイルの作成を再現。
```
docker compose exec task1 bash -c 'echo "あいうえお" > /home/irisowner/outgoing/100.res.txt'
docker compose exec task2 bash -c 'echo "あいうえお" > /home/irisowner/outgoing/100.res.txt'
```

# 複数SFTPフォルダ待ち(未完)

```
docker compose exec job iris session iris -UJOB job10RemoteFolders
```

```
./commit-remotefiles.sh
```

------------------------------------------

使用可能なsftpユーザは下記の通り。
```
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user2@job
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user3@job
sftp> put commit.txt incoming/in/100.res.txt
```

# FTPの課題

異なるftpアカウント(外部システム)が共通のフォルダ(/home/irisowner/incoming/common)に出力する(できる)のは、あまり好ましくない。
(相互に破壊しかねない)

解決策

セマフォファイルの監視フォルダをシンボリックリンクで作成する
```
docker compose exec -u root job bash
$ ln -s /home/sftp_user/incoming/in /home/irisowner/incoming/common/sftp_user
$ ln -s /home/sftp_user1/incoming/in /home/irisowner/incoming/common/sftp_user1
$ ln -s /home/sftp_user2/incoming/in /home/irisowner/incoming/common/sftp_user2
$ ln -s /home/sftp_user3/incoming/in /home/irisowner/incoming/common/sftp_user3

docker compose exec job bash
$ ll /home/irisowner/incoming/common <=このサブフォルダを単一のBSによる監視対象とする
total 12
drwxr-xr-x 1 irisowner irisowner 4096 Jun  5 16:07 ./
drwxr-xr-x 1 irisowner irisowner 4096 Jun  5 15:10 ../
lrwxrwxrwx 1 root      root        27 Jun  5 16:07 sftp_user -> /home/sftp_user/incoming/in/
lrwxrwxrwx 1 root      root        28 Jun  5 16:03 sftp_user1 -> /home/sftp_user1/incoming/in/
lrwxrwxrwx 1 root      root        28 Jun  5 16:03 sftp_user2 -> /home/sftp_user2/incoming/in/
lrwxrwxrwx 1 root      root        28 Jun  5 16:07 sftp_user3 -> /home/sftp_user3/incoming/in/
$
```

(外部システムからの)ファイル群のPutは下記の要領で実行できる。
```
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
sftp> put commit.txt incoming/in/
docker compose exec task2 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user2@job
sftp> put commit.txt incoming/in/
```

(外部システムからの)セマフォファイルのPutは下記の要領で実行できる。
```
docker compose exec task1 sshpass -p "sftp_password" sftp -o "StrictHostKeyChecking no" sftp_user1@job
sftp> ! echo "/home/sftp_user1/incoming/folder1/" > done.sem
sftp> put done.sem incoming/common/done.sem
```

## ファイル送信
BP.JobSendFile
やりたいのはBPで作成したStreamContainerを使ってSFTPすること。
ステータスのやり取りをCallTaskと共通化したいので、SendFileというBPを作ったほうが良さげ。
Jobx 
-> Call SendFile
--> Stream作成や指定されたターゲット(この場合SFTPオペレーション)へのCall,応答(ヘッダのみ)からのステータス取得、
-> Call CallTask
